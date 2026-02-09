"""
Cortex Analyst App - XBot Version
====================================
This app allows users to interact with their data using natural language.
Includes a security layer to hide SQL based on user permissions.
"""
import json
import time
from datetime import datetime
from typing import Dict, List, Optional, Tuple, Union

import _snowflake
import pandas as pd
import streamlit as st
from snowflake.snowpark.context import get_active_session
from snowflake.snowpark.exceptions import SnowparkSQLException

# --- Configuration ---
AVAILABLE_SEMANTIC_MODELS_PATHS = [
    "QA_BI.PUBLIC.SEMANTIC_QA_STAGE/OUTBOUND.yaml"
]
API_ENDPOINT = "/api/v2/cortex/analyst/message"
FEEDBACK_API_ENDPOINT = "/api/v2/cortex/analyst/feedback"
API_TIMEOUT = 50000  # in milliseconds

# Initialize Snowflake session
session = get_active_session()

# -----------------------------------
# PERMISSION CHECK LOGIC
# -----------------------------------
def check_query_visibility() -> bool:
    """
    Checks the user's permissions in Snowflake.
    Returns False if there is an active record with IS_QUERY_SHOWN = False 
    for the current user.
    """
    check_sql = """
        SELECT COUNT(*) 
        FROM QA_BI.PERMISSIONS.ROLE_COMPANY_GROUP 
        WHERE USERNAME = CURRENT_USER() 
          AND IS_ACTIVE = TRUE 
          AND IS_QUERY_SHOWN = FALSE
    """
    try:
        # We execute the query to check restrictions for the current logged-in user
        res = session.sql(check_sql).collect()
        # If count > 0, a restriction exists, so we return False (hide)
        if res and res[0][0] > 0:
            return False
        return True
    except Exception:
        # For security, if the permission check fails, we hide the SQL
        return False

# -----------------------------------
# CORE APP FUNCTIONS
# -----------------------------------
def main():
    if "messages" not in st.session_state:
        reset_session_state()
    
    show_header_and_sidebar()
    
    if len(st.session_state.messages) == 0:
        process_user_input("What questions can I ask?")
    
    display_conversation()
    handle_user_inputs()
    handle_error_notifications()
    display_warnings()

def reset_session_state():
    st.session_state.messages = []
    st.session_state.active_suggestion = None
    st.session_state.warnings = []
    st.session_state.form_submitted = {}

def show_header_and_sidebar():
    st.title("XBot")
    st.markdown("Welcome to XBot Analyst! Type your questions below to interact with your data.")

    with st.sidebar:
        st.selectbox(
            "Selected semantic model:",
            AVAILABLE_SEMANTIC_MODELS_PATHS,
            format_func=lambda s: s.split("/")[-1],
            key="selected_semantic_model_path",
            on_change=reset_session_state,
        )
        st.divider()
        _, btn_container, _ = st.columns([2, 6, 2])
        if btn_container.button("Clear Chat History", use_container_width=True):
            reset_session_state()

def handle_user_inputs():
    user_input = st.chat_input("What is your question?")
    if user_input:
        process_user_input(user_input)
    elif st.session_state.active_suggestion is not None:
        suggestion = st.session_state.active_suggestion
        st.session_state.active_suggestion = None
        process_user_input(suggestion)

def handle_error_notifications():
    if st.session_state.get("fire_API_error_notify"):
        st.toast("An API error has occurred!", icon="🚨")
        st.session_state["fire_API_error_notify"] = False

def process_user_input(prompt: str):
    st.session_state.warnings = []
    new_user_message = {
        "role": "user",
        "content": [{"type": "text", "text": prompt}],
    }
    st.session_state.messages.append(new_user_message)
    
    with st.chat_message("user"):
        display_message(new_user_message["content"], len(st.session_state.messages) - 1)

    with st.chat_message("analyst"):
        with st.spinner("Waiting for Analyst's response..."):
            time.sleep(1)
            response, error_msg = get_analyst_response(st.session_state.messages)
            if error_msg is None:
                analyst_message = {
                    "role": "analyst",
                    "content": response["message"]["content"],
                    "request_id": response["request_id"],
                }
            else:
                analyst_message = {
                    "role": "analyst",
                    "content": [{"type": "text", "text": error_msg}],
                    "request_id": response.get("request_id", "N/A"),
                }
                st.session_state["fire_API_error_notify"] = True

            if "warnings" in response:
                # This filters out the "Verified query" and "Model size" warnings
                st.session_state.warnings = [
                    w for w in response["warnings"] 
                    if "Verified query" not in w.get("message", "") 
                    and "semantic model is larger" not in w.get("message", "")
                    and "Your request" not in w.get("message", "")
                ]

            st.session_state.messages.append(analyst_message)
            st.rerun()

def get_analyst_response(messages: List[Dict]) -> Tuple[Dict, Optional[str]]:
    request_body = {
        "messages": messages,
        "semantic_model_file": f"@{st.session_state.selected_semantic_model_path}",
    }

    resp = _snowflake.send_snow_api_request(
        "POST", API_ENDPOINT, {}, {}, request_body, None, API_TIMEOUT
    )
    parsed_content = json.loads(resp["content"])

    if resp["status"] < 400:
        return parsed_content, None
    else:
        error_msg = f"""
🚨 An Analyst API error has occurred 🚨
* response code: `{resp['status']}`
* request-id: `{parsed_content.get('request_id')}`
* error code: `{parsed_content.get('error_code')}`

Message:
    {parsed_content.get('message')}
"""
        return parsed_content, error_msg

def display_conversation():
    for idx, message in enumerate(st.session_state.messages):
        role = message["role"]
        content = message["content"]
        with st.chat_message(role):
            if role == "analyst":
                display_message(content, idx, message.get("request_id"))
            else:
                display_message(content, idx)

def display_message(content: List[Dict], message_index: int, request_id: Optional[str] = None):
    for item in content:
        if item["type"] == "text":
            st.markdown(item["text"])
        elif item["type"] == "suggestions":
            for s_idx, suggestion in enumerate(item["suggestions"]):
                if st.button(suggestion, key=f"sugg_{message_index}_{s_idx}"):
                    st.session_state.active_suggestion = suggestion
        elif item["type"] == "sql":
            display_sql_query(item["statement"], message_index, item.get("confidence"), request_id)

@st.cache_data(show_spinner=False)
def get_query_exec_result(query: str) -> Tuple[Optional[pd.DataFrame], Optional[str]]:
    try:
        df = session.sql(query).to_pandas()
        return df, None
    except SnowparkSQLException as e:
        return None, str(e)

# -----------------------------------
# MODIFIED SQL DISPLAY WITH PERMISSIONS
# -----------------------------------
def display_sql_query(sql: str, message_index: int, confidence: dict, request_id: Optional[str] = None):
    # --- PERMISSION CHECK ---
    can_show_sql = check_query_visibility()
    
    if can_show_sql:
        with st.expander("SQL Query", expanded=False):
            st.code(sql, language="sql")
            if confidence:
                display_sql_confidence(confidence)
    #else:
        
    #    st.info("🔒 SQL query preview is restricted based on your permissions.")

    # --- RESULTS SECTION ---
    with st.expander("Results", expanded=True):
        with st.spinner("Running SQL..."):
            df, err_msg = get_query_exec_result(sql)
            if df is None:
                st.error(f"Execution Error: {err_msg}")
            elif df.empty:
                st.write("No data found.")
            else:
                data_tab, chart_tab = st.tabs(["Data 📄", "Chart 📉"])
                with data_tab:
                    st.dataframe(df, use_container_width=True)
                with chart_tab:
                    display_charts_tab(df, message_index)
    
    if request_id:
        display_feedback_section(request_id)

def display_sql_confidence(confidence: dict):
    if confidence is None:
        return
    verified_query = confidence.get("verified_query_used")
    with st.popover("Verified Query Info"):
        if not verified_query:
            st.text("No verified query template used.")
        else:
            st.text(f"Name: {verified_query['name']}")
            st.text(f"Question: {verified_query['question']}")
            st.code(verified_query["sql"], language="sql")

def display_charts_tab(df: pd.DataFrame, message_index: int):
    if len(df.columns) >= 2:
        col1, col2 = st.columns(2)
        x_col = col1.selectbox("X axis", df.columns, key=f"x_{message_index}")
        y_col = col2.selectbox("Y axis", [c for c in df.columns if c != x_col], key=f"y_{message_index}")
        chart_type = st.selectbox("Type", ["Line Chart", "Bar Chart"], key=f"type_{message_index}")
        
        if "Line" in chart_type:
            st.line_chart(df.set_index(x_col)[y_col])
        else:
            st.bar_chart(df.set_index(x_col)[y_col])
    else:
        st.write("Insufficient columns for charting.")

def display_feedback_section(request_id: str):
    with st.popover("📝 Feedback"):
        if request_id not in st.session_state.form_submitted:
            with st.form(f"fb_{request_id}"):
                pos = st.radio("Rate SQL", ["👍", "👎"], horizontal=True) == "👍"
                msg = st.text_input("Comments")
                if st.form_submit_button("Submit"):
                    err = submit_feedback(request_id, pos, msg)
                    st.session_state.form_submitted[request_id] = {"error": err}
                    st.rerun()
        else:
            status = st.session_state.form_submitted[request_id]
            if status["error"] is None:
                st.success("Feedback sent!")
            else:
                st.error(status["error"])

def submit_feedback(request_id: str, positive: bool, message: str) -> Optional[str]:
    body = {"request_id": request_id, "positive": positive, "feedback_message": message}
    resp = _snowflake.send_snow_api_request("POST", FEEDBACK_API_ENDPOINT, {}, {}, body, None, API_TIMEOUT)
    return None if resp["status"] == 200 else "Failed to submit feedback."

def display_warnings():
    for warning in st.session_state.warnings:
        st.warning(warning["message"], icon="⚠️")

if __name__ == "__main__":
    main()