-----| Creation DB
CREATE DATABASE QA_BI
comment='QA database Bussines Intelligence';
CREATE SCHEMA QA_BI.WM
comment='Schema of WM in QA';
CREATE SCHEMA QA_BI.DTS
comment='Schema of DTS in QA';
CREATE SCHEMA QA_BI.LS
comment='Schema of LS in QA';
CREATE SCHEMA QA_BI.XBADMIN
comment='Schema of XBADMIN in QA';
CREATE SCHEMA QA_BI.SIQC
comment='Schema of SIQC in QA';
CREATE SCHEMA QA_BI.MIF
comment='Schema of MIF in QA';
CREATE SCHEMA QA_BI.ZOE
comment='Schema of ZOE in QA';
CREATE SCHEMA QA_BI.POWER_BI
comment='Schema of POWER_BI in QA';
CREATE SCHEMA QA_BI.GOOGLE_SHEETS
comment='Schema of GOOGLE_SHEETS in QA';
CREATE SCHEMA QA_BI.PERMISSIONS
comment='Schema of PERMISSIONS in QA';
-- CREATE SCHEMA QA_BI.PINGBOARD;

-----| Clone VW_KPI_TRANSPORTATION

create or replace view QA_BI.WM.VW_KPI_TRANSPORTATION
as
        SELECT * FROM BI.WM.VW_KPI_TRANSPORTATION;

-----| Create ORDERS
CREATE OR REPLACE VIEW QA_BI.WM.VW_ORDERS
    AS
        SELECT 
        o.tc_order_id,
        o.order_id,
        o.ref_field_4,
        o.REF_FIELD_7,
        o.d_country_code,
        o.d_state_prov,
        o.d_city,
        o.d_postal_code,
        o.d_name,
        o.d_address_1,
        o.d_address_2,
        o.d_address_3,
        o.d_email,
        o.d_phone_number,
        o.ref_field_2,
        o.ref_field_10,
        o.created_dttm,
        o.delivery_end_dttm,
        o.do_status,
        o.tc_company_id,
        o.order_type,
        o._fivetran_deleted
        FROM WM.GOLD.ORDERS o
        UNION ALL
        SELECT 
        o.tc_order_id,
        o.order_id,
        o.ref_field_4,
        o.REF_FIELD_7,
        o.d_country_code,
        o.d_state_prov,
        o.d_city,
        o.d_postal_code,
        o.d_name,
        o.d_address_1,
        o.d_address_2,
        o.d_address_3,
        o.d_email,
        o.d_phone_number,
        o.ref_field_2,
        o.ref_field_10,
        o.created_dttm,
        o.delivery_end_dttm,
        o.do_status,
        o.tc_company_id,
        o.order_type,
        o._fivetran_deleted
        FROM WM.SILVER.ORDERS o
        UNION ALL
        SELECT 
        o.tc_order_id,
        o.order_id,
        o.ref_field_4,
        o.REF_FIELD_7,
        o.d_country_code,
        o.d_state_prov,
        o.d_city,
        o.d_postal_code,
        o.d_name,
        o.d_address_1,
        o.d_address_2,
        o.d_address_3,
        o.d_email,
        o.d_phone_number,
        o.ref_field_2,
        o.ref_field_10,
        o.created_dttm,
        o.delivery_end_dttm,
        o.do_status,
        o.tc_company_id,
        o.order_type,
        o._fivetran_deleted
        FROM WM.RY.ORDERS o
        ;

-----| Create LPN
CREATE OR REPLACE VIEW QA_BI.WM.VW_LPN
    AS
        SELECT 
        l.order_id,
        l.tc_company_id,
        l.tracking_nbr,
        l.tc_lpn_id,
        l.weight,
        l.actual_volume,
        l.tc_parent_lpn_id,
        l.shipped_dttm,
        l.inbound_outbound_indicator,
        l.created_dttm,     
        l.ship_via,
        l.length,
        l.width,
        l.height,
        l.estimated_volume,
        l.estimated_weight,
        l.total_lpn_qty,
        l.last_updated_dttm,
        l.tc_shipment_id,  
        l.actual_charge,
        l._FIVETRAN_DELETED
        FROM WM.GOLD.LPN l
        UNION ALL
        SELECT 
        l.order_id,
        l.tc_company_id,
        l.tracking_nbr,
        l.tc_lpn_id,
        l.weight,
        l.actual_volume,
        l.tc_parent_lpn_id,
        l.shipped_dttm,
        l.inbound_outbound_indicator,
        l.created_dttm,     
        l.ship_via,
        l.length,
        l.width,
        l.height,
        l.estimated_volume,
        l.estimated_weight,
        l.total_lpn_qty,
        l.last_updated_dttm,
        l.tc_shipment_id,  
        l.actual_charge,
        l._FIVETRAN_DELETED
        FROM WM.SILVER.LPN l
        UNION ALL
        SELECT 
        l.order_id,
        l.tc_company_id,
        l.tracking_nbr,
        l.tc_lpn_id,
        l.weight,
        l.actual_volume,
        l.tc_parent_lpn_id,
        l.shipped_dttm,
        l.inbound_outbound_indicator,
        l.created_dttm,     
        l.ship_via,
        l.length,
        l.width,
        l.height,
        l.estimated_volume,
        l.estimated_weight,
        l.total_lpn_qty,
        l.last_updated_dttm,
        l.tc_shipment_id,  
        l.actual_charge,
        l._FIVETRAN_DELETED
        FROM WM.RY.LPN l
        ;

-----| Create WM_INVENTORY
CREATE VIEW QA_BI.WM.VW_WM_INVENTORY
AS
    SELECT 
    *
    FROM WM.GOLD.WM_INVENTORY
    UNION ALL
    SELECT 
    *
    FROM WM.SILVER.WM_INVENTORY
    UNION ALL
    SELECT 
    *
    FROM WM.RY.WM_INVENTORY
    ;
    
-----| Create ITEM_CBO
CREATE VIEW QA_BI.WM.VW_ITEM_CBO
AS
    SELECT
    *
    FROM WM.GOLD.ITEM_CBO
    UNION ALL
    SELECT
    *
    FROM WM.SILVER.ITEM_CBO
    UNION ALL
    SELECT
    *
    FROM WM.RY.ITEM_CBO
    ;

-----| Create DO_STATUS
CREATE VIEW QA_BI.WM.VW_CAT_DOSTATUS
    AS
        SELECT 
        DO_STATUS,
        STATUS
        FROM BI.WM.CAT_DOSTATUS;
    

-----| Create LS
create or replace view QA_BI.LS.VW_LATESHIPMENT 
as
WITH Latest_LS AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY trackingnumber
            ORDER BY _MODIFIED DESC
        ) AS row_num
    FROM LS.LS.LS
),
Filtered_LS AS (
    SELECT *
    FROM Latest_LS
    WHERE row_num = 1
),
Flattened_Events AS (
    SELECT
        l.trackingnumber,
        l.OVERLABLEDTRACKINGNUMBER AS OVERLABELED_TN,
        l.CARRIER_TYPE,
        l.SERVICETYPE,
        TO_VARCHAR(l.SHIPDATE) AS SHIPDATE,
        TO_VARCHAR(l.PICKEDUPDATE) AS ORIGIN_SCAN,
        TO_VARCHAR(l.ESTIMATEDDATE) AS ESTIMATEDDATE,
        TO_VARCHAR(l.INTRANSITDATE) AS INTRANSITDATE,
        TO_VARCHAR(l.OUTFORDELIVERYDATE) AS OUTFORDELIVERYDATE,
        TO_VARCHAR(l.DELIVERYDATE) AS DELIVERYDATE,
        l.SHOPIFYORDERNUMBER,
        ROW_NUMBER() OVER (
            PARTITION BY l.trackingnumber,
                         f.value:Datetime,
                         f.value:Location,
                         f.value:SeqNumb,
                         f.value:Status,
                         f.value:events
            ORDER BY l._FIVETRAN_SYNCED DESC
        ) AS MAX_INSERT,
        f.value:Datetime::STRING AS TIMESTAMP,
        f.value:Location::STRING AS LOCATION,
        f.value:Status::STRING AS STATUS,
        f.value:events::STRING AS EVENT,
        TO_VARCHAR(l.deliveryattempteddate) AS DELIVERYATTEMPTED,
        TO_VARCHAR(l.SUSPECTED_LOST) AS SUSPECTED_LOST,
        TO_VARCHAR(l.ESTIMATEDDAYS) AS ESTIMATEDDAYS
    FROM Filtered_LS l,
         TABLE(FLATTEN(l.EVENTS)) f
)
SELECT *
FROM Flattened_Events
WHERE MAX_INSERT = 1
  AND STATUS NOT IN ('Label Created');
  
-----| Create DTS
create or replace view QA_BI.DTS.VW_DTS
 as 
    SELECT
		_FIVETRAN_ID
        ,COALESCE(ID, REFERENCEID) AS D_MATCHED_ID
		,TRACKINGSTATUSLABEL
		,CLOSEID
		,ALTTRACKINGNUMBER
		,CAST(PACKAGEITEMTOTALQUANTITY AS FLOAT) PACKAGEITEMTOTALQUANTITY
		,ACCOUNTNUMBER
		,CAST(CHANNELID AS FLOAT) CHANNELID
		,BASECARRIERCODE
		,CARRIERINSURANCECHARGE
		,MARKETID
		,HOST
		,ORIGINCOMPANY
		,DIMLENGTH
		,ESTIMATEDDELIVERYDATE
		,CUSTOMID
		,SHIPTOADDRESS3
		,SHIPZONE
		,SHIPTOADDRESS2
		,SPLIT_PART (CARRIER, ' ', 1) AS Carrier 
        ,CARRIER AS Carrier_Service
		,PACKAGECHARGEATRATING
		,SHIPTOADDRESS1
		,BOXNAME
		,SUBACCOUNTNUMBER
		,CAST(ORDERID AS FLOAT) ORDERID
		,STATUS
		,CARRIERBILLINGTYPE
		,SHIPTYPE
		,SURCHARGECHARGE
		,APPLIEDCHARGETYPE
		,USERNAME
		,ID
		,WORKSTATION
		,TRACKINGEVENTDATE
		,CUSTOMREF2
		,CUSTOMREF3
		,SHIPTOCITY
		,PRIVATEINSURANCEAMOUNT
		,LASTPRINTDATE
		,MARKETSHIPMETHOD
		,DRYICEWEIGHT
		,ORDERTYPE
		,CREATEDATE
		,TRACKINGEVENTDESCRIPTION
		,SHIPTOSTATEORPROVINCE
		,FUELCHARGE
		,ORIGINSTATEORPROVINCE
		,DEPARTMENT
		,PRIVATEINSURANCECHARGE
		,BATCHID
		,DELIVERYAREACHARGE
		,CURRENCYCODEISO
		,CAST(STATUSID AS FLOAT) STATUSID
		,ORIGINCITY
		,ACTUALWEIGHT
		,CAST(ORDERCOUNT AS FLOAT) ORDERCOUNT
		,CARRIERINSURANCEAMOUNT
		,SHIPTOCOMPANY
		,UPDATEDATE
		,SHIPROUTE
		,CAST(SHIPPINGPROFILEID AS FLOAT) SHIPPINGPROFILEID
		,CUSTOMREF1
		,TOTALCHARGE
		,USPSPROVIDERTYPE
		,TRACKINGEVENTLOCATION
		,ORIGINADDRESS1
		,SHIPTOPOSTALCODE
		,CAST(CHANNELLINKID AS FLOAT) CHANNELLINKID
		,SATURDAYDELIVERYCHARGE
		,ORIGINADDRESS2
		,SHIPPEDWEIGHT
		,SHIPCHARGE
		,ORIGINPOSTALCODE
		,ORDERNUMBER
		,DRYICECHARGE
		,CAST(TRACKINGSTATUSID AS FLOAT) TRACKINGSTATUSID
		,REFERENCEID
		,SIGNATUREREQUIREDCHARGE
		,TRACKINGNUMBER
		,RETURNRECEIPTCHARGE
		,CREATED_DTTM
		,DIMHEIGHT
		,DELIVERYCONFIRMATIONCHARGE
		,LABELTYPE
		,RESIDENTIALAREACHARGE
		,SHIPTOCONTACT
		,DIMMEDWEIGHT
		,MARKETREFERENCE
		,SHIPTOCOUNTRYCODE
		,HANDLINGCHARGE
		,ORIGINCOUNTRYCODE
		,HAZARDOUSMATERIALSCODE
		,CAST(TABLEID AS FLOAT) TABLEID
		,DIMWIDTH
		,CARRIERVERSIONFLAG
		,BASECARRIERTYPE
		,ORIGINCOUNTRY
		,RESTRICTEDDELIVERYCHARGE
		,_FIVETRAN_DELETED
		,_FIVETRAN_SYNCED
		,BILLINGACCOUNTNUMBER        
		FROM XBPRDWMGOLD.PRD_GOLD_GC_XBWM19WM.DTS_DATA_WAREHOUSE DTS_DATA_WAREHOUSE

        UNION
        
		SELECT
		_FIVETRAN_ID
        ,COALESCE(ID, REFERENCEID) AS D_MATCHED_ID
		,TRACKINGSTATUSLABEL
		,CLOSEID
		,ALTTRACKINGNUMBER
		,CAST(PACKAGEITEMTOTALQUANTITY AS FLOAT) PACKAGEITEMTOTALQUANTITY
		,ACCOUNTNUMBER
		,CAST(CHANNELID AS FLOAT) CHANNELID
		,BASECARRIERCODE
		,CARRIERINSURANCECHARGE
		,MARKETID
		,HOST
		,ORIGINCOMPANY
		,DIMLENGTH
		,ESTIMATEDDELIVERYDATE
		,CUSTOMID
		,SHIPTOADDRESS3
		,SHIPZONE
		,SHIPTOADDRESS2
		,SPLIT_PART (CARRIER, ' ', 1) AS Carrier 
        ,CARRIER AS Carrier_Service
		,PACKAGECHARGEATRATING
		,SHIPTOADDRESS1
		,BOXNAME
		,SUBACCOUNTNUMBER
		,CAST(ORDERID AS FLOAT) ORDERID
		,STATUS
		,CARRIERBILLINGTYPE
		,SHIPTYPE
		,SURCHARGECHARGE
		,APPLIEDCHARGETYPE
		,USERNAME
		,ID
		,WORKSTATION
		,TRACKINGEVENTDATE
		,CUSTOMREF2
		,CUSTOMREF3
		,SHIPTOCITY
		,PRIVATEINSURANCEAMOUNT
		,LASTPRINTDATE
		,MARKETSHIPMETHOD
		,DRYICEWEIGHT
		,ORDERTYPE
		,CREATEDATE
		,TRACKINGEVENTDESCRIPTION
		,SHIPTOSTATEORPROVINCE
		,FUELCHARGE
		,ORIGINSTATEORPROVINCE
		,DEPARTMENT
		,PRIVATEINSURANCECHARGE
		,BATCHID
		,DELIVERYAREACHARGE
		,CURRENCYCODEISO
		,CAST(STATUSID AS FLOAT) STATUSID
		,ORIGINCITY
		,ACTUALWEIGHT
		,CAST(ORDERCOUNT AS FLOAT) ORDERCOUNT
		,CARRIERINSURANCEAMOUNT
		,SHIPTOCOMPANY
		,UPDATEDATE
		,SHIPROUTE
		,CAST(SHIPPINGPROFILEID AS FLOAT) SHIPPINGPROFILEID
		,CUSTOMREF1
		,TOTALCHARGE
		,USPSPROVIDERTYPE
		,TRACKINGEVENTLOCATION
		,ORIGINADDRESS1
		,SHIPTOPOSTALCODE
		,CAST(CHANNELLINKID AS FLOAT) CHANNELLINKID
		,SATURDAYDELIVERYCHARGE
		,ORIGINADDRESS2
		,SHIPPEDWEIGHT
		,SHIPCHARGE
		,ORIGINPOSTALCODE
		,ORDERNUMBER
		,DRYICECHARGE
		,CAST(TRACKINGSTATUSID AS FLOAT) TRACKINGSTATUSID
		,REFERENCEID
		,SIGNATUREREQUIREDCHARGE
		,TRACKINGNUMBER
		,RETURNRECEIPTCHARGE
		,CREATED_DTTM
		,DIMHEIGHT
		,DELIVERYCONFIRMATIONCHARGE
		,LABELTYPE
		,RESIDENTIALAREACHARGE
		,SHIPTOCONTACT
		,DIMMEDWEIGHT
		,MARKETREFERENCE
		,SHIPTOCOUNTRYCODE
		,HANDLINGCHARGE
		,ORIGINCOUNTRYCODE
		,HAZARDOUSMATERIALSCODE
		,CAST(TABLEID AS FLOAT) TABLEID
		,DIMWIDTH
		,CARRIERVERSIONFLAG
		,BASECARRIERTYPE
		,ORIGINCOUNTRY
		,RESTRICTEDDELIVERYCHARGE
		,_FIVETRAN_DELETED
		,_FIVETRAN_SYNCED
		,BILLINGACCOUNTNUMBER
		FROM DTS.DTS_XBWM19WM.DTS_DATA_WAREHOUSE DTS_DATA_WAREHOUSE
        WHERE ID NOT IN (SELECT ID FROM XBPRDWMGOLD.PRD_GOLD_GC_XBWM19WM.DTS_DATA_WAREHOUSE) ;


-----| Create Ship_Via

CREATE OR REPLACE VIEW QA_BI.WM.VW_SHIP_VIA
    AS
        SELECT 
            SHIP_VIA_ID,
        	CREATED_DTTM,
        	SERVICE_LEVEL_INDICATOR,
        	IS_TRACKING_NBR_REQ,
        	SERVICE_LEVEL_ID,
        	SHIP_VIA,
        	BILL_SHIP_VIA_ID,
        	MOT_ID,
        	ACCESSORIAL_SEARCH_STRING,
        	SERVICE_LEVEL_ICON,
        	EXECUTION_LEVEL_ID,
        	TC_COMPANY_ID,
        	DESCRIPTION,
        	MAX_DECLARED_VALUE,
        	DECLARED_VALUE_CURRENCY,
        	MIN_DECLARED_VALUE,
        	MARKED_FOR_DELETION,
        	INS_COVER_TYPE_ID,
        	CUSTOM_SHIPVIA_ATTRIB,
        	LAST_UPDATED_DTTM,
        	CARRIER_ID,
        	LABEL_TYPE,
            FROM WM.GOLD.SHIP_VIA
        UNION
        SELECT 
            SHIP_VIA_ID,
        	CREATED_DTTM,
        	SERVICE_LEVEL_INDICATOR,
        	IS_TRACKING_NBR_REQ,
        	SERVICE_LEVEL_ID,
        	SHIP_VIA,
        	BILL_SHIP_VIA_ID,
        	MOT_ID,
        	ACCESSORIAL_SEARCH_STRING,
        	SERVICE_LEVEL_ICON,
        	EXECUTION_LEVEL_ID,
        	TC_COMPANY_ID,
        	DESCRIPTION,
        	MAX_DECLARED_VALUE,
        	DECLARED_VALUE_CURRENCY,
        	MIN_DECLARED_VALUE,
        	MARKED_FOR_DELETION,
        	INS_COVER_TYPE_ID,
        	CUSTOM_SHIPVIA_ATTRIB,
        	LAST_UPDATED_DTTM,
        	CARRIER_ID,
        	LABEL_TYPE,
            FROM WM.SILVER.SHIP_VIA
        UNION
        SELECT 
            SHIP_VIA_ID,
        	CREATED_DTTM,
        	SERVICE_LEVEL_INDICATOR,
        	IS_TRACKING_NBR_REQ,
        	SERVICE_LEVEL_ID,
        	SHIP_VIA,
        	BILL_SHIP_VIA_ID,
        	MOT_ID,
        	ACCESSORIAL_SEARCH_STRING,
        	SERVICE_LEVEL_ICON,
        	EXECUTION_LEVEL_ID,
        	TC_COMPANY_ID,
        	DESCRIPTION,
        	MAX_DECLARED_VALUE,
        	DECLARED_VALUE_CURRENCY,
        	MIN_DECLARED_VALUE,
        	MARKED_FOR_DELETION,
        	INS_COVER_TYPE_ID,
        	CUSTOM_SHIPVIA_ATTRIB,
        	LAST_UPDATED_DTTM,
        	CARRIER_ID,
        	LABEL_TYPE,
            FROM WM.RY.SHIP_VIA;

-----| Create cat_company
create view QA_BI.WM.VW_CAT_COMPANY
    as
        select ID_WHS
            ,WHS
            ,COMPANY_ID
            ,COMPANY
            ,CODE
            ,COMPANY_Title
           -- ,ID_DEPTOS AS COMPANY_ID_xbAdmin
            ,ZOE
            ,Flag_Activa
            ,CITY --- select * 
        from BI.google_sheets.cat_company ;

-----| Create XB Admin Tables
---| SHIP_SCANS
CREATE VIEW QA_BI.XBADMIN.VW_SHIP_SCANS
    AS
        SELECT *
        FROM SHIPPING_PLATFORM.SHIPPINGDB_APPADMIN_EHS.SHIP_SCANS;

---| SHIP_BOL_DETALLE
CREATE VIEW QA_BI.XBADMIN.VW_SHIP_BOL_DETALLE
    AS
        SELECT *
        FROM SHIPPING_PLATFORM.SHIPPINGDB_APPADMIN_EHS.SHIP_BOL_DETALLE;
---| SHIP_BOL
CREATE VIEW QA_BI.XBADMIN.VW_SHIP_BOL
    AS
        SELECT *
        FROM SHIPPING_PLATFORM.SHIPPINGDB_APPADMIN_EHS.SHIP_BOL;
---| IMPEXP_PROGRAMA
CREATE VIEW QA_BI.XBADMIN.VW_IMPEXP_PROGRAMA
    AS
        SELECT 
        ID_CONTPROGRAMA
        ,PRECIOVENTA
        ,EXPORTINVOICES
        ,FECHACREACION
        ,USUARIOREGVACIO
        ,SELLOS
        ,CONTENDOR_ID_TRAILER
        ,REALASEFDA
        ,EXPORTRESP
        ,PROCESSCONSOLIDATION
        ,RETRASO_ID
        ,COBRO_DEPTO_ID
        ,URLGPSSEGUIMIENTO
        ,CHOFERRETIRA
        ,TRANSPORTISTA_ID
        ,ENVIOREPORTE
        ,FECHAENTREGAPROG
        ,STATUSCONTENEDOR
        ,FDA
        ,USERMARCOLISTA
        ,LLEGADABORDER
        ,FECHARECEPCION
        ,LISTAPARACARGA
        ,PLANTA_ID
        ,SALIDAADUUS
        ,COBRARA
        ,ENTRADAADUMX
        ,USUARIOS_ID
        ,CONTENDOR_ID
        ,USUARIOREGRECEPCION
        ,EMANIFEST
        ,HORACIERRE
        ,CORTEPROGRAM
        ,CARGADESCARGA
        ,USUARIOCREADOR_ID
        ,CHOFERENTREGA
        ,COSTO
        ,FECHAIMPORTACION
        ,FECHAVACIO
        ,SALIDAADUMX
        ,FECHASALIDA
        ,DOCK_ID
        ,USERCIERRE
        ,USUARIOREGSALIDA
        ,USUARIO_TRABAJANDO
        ,LIBERACIONEXPORT_UPDATEBY
        ,FOLIOCARGA
        ,RLJINVOICE
        ,CONTENIDO
        ,ENTRADAADUUS
        ,FECHATRABAJANDO
        ,AARPEDIMENTO
        ,LIBERACIONEXPORT
        ,USERREALASEFDA
        ,CHOFERES_ID
        ,EXPORTREPDOWNLOAD
        ,SALIDABASCULA
        ,_FIVETRAN_DELETED
        ,_FIVETRAN_SYNCED
        ,CARTAPORTEGENERATED
        ,CHOFERLLEGA
        ,MONEDAINV
        ,TCINV
        ,INV_COBRADO
        ,FECHAREGISTROCOBRO
        ,COBRADO_POR
        ,TIPOVEHICULOPROM
        ,MONTOREAL
        ,FECHAFACTURAREAL
        ,FOLIOFACTURAREAL
        ,CLASSENVIO
        ,DOCUMENTSREADY
        ,PAQUETERIA_ID
        ,IMPORTWORKING
        ,INFORMAL_OUT
        ,INFORMAL_IN
        ,INFORMALMX
        ,INFORMALUS
        ,ESPECIAL
        FROM SHIPPING_PLATFORM.SHIPPINGDB_APPADMIN_EHS.IMPEXP_PROGRAMA;

-------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- Section Users
-----------------------------------------------------------------------------
-- 1. Creation of rol
--show roles;
CREATE ROLE IF NOT EXISTS ROL_COMPANY_TEST;
-- CREATE ROLE IF NOT EXISTS ROL_BOMBAS;

-- CREATE WAREHOUSE WH_BOMBAS
--     WITH WAREHOUSE_SIZE = 'XSMALL'
--     AUTO_SUSPEND = 60
--     AUTO_RESUME = TRUE
--     INITIALLY_SUSPENDED = TRUE;

-- GRANT USAGE ON WAREHOUSE WH_BOMBAS TO ROLE ROL_BOMBAS;

-- ALTER USER fsanchez
--    SET DEFAULT_WAREHOUSE = 'WH_BOMBAS';



-- 2. Creation user
-- show users;
-- ALTER USER USER_COMPANY_TEST SET MFA_ENABLED = TRUE;
----------------------- V1

CREATE USER IF NOT EXISTS USER_COMPANY_TEST
PASSWORD = 'user_company_test_12345' 
DEFAULT_ROLE = ROL_COMPANY_TEST;

REVOKE ROLE PUBLIC FROM USER USER_COMPANY_TEST;


-- ALTER USER FSANCHEZ SET DEFAULT_ROLE = ROL_BOMBAS;
-- REVOKE ROLE PUBLIC FROM USER FSANCHEZ;
-- REVOKE ROLE ROL_COMPANY_TEST FROM USER USER_COMPANY_TEST;
-- REVOKE ROLE ROL_BOMBAS FROM USER USER_COMPANY_TEST;

-----------------------------------------------------------------------------
-- Section Rol
-----------------------------------------------------------------------------
-- 3. Set rol on user
GRANT ROLE ROL_COMPANY_TEST TO USER USER_COMPANY_TEST;
ALTER USER USER_COMPANY_TEST SET DEFAULT_ROLE = ROL_COMPANY_TEST;


-- GRANT ROLE ROL_BOMBAS TO USER FSANCHEZ;
-- ALTER USER FSANCHEZ SET DEFAULT_ROLE = ROL_BOMBAS;

-- GRANT ROLE ROL_BOMBAS TO USER USER_COMPANY_TEST;
-- ALTER USER USER_COMPANY_TEST SET DEFAULT_ROLE = ROL_BOMBAS;



--ORDERS
-- 4.1. Set grant on all PRIVILEGES user DB, SCHEMA, TABLE
GRANT USAGE ON DATABASE QA_BI TO ROLE ROL_COMPANY_TEST;
GRANT USAGE ON SCHEMA QA_BI.WM TO ROLE ROL_COMPANY_TEST;
GRANT SELECT ON VIEW QA_BI.WM.VW_CAT_COMPANY TO ROLE ROL_COMPANY_TEST;
GRANT SELECT ON VIEW QA_BI.WM.VW_WM_INVENTORY TO ROLE ROL_COMPANY_TEST;
GRANT SELECT ON VIEW QA_BI.WM.VW_ITEM_CBO TO ROLE ROL_COMPANY_TEST;
GRANT SELECT ON VIEW QA_BI.WM.VW_ORDERS TO ROLE ROL_COMPANY_TEST;
GRANT SELECT ON VIEW QA_BI.WM.VW_LPN TO ROLE ROL_COMPANY_TEST;
GRANT SELECT ON VIEW QA_BI.WM.VW_KPI_TRANSPORTATION TO ROLE ROL_COMPANY_TEST;

GRANT USAGE ON SCHEMA QA_BI.LS TO ROLE ROL_COMPANY_TEST;
GRANT SELECT ON VIEW QA_BI.LS.VW_LATESHIPMENT TO ROLE ROL_COMPANY_TEST;

GRANT USAGE ON SCHEMA QA_BI.DTS TO ROLE ROL_COMPANY_TEST;
GRANT SELECT ON VIEW QA_BI.DTS.VW_DTS TO ROLE ROL_COMPANY_TEST;

-- GRANT USAGE ON DATABASE QA_BI TO ROLE ROL_BOMBAS;
-- GRANT USAGE ON SCHEMA QA_BI.WM TO ROLE ROL_BOMBAS;
-- GRANT SELECT ON VIEW QA_BI.WM.VW_CAT_COMPANY TO ROLE ROL_BOMBAS;
-- GRANT SELECT ON VIEW QA_BI.WM.VW_WM_INVENTORY TO ROLE ROL_BOMBAS;
-- GRANT SELECT ON VIEW QA_BI.WM.VW_ITEM_CBO TO ROLE ROL_BOMBAS;
-- GRANT SELECT ON VIEW QA_BI.WM.VW_ORDERS TO ROLE ROL_BOMBAS;
-- GRANT SELECT ON VIEW QA_BI.WM.VW_LPN TO ROLE ROL_BOMBAS;
-- GRANT SELECT ON VIEW QA_BI.WM.VW_KPI_TRANSPORTATION TO ROLE ROL_BOMBAS;

-- GRANT USAGE ON SCHEMA QA_BI.LS TO ROLE ROL_BOMBAS;
-- GRANT SELECT ON VIEW QA_BI.LS.VW_LATESHIPMENT TO ROLE ROL_BOMBAS;

-- GRANT USAGE ON SCHEMA QA_BI.DTS TO ROLE ROL_BOMBAS;
-- GRANT SELECT ON VIEW QA_BI.DTS.VW_DTS TO ROLE ROL_BOMBAS;

-- GRANT USAGE ON SCHEMA QA_BI.XBADMIN TO ROLE ROL_BOMBAS;
-- GRANT SELECT ON VIEW QA_BI.XBADMIN.VW_IMPEXP_PROGRAMA TO ROLE ROL_BOMBAS;
-- GRANT SELECT ON VIEW QA_BI.XBADMIN.VW_SHIP_BOL TO ROLE ROL_BOMBAS;
-- GRANT SELECT ON VIEW QA_BI.XBADMIN.VW_SHIP_BOL_DETALLE TO ROLE ROL_BOMBAS;
-- GRANT SELECT ON VIEW QA_BI.XBADMIN.VW_SHIP_SCANS TO ROLE ROL_BOMBAS;



-- REVOKE SELECT ON TABLE QA_BI.WM.VW_COMPANY FROM ROLE ROL_COMPANY_TEST;

-----------------------------------------------------------------------------
-- Section Policies
-----------------------------------------------------------------------------
-- 1.  Creation of POLICY - Row Acces Policy
CREATE OR REPLACE ROW ACCESS POLICY BI_SNOWFLAKE_DEV.WM.RAP_COMPANY_TEST
    AS (TC_COMPANY_ID INT) 
    RETURNS BOOLEAN -> 
        -- SET ROL BY Company
        (CURRENT_ROLE() = 'ROL_COMPANY_TEST' AND TC_COMPANY_ID IN (3,4,5))
;



CREATE OR REPLACE ROW ACCESS POLICY QA_BI.WM.RAP_BOMBAS
AS (COMPANY_ID INT)
RETURNS BOOLEAN ->
    CASE
        WHEN CURRENT_ROLE() = 'ROL_BOMBAS' OR CURRENT_USER() = 'USER_COMPANY_TEST' THEN COMPANY_ID IN (77)
        ELSE TRUE
    END;



CREATE OR REPLACE ROW ACCESS POLICY QA_BI.WM.RAP_BOMBAS
AS (COMPANY_ID INT)
RETURNS BOOLEAN ->
    -- 1. Condición de bypass para roles de Administrador (ve todo)
    (CURRENT_ROLE() IN ('ACCOUNTADMIN', 'SYSADMIN')) 
    OR
    -- 2. Condición de filtrado para roles y usuarios específicos
    (CURRENT_ROLE() = 'ROL_BOMBAS' OR CURRENT_USER() = 'USER_COMPANY_TEST') AND COMPANY_ID IN (77)
;


-- 2.1  Set Policy on table

ALTER TABLE BI_SNOWFLAKE_DEV.WM.COMPANY
    ADD ROW ACCESS POLICY BI_SNOWFLAKE_DEV.WM.RAP_COMPANY_TEST ON (TC_COMPANY_ID);    

    
-- 2.1  Set Policy on view
ALTER VIEW BI_SNOWFLAKE_DEV.WM.VW_COMPANY
    ADD ROW ACCESS POLICY BI_SNOWFLAKE_DEV.WM.RAP_COMPANY_TEST ON (TC_COMPANY_ID);


ALTER VIEW QA_BI.WM.VW_CAT_COMPANY
    ADD ROW ACCESS POLICY QA_BI.WM.RAP_BOMBAS ON (COMPANY_ID);
    
-----------------------------------------------------------------------------    
-- 3. Remove Policy from table
ALTER TABLE BI_SNOWFLAKE_DEV.WM.COMPANY
    DROP ROW ACCESS POLICY BI_SNOWFLAKE_DEV.WM.RAP_COMPANY_TEST;


ALTER TABLE QA_BI.WM.VW_CAT_COMPANY
    DROP ROW ACCESS POLICY QA_BI.WM.RAP_BOMBAS;
    
-- 4. Drop Policy
DROP ROW ACCESS POLICY BI_SNOWFLAKE_DEV.WM.RAP_COMPANY_TEST;

DROP ROW ACCESS POLICY QA_BI.WM.RAP_BOMBAS;



-----------------------------------------------------------------------------
-- 5. See POLICIES by SCHEMA
SHOW ROW ACCESS POLICIES IN SCHEMA BI_SNOWFLAKE_DEV.WM;

SHOW ROW ACCESS POLICIES IN SCHEMA QA_BI.WM;

-----------------------------------------------------------------------------


GRANT USAGE ON STREAMLIT chatbot_app TO ROLE chatbot_user;


SHOW STREAMLITS IN SCHEMA QA_BI.PUBLIC;






GRANT CREATE STREAMLIT ON SCHEMA QA_BI.PUBLIC TO ROLE ROL_BOMBAS;
GRANT CREATE STAGE ON SCHEMA QA_BI.PUBLIC TO ROLE ROL_BOMBAS;

-- Don't forget to grant USAGE on a warehouse.
GRANT USAGE ON WAREHOUSE WH_BOMBAS TO ROLE ROL_BOMBAS;

-- If you only want certain roles to create Streamlit apps, 
-- or want to enable a different location to store the Streamlit apps,
-- change the database, schema, and role names in the above commands.









GRANT MONITOR ON ACCOUNT TO ROLE ROL_BOMBAS;


GRANT MONITOR ON ACCOUNT TO ROLE ACCOUNTADMIN;



SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.CORTEX_ANALYST_USAGE_HISTORY;


USE ROLE ACCOUNTADMIN; -- Asegurar permisos suficientes

GRANT DATABASE ROLE SNOWFLAKE.CORTEX_USER TO ROLE ROL_BOMBAS;

GRANT READ ON STAGE QA_BI.PUBLIC.SEMANTIC_QA_STAGE TO ROLE ROL_BOMBAS;---

CREATE MATERIALIZED VIEW BI_SNOWFLAKE_DEV.PUBLIC.MVW_SEMANTIC_DEV 
AS
SELECT * FROM BI_SNOWFLAKE_DEV.PUBLIC.SEMANTIC_DEV;

DESCRIBE SEMANTIC VIEW BI_SNOWFLAKE_DEV.PUBLIC.SEMANTIC_DEV;

SELECT GET_DDL('SEMANTIC_VIEW', 'BI_SNOWFLAKE_DEV.PUBLIC.SEMANTIC_DEV', TRUE);

SELECT SYSTEM$READ_YAML_FROM_SEMANTIC_VIEW(
  'BI_SNOWFLAKE_DEV.PUBLIC.SEMANTIC_DEV'
);



SELECT SYSTEM$READ_YAML_FROM_SEMANTIC_VIEW(
  'BI_SNOWFLAKE_DEV.PUBLIC.SEMANTIC_DEV'
) AS YAML_CONTENT;




CREATE STAGE IF NOT EXISTS BI_SNOWFLAKE_DEV.PUBLIC.SEMANTIC_DEV_STAGE
    COMMENT = 'Stage for semantic models in YAML';



CREATE STAGE IF NOT EXISTS QA_BI.PUBLIC.SEMANTIC_QA_STAGE
    COMMENT = 'Stage for semantic models in YAML';


-------------------------------------------------------------------------------------------
-- SELECT * FROM qa_bi.wm.vw_orders o
-- left join qa_bi.wm.vw_cat_company c on o.tc_company_id = c.company_id
-- where c.company = 'BOMBAS'


-- WITH __vw_cat_company AS (
--   SELECT
--     company,
--     company_id
--   FROM qa_bi.wm.vw_cat_company
-- ), __vw_orders AS (
--   SELECT
--     order_id,
--     tc_company_id,
--     created_dttm
--   FROM qa_bi.wm.vw_orders
-- )
-- SELECT
--   c.company,
--   MIN(o.created_dttm) AS start_date,
--   MAX(o.created_dttm) AS end_date,
--   COUNT(DISTINCT o.order_id) AS total_orders
-- FROM __vw_cat_company AS c
-- INNER JOIN __vw_orders AS o
--   ON c.company_id = o.tc_company_id
-- WHERE
--   c.company = 'Bombas'
-- GROUP BY
--   c.company
 -- Generated by Cortex Analyst
;







-- SELECT
--     UNIT_LENGTH AS Length,
--     UNIT_WIDTH AS Width,
--     UNIT_HEIGHT AS Height
-- FROM
--     BI_SNOWFLAKE_DEV.WM.ITEM_CBO
-- WHERE
--     ITEM_NAME = 'Scented Soy Candle';

-- GRANT ROLE ROL_BI_AI TO USER ALGONZALEZ;



-- WITH order_metrics AS (
--   SELECT
--     kt.carrier,
--     kt.carrier_service,
--     kt.channel,
--     kt.order_status,
--     kt.pkg_status,
--     kt.state,
--     kt.order_id,
--     MIN(kt.order_date_wms) AS order_date,
--     MIN(kt.weight) AS order_weight,
--     MIN(kt.volume) AS order_volume,
--     MIN(kt.cost_mht) AS order_cost
--   FROM
--     vw_cat_company AS cc
--     LEFT OUTER JOIN vw_kpi_transportation AS kt ON cc.company = kt.tc_company_id
--   WHERE
--     cc.company_title = 'Bombas'
--   GROUP BY
--     kt.carrier,
--     kt.carrier_service,
--     kt.channel,
--     kt.order_status,
--     kt.pkg_status,
--     kt.state,
--     kt.order_id
-- )
-- SELECT
--   carrier,
--   carrier_service,
--   channel,
--   order_status,
--   pkg_status,
--   state,
--   MIN(order_date) AS first_order_date,
--   MAX(order_date) AS last_order_date,
--   COUNT(DISTINCT order_id) AS total_orders,
--   AVG(order_weight) AS avg_weight,
--   AVG(order_volume) AS avg_volume,
--   AVG(order_cost) AS avg_cost
-- FROM
--   order_metrics
-- GROUP BY
--   carrier,
--   carrier_service,
--   channel,
--   order_status,
--   pkg_status,
--   state
-- ORDER BY
--   first_order_date DESC NULLS LAST
--   /* Generated by Cortex Analyst */
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ V2
CREATE USER IF NOT EXISTS CSC_BOMBAS
PASSWORD = 'csc_bombas_12345' 
DEFAULT_ROLE = QA_ROLE_XBOT;
GRANT ROLE QA_ROLE_XBOT TO USER CSC_BOMBAS;
ALTER USER CSC_BOMBAS SET DEFAULT_ROLE =  QA_ROLE_XBOT;

CREATE USER IF NOT EXISTS CSC_KATE_SPADE
PASSWORD = 'csc_kate_spade_12345' 
DEFAULT_ROLE = QA_ROLE_XBOT;
GRANT ROLE QA_ROLE_XBOT TO USER CSC_KATE_SPADE;
ALTER USER CSC_KATE_SPADE SET DEFAULT_ROLE =  QA_ROLE_XBOT;

CREATE USER IF NOT EXISTS CSC_POPSOCKETS
PASSWORD = 'csc_popsockets_12345' 
DEFAULT_ROLE = QA_ROLE_XBOT;
GRANT ROLE QA_ROLE_XBOT TO USER CSC_POPSOCKETS;
ALTER USER CSC_POPSOCKETS SET DEFAULT_ROLE =  QA_ROLE_XBOT;

--- ROLES XBOT
CREATE ROLE IF NOT EXISTS ROLE_ADMIN_XBOT;
CREATE ROLE IF NOT EXISTS QA_ROLE_XBOT;
CREATE ROLE IF NOT EXISTS QA_ROLE_XBOT_CUSTOMER;
CREATE ROLE IF NOT EXISTS QA_ROLE_XBOT_CUSTOMER_SERVICE;



-- GRANT PRIVILEGES FOR ADMIN ROLE
GRANT USAGE ON DATABASE QA_BI TO ROLE ROLE_ADMIN_XBOT;
GRANT USAGE ON SCHEMA QA_BI.WM TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.WM.VW_CAT_COMPANY TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.WM.VW_WM_INVENTORY TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.WM.VW_ITEM_CBO TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.WM.VW_ORDERS TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.WM.VW_LPN TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.WM.VW_CAT_DOSTATUS TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.WM.VW_KPI_TRANSPORTATION TO ROLE ROLE_ADMIN_XBOT;

GRANT USAGE ON SCHEMA QA_BI.LS TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.LS.VW_LATESHIPMENT TO ROLE ROLE_ADMIN_XBOT;

GRANT USAGE ON SCHEMA QA_BI.DTS TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.DTS.VW_DTS TO ROLE ROLE_ADMIN_XBOT;

GRANT USAGE ON SCHEMA QA_BI.XBADMIN TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.XBADMIN.VW_IMPEXP_PROGRAMA TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.XBADMIN.VW_SHIP_BOL TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.XBADMIN.VW_SHIP_BOL_DETALLE TO ROLE ROLE_ADMIN_XBOT;
GRANT SELECT ON VIEW QA_BI.XBADMIN.VW_SHIP_SCANS TO ROLE ROLE_ADMIN_XBOT;

GRANT USAGE ON SCHEMA QA_BI.PUBLIC TO ROLE ROLE_ADMIN_XBOT;
GRANT READ ON STAGE QA_BI.PUBLIC.SEMANTIC_QA_STAGE TO ROLE ROLE_ADMIN_XBOT;

GRANT DATABASE ROLE SNOWFLAKE.CORTEX_ANALYST_USER TO ROLE ROLE_ADMIN_XBOT;


GRANT USAGE ON FUNCTION BI.WM.UDF_CALCULATE_PROMISE_DATE(TIMESTAMP_NTZ, ARRAY) 
TO ROLE ROLE_ADMIN_XBOT;


--- CREATION WAREHOUSE FOR XBOT
CREATE WAREHOUSE QA_WHS_XBOT
    WITH WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE;


CALL QA_BI.PERMISSIONS.SP_INSERT_ROLE_COMPANY_GROUP_BATCH(
    '["USER_COMPANY_TEST", "USER_COMPANY_TEST"]',
    '["BOMBAS", "ALO YOGA"]',
    '["", ""]'
);

CALL QA_BI.PERMISSIONS.SP_INSERT_ROLE_COMPANY_GROUP_BATCH(
    '["dacorona", "dacorona","dacorona"]',
    '["BOMBAS", "ALO YOGA", "Tapestry"]',
    '["", "", ""]'
);


CALL QA_BI.PERMISSIONS.SP_INSERT_ROLE_COMPANY_GROUP_BATCH(
    '["CSC_BOMBAS","CSC_KATE_SPADE"]',
    '["BOMBAS","KATE SPADE"]',
    '["",""]'
);


-- CALL QA_BI.PERMISSIONS.SP_INSERT_ROLE_COMPANY_GROUP_BATCH(
--     '["USER_COMPANY_TEST", "USER_COMPANY_TEST", "USER_COMPANY_TEST"]',
--     '["BOMBAS", "POPSOCKETS", "ALO YOGA"]',
--     '["ROLE_BOMBAS_ADMIN", "", "ROLE_ALO_YOGA_VIEWER"]'
-- );


--CALL QA_BI.PERMISSIONS.SP_INSERT_ROLE_COMPANY_GROUP_BATCH(
--     -- P_USERNAMES_JSON: 59 users
--     '[
--         "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", 
--         "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", 
--         "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", 
--         "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", 
--         "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", 
--         "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona", "dacorona"
--     ]',
    
--     -- P_ROLES_JSON: 59 Roles
--     '[
--         "BOMBAS", "POPSOCKETS", "ALO YOGA", "TCR", "TCT", "BARE NECESSITIES", "BARE NECESSITIES OLD", "JAANUU", "POP", "MIZZEN", 
--         "WHOOP", "PURAVIDA", "TEN THOU", "MEUNDIES", "LIBERATED BRANDS", "PUBLIC REC", "TOMBOY X", "PARADE", "FAIR HARBOR", "MELIN", 
--         "KINDRED", "LASCANA", "GREATWIN", "UNTUCKIT", "VENUS", "CREATION L", "ALOHA", "CUTS", "LEGENDS", "SOFT SUR", 
--         "BIRDY GREY", "PACT", "DOLLS KILL", "TRUFF", "ALEX & ANI", "MACK WELDON", "SPLENDID", "KINDTHREAD", "KATE SPADE", "ORGANIC BASICS", 
--         "OUTDOOR VOICES", "FLORENCE", "AIR UP", "RHOBACK", "SCRABYN", "RIDGE", "AKABRAND", "OH POLLY", "PASSIONATA", "CWHOINT", 
--         "STATIC NAILS", "JOLYN", "TAPESTRY", "COLDWATER", "SUMMER", "TOMMY JOHN", "MONICANDY", "COOLIBAR", "TISSINI"
--     ]',
    
--     -- P_SUBROLES_JSON: 59 Subroles
--     '[
--         "", "", "", "", "", "", "", "", "", "", 
--         "", "", "", "", "", "", "", "", "", "", 
--         "", "", "", "", "", "", "", "", "", "", 
--         "", "", "", "", "", "", "", "", "", "", 
--         "", "", "", "", "", "", "", "", "", "", 
--         "", "", "", "", "", "", "", "", ""
--     ]'
-- );


--- CREATION TABLE ROLE_COMPANY_GROUP
CREATE OR REPLACE TABLE QA_BI.PERMISSIONS.ROLE_COMPANY_GROUP
(
    ID           NUMBER(38,0) IDENTITY(1,1), 
    USERNAME     VARCHAR(255) NOT NULL,
    ROLE         VARCHAR(100) NOT NULL,
    SUBROLE      VARCHAR(100),    
    COMPANY_ID   NUMBER(38,0) NOT NULL,
    GROUP_NAME   VARCHAR(100) NOT NULL,
    IS_ACTIVE    BOOLEAN DEFAULT TRUE, 
    CONSTRAINT PK_COMPANY_GROUP PRIMARY KEY (ID)
);
ALTER TABLE QA_BI.PERMISSIONS.ROLE_COMPANY_GROUP ALTER COLUMN Is_query_shown NOT NULL;

GRANT SELECT ON QA_BI.PERMISSIONS.ROLE_COMPANY_GROUP TO ROLE ROLE_ADMIN_XBOT;

--- CREATION STREAMLIT APP, SET WAREHOUSE AND CREATE STAGE
GRANT CREATE STREAMLIT ON SCHEMA QA_BI.PUBLIC TO ROLE ROLE_ADMIN_XBOT;
GRANT USAGE ON WAREHOUSE QA_WHS_XBOT TO ROLE ROLE_ADMIN_XBOT;
GRANT MONITOR ON ACCOUNT TO ROLE ROLE_ADMIN_XBOT;
-- GRANT CREATE STAGE ON SCHEMA STREAMLIT_APPS.PUBLIC TO ROLE PUBLIC;


--- SET ROLE ON USER AND SET DEFAULT ROLE ON USER
GRANT ROLE ROLE_ADMIN_XBOT TO USER DACORONA;
GRANT ROLE ROLE_ADMIN_XBOT TO USER sroldan;
GRANT ROLE applications TO USER sroldan;


GRANT ROLE QA_ROLE_XBOT TO USER user_company_test;
ALTER USER user_company_test SET DEFAULT_ROLE = QA_ROLE_XBOT;


--- ADD PERMISSION BUs FOR USER OR USERS
CALL QA_BI.PERMISSIONS.SP_INSERT_ROLE_COMPANY_GROUP_BATCH(
    '["user_company_test"]',
    '["ALL"]',
    '[""]'
);


CALL QA_BI.PERMISSIONS.SP_INSERT_ROLE_COMPANY_GROUP_BATCH(
    '["andreap","andreap","andreap","andreap"]',
    '["BOMBAS","ALO YOGA","TAPESTRY","KATE SPADE"]',
    '["","","",""]'
);


CALL QA_BI.PERMISSIONS.SP_DEACTIVATE_USER_PERMISSIONS_BATCH(
    '["dacorona"]'
);

GRANT ROLE QA_ROLE_XBOT TO USER andreap;


-- SP FOR INSERT PERMISSIONS FOR BUs DYNAMIC, IF EXISTS THEN JUST ENABLE, IF NOT EXIST THEN INSERT THE DATA

CREATE OR REPLACE PROCEDURE QA_BI.PERMISSIONS.SP_INSERT_ROLE_COMPANY_GROUP_BATCH(
    P_USERNAMES_JSON     VARCHAR, 
    P_ROLES_JSON         VARCHAR, 
    P_SUBROLES_JSON      VARCHAR
)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
    var sql_command = "";
    var skipped_count = 0; 

    const DEFAULT_GROUP_NAME = 'A';
    const DEFAULT_IS_QUERY_SHOWN = true;
    const DEFAULT_IS_ACTIVE = true; 

    // --- FUNCIONES AUXILIARES ---
    function checkUserExists(username) {
        var stmt = snowflake.createStatement({
            sqlText: "SELECT COUNT(*) FROM SNOWFLAKE.ACCOUNT_USAGE.USERS WHERE NAME = ? AND DELETED_ON IS NULL",
            binds: [username]
        });
        var result = stmt.execute();
        result.next();
        return result.getColumnValue(1) > 0;
    }

    function getCompanyIdFromCatalog(companyName) {
        var stmt = snowflake.createStatement({
            sqlText: "SELECT company_id FROM QA_BI.WM.VW_CAT_COMPANY WHERE UPPER(company) = ?",
            binds: [companyName.toUpperCase()]
        });
        var result = stmt.execute();
        if (result.next()) {
            return result.getColumnValue(1);
        }
        return undefined;
    }

    try {
        var usernames = JSON.parse(P_USERNAMES_JSON);
        var roles = JSON.parse(P_ROLES_JSON);
        var subroles = JSON.parse(P_SUBROLES_JSON);

        if (usernames.length !== roles.length || usernames.length !== subroles.length) {
            return "ERROR: Los arrays deben tener la misma longitud.";
        }

        var insert_values = [];

        for (var i = 0; i < usernames.length; i++) {
            var username_val = usernames[i].toUpperCase();

            if (!checkUserExists(username_val)) {
                return "ERROR: El usuario '" + username_val + "' no existe en Snowflake.";
            }

            var role_name = roles[i].toUpperCase(); 
            var company_id_val = '';

            if (role_name === 'ALL') {
                company_id_val = '0';
            } else {
                var mapped_id = getCompanyIdFromCatalog(role_name);
                if (mapped_id === undefined) {
                    skipped_count++;
                    continue; 
                }
                company_id_val = mapped_id;
            }

            var subrole_raw = subroles[i];
            // Manejo de NULL para SQL
            var subrole_val = (subrole_raw === null || subrole_raw.trim() === '') ? 'NULL' : "'" + subrole_raw.toUpperCase() + "'";

            insert_values.push(
                "(" +
                "'" + username_val + "'," +
                "'" + role_name + "'," +
                subrole_val + "," +
                company_id_val + "," +
                "'" + DEFAULT_GROUP_NAME + "'," +
                DEFAULT_IS_ACTIVE + "," + // Corregida comilla extra
                DEFAULT_IS_QUERY_SHOWN +
                ")"
            );
        }

        if (insert_values.length === 0) {
            return `SUCCESS: Operación completada. 0 registros procesados. ${skipped_count} omitidos.`;
        }

        var source_data = insert_values.join(",");

        sql_command = `
            MERGE INTO QA_BI.PERMISSIONS.ROLE_COMPANY_GROUP AS T
            USING (
                SELECT 
                    A.$1 AS USERNAME, 
                    A.$2 AS ROLE, 
                    A.$3 AS SUBROLE, 
                    A.$4 AS COMPANY_ID, 
                    A.$5 AS GROUP_NAME, 
                    A.$6 AS IS_ACTIVE,
                    A.$7 AS IS_QUERY_SHOWN
                FROM VALUES ${source_data} AS A
            ) AS S
            ON T.USERNAME = S.USERNAME 
            AND T.ROLE = S.ROLE
            AND (T.SUBROLE = S.SUBROLE OR (T.SUBROLE IS NULL AND S.SUBROLE IS NULL))

            WHEN MATCHED THEN 
                UPDATE SET 
                    T.IS_ACTIVE = S.IS_ACTIVE, 
                    T.COMPANY_ID = S.COMPANY_ID,
                    T.GROUP_NAME = S.GROUP_NAME,
                    T.IS_QUERY_SHOWN = S.IS_QUERY_SHOWN

            WHEN NOT MATCHED THEN
                INSERT (USERNAME, ROLE, SUBROLE, COMPANY_ID, GROUP_NAME, IS_ACTIVE, IS_QUERY_SHOWN)
                VALUES (S.USERNAME, S.ROLE, S.SUBROLE, S.COMPANY_ID, S.GROUP_NAME, S.IS_ACTIVE, S.IS_QUERY_SHOWN);
        `;

        snowflake.execute({sqlText: sql_command});

        return `SUCCESS: Proceso finalizado. ${skipped_count} roles omitidos por no existir en catálogo.`;

    } catch (err) {
        return "ERROR: " + err.message;
    }
$$;


-- SP FOR DEACTIVATE PERMISSIONS FOR USERS
CREATE OR REPLACE PROCEDURE QA_BI.PERMISSIONS.SP_DEACTIVATE_USER_PERMISSIONS_BATCH(
    P_USERNAMES_JSON VARCHAR
)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
    var sql_command = "";
    var total_updated = 0;

    // -------------------------------
    // VALIDAR EXISTENCIA DE USUARIO
    // -------------------------------
    function checkUserExists(username) {
        var stmt = snowflake.createStatement({
            sqlText: `
                SELECT COUNT(*) 
                FROM SNOWFLAKE.ACCOUNT_USAGE.USERS 
                WHERE NAME = ? 
                  AND DELETED_ON IS NULL
            `,
            binds: [username]
        });
        var rs = stmt.execute();
        rs.next();
        return rs.getColumnValue(1) > 0;
    }

    try {

        var usernames = JSON.parse(P_USERNAMES_JSON);

        if (!Array.isArray(usernames) || usernames.length === 0) {
            return "ERROR: P_USERNAMES_JSON must be a non-empty JSON array.";
        }

        // -------------------------------
        // VALIDAR TODOS LOS USUARIOS
        // -------------------------------
        for (var i = 0; i < usernames.length; i++) {
            var user = usernames[i].toUpperCase();

            if (!checkUserExists(user)) {
                return "ERROR: The user '" + user + "' does not exist in the Snowflake account. Batch aborted.";
            }
        }

        // -------------------------------
        // DESACTIVAR PERMISOS
        // -------------------------------
        sql_command = `
            UPDATE QA_BI.PERMISSIONS.ROLE_COMPANY_GROUP
            SET IS_ACTIVE = FALSE
            WHERE USERNAME IN (${usernames.map(u => `'${u.toUpperCase()}'`).join(",")})
              AND IS_ACTIVE = TRUE
        `;

        var stmt_update = snowflake.createStatement({ sqlText: sql_command });
        var result = stmt_update.execute();

        result.next();
        total_updated = result.getColumnValue(1);

        if (total_updated === 0) {
            return "SUCCESS: No active permissions found to deactivate for the given users.";
        }

        return "SUCCESS: " + total_updated + " permission(s) deactivated for " + usernames.length + " user(s).";

    } catch (err) {
        return "ERROR during SP execution: " + err.message + " (Query: " + sql_command + ")";
    }
$$;




-- CREATE ROW ACCESS POLICY

CREATE OR REPLACE ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY
AS (COMPANY_ID INT)
RETURNS BOOLEAN ->
    -- 1. Condición de bypass para roles de Administrador (ve todo)
    (CURRENT_ROLE() IN ('ACCOUNTADMIN', 'SYSADMIN'))
    OR
    -- 2. Condición de acceso total (Rol 'ALL')
    (
        EXISTS (
            SELECT 1
            FROM QA_BI.PERMISSIONS.ROLE_COMPANY_GROUP AS T
            WHERE T.USERNAME = CURRENT_USER()
            AND T.IS_ACTIVE = TRUE
            AND T.ROLE = 'ALL'  -- El usuario tiene el permiso universal 'ALL'
        )
    )
    OR
    -- 3. Condición de filtrado dinámico (Roles específicos)
    (
        COMPANY_ID IN (
            SELECT DISTINCT T.COMPANY_ID
            FROM QA_BI.PERMISSIONS.ROLE_COMPANY_GROUP AS T
            WHERE T.USERNAME = CURRENT_USER()
            AND T.IS_ACTIVE = TRUE
            AND T.COMPANY_ID IS NOT NULL -- Filtra por IDs de compañía específicos
        )
    )
;

-----| APPLY RAP
-- LEVEL COMPANY
ALTER VIEW QA_BI.WM.VW_CAT_COMPANY
    ADD ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY ON (COMPANY_ID);
-- LEVEL ORDERS
ALTER VIEW QA_BI.WM.VW_ORDERS_
    ADD ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY ON (TC_COMPANY_ID);
-- LEVEL ORDER_LINE_ITEM
ALTER VIEW QA_BI.WM.VW_ORDER_LINE_ITEM_
    ADD ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY ON (TC_COMPANY_ID);
-- LEVEL ITEM_CBO
ALTER VIEW QA_BI.WM.VW_ITEM_CBO_
    ADD ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY ON (COMPANY_ID);
-- LEVEL WM_INVENTORY
ALTER VIEW QA_BI.WM.VW_WM_INVENTORY_
    ADD ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY ON (TC_COMPANY_ID);
-- LEVEL LPN
ALTER VIEW QA_BI.WM.VW_LPN_
    ADD ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY ON (TC_COMPANY_ID);
-- LEVEL LPN_DETAIL
ALTER VIEW QA_BI.WM.VW_LPN_DETAIL_
    ADD ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY ON (TC_COMPANY_ID);
    
-----| REMOVE FROM ROW RAP
ALTER TABLE QA_BI.WM.VW_CAT_COMPANY
    DROP ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY;
ALTER TABLE QA_BI.WM.VW_ORDERS_
    DROP ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY;
ALTER TABLE QA_BI.WM.VW_ORDER_LINE_ITEM_
    DROP ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY;
ALTER TABLE QA_BI.WM.VW_ITEM_CBO_
    DROP ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY;
ALTER TABLE QA_BI.WM.VW_WM_INVENTORY_
    DROP ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY;
ALTER TABLE QA_BI.WM.VW_LPN_
    DROP ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY;
ALTER TABLE QA_BI.WM.VW_LPN_DETAIL_
    DROP ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY;


-- SHOW RAP POLICIES
SHOW ROW ACCESS POLICIES IN SCHEMA QA_BI.WM;
-- SEE REFERENCES CREATED
SELECT 
    REF_DATABASE_NAME AS DATABASE,
    REF_SCHEMA_NAME AS SCHEMA,
    REF_ENTITY_NAME AS OBJECT_NAME,    
    REF_ENTITY_DOMAIN AS OBJECT_TYPE, 
    POLICY_STATUS
FROM TABLE(
    QA_BI.INFORMATION_SCHEMA.POLICY_REFERENCES(
        POLICY_NAME => 'QA_BI.WM.RAP_COMPANY'
    )
);


------------------------------------------------------------------------------------------------------------

-- CREATE MASKING POLICY
CREATE OR REPLACE MASKING POLICY QA_BI.WM.CAP_CITY
AS (VAL  STRING)
RETURNS STRING ->
    CASE
        WHEN CURRENT_ROLE() IN ('ACCOUNTADMIN', 'SYSADMIN') THEN VAL
        ELSE NULL  -- hides CITY for non-admins
    END;


-- APPLY CAP
ALTER VIEW QA_BI.WM.VW_CAT_COMPANY
MODIFY COLUMN CITY
SET MASKING POLICY QA_BI.WM.CAP_CITY;

-- REMOVE FROM ROW CAP

ALTER TABLE QA_BI.WM.VW_CAT_COMPANY
    DROP ROW ACCESS POLICY QA_BI.WM.RAP_COMPANY;

------------------------------------------------------------------------------------------------------------
SELECT * FROM QA_BI.PERMISSIONS.ROLE_COMPANY_GROUP
WHERE company_id = 0;

UPDATE QA_BI.PERMISSIONS.ROLE_COMPANY_GROUP
SET is_active = FALSE
WHERE USERNAME = 'USER_COMPANY_TEST';


------------------------------------------------------------------------------------------------------------


--   SELECT
--     order_id,
--     tc_order_id,
--     tc_company_id,
--     created_dttm
--   FROM
--     qa_bi.wm.vw_orders




-- SHOW STREAMLITS IN SCHEMA QA_BI.PUBLIC;
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
SELECT TOP 80 * FROM QA_BI.WM.VW_CAT_COMPANY;

SELECT company,company_id FROM QA_BI.WM.VW_CAT_COMPANY;

SELECT TOP 80 * FROM QA_BI.WM.VW_ITEM_CBO;
SELECT TOP 80 * FROM QA_BI.WM.vw_wm_inventory;
SELECT TOP 80 * FROM QA_BI.WM.VW_LPN;


SELECT TOP 80 * FROM BI.WM.cat_country;
SELECT TOP 80 * FROM BI.WM.CAT_DOSTATUS;



SELECT
    TKTP.*
FROM BI.WM.VW_KPI_TRANSPORTATION TKTP
WHERE TKTP.TC_COMPANY_ID = 347



SELECT o.tc_order_id,
                    o.order_id,
                    o.REF_FIELD_7,
                    o.d_country_code,
                    o.d_state_prov,
                    o.d_city,
                    o.d_postal_code,
                    o.ref_field_10,
                    o.created_dttm,
                    o.delivery_end_dttm,
                    o.do_status,
                    o.tc_company_id,
                    o.order_type,
                    o.d_name
                FROM WM.RY.orders o
                WHERE o.TC_COMPANY_ID = 347



SELECT TOP 80 * FROM QA_BI.WM.VW_ORDERS
WHERE TC_COMPANY_ID IN (347);




------------------------------------------------------------- Admin Security Layer Administrator

--- CREATION WAREHOUSE FOR XBOT
CREATE WAREHOUSE QA_WHS_XBOT_SECURITY_LAYER_ADMINISTRATOR
    WITH WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE;









--------------------------------------------------- SP ALTERNAL FOR BU STATIC ---------------------------------- IGNORE
-- SP FOR INSERT PERMISSIONS FOR BUs, IF EXISTS THEN JUST ENABLE, IF NOT EXIST THEN INSERT THE DATA
CREATE OR REPLACE PROCEDURE QA_BI.PERMISSIONS.SP_INSERT_ROLE_COMPANY_GROUP_BATCH(
    P_USERNAMES_JSON     VARCHAR, 
    P_ROLES_JSON         VARCHAR, 
    P_SUBROLES_JSON      VARCHAR
)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
    var sql_command = "";
    var row_count = 0;
    var skipped_count = 0; // Contador para los roles omitidos
    
    // Mapeo de roles a COMPANY_ID
    const ROLE_TO_COMPANY_ID_MAP = {
        "BOMBAS": 77,
        "POPSOCKETS": 74,
        "ALO YOGA": 100,
        "TCR": 323,        // ID 323
        "TCT": 590,        // ID 590
        "BARE NECESSITIES": 319,     // ID 319
        "BARE NECESSITIES OLD": 320, // ID 320
        "JAANUU": 73,
        "POP": 74,
        "MIZZEN": 75,
        "WHOOP": 76,
        "PURAVIDA": 78,
        "TEN THOU": 79,
        "MEUNDIES": 110,
        "LIBERATED BRANDS": 119,
        "PUBLIC REC": 120,
        "TOMBOY X": 121,
        "PARADE": 122,
        "FAIR HARBOR": 123,
        "MELIN": 124,
        "KINDRED": 126,
        "LASCANA": 127,
        "GREATWIN": 128,
        "UNTUCKIT": 129,
        "VENUS": 130,
        "CREATION L": 131,
        "ALOHA": 132,
        "CUTS": 133,
        "LEGENDS": 138,
        "SOFT SUR": 139,
        "BIRDY GREY": 140,
        "PACT": 192,
        "DOLLS KILL": 200,
        "TRUFF": 238,
        "ALEX & ANI": 318,
        "MACK WELDON": 321,
        "SPLENDID": 322,
        "KINDTHREAD": 324,
        "KATE SPADE": 325,
        "ORGANIC BASICS": 326,
        "OUTDOOR VOICES": 328,
        "FLORENCE": 329,
        "AIR UP": 331,
        "RHOBACK": 339,
        "SCRABYN": 341,
        "RIDGE": 342,
        "AKABRAND": 343,
        "OH POLLY": 344,
        "PASSIONATA": 345,
        "CWHOINT": 347,
        "STATIC NAILS": 392,
        "JOLYN": 610,
        "TAPESTRY": 726,
        "COLDWATER": 751,
        "SUMMER": 753,
        "TOMMY JOHN": 757,
        "MONICANDY": 780,
        "COOLIBAR": 911,
        "TISSINI": 971
    };
    
    // Valores Fijos/Por Defecto
    const DEFAULT_GROUP_NAME = 'A';
    const DEFAULT_IS_ACTIVE = true; 

    // --- FUNCTION TO CHECK USER EXISTENCE ---
    function checkUserExists(username) {
        var stmt = snowflake.createStatement({
            sqlText: "SELECT COUNT(*) FROM SNOWFLAKE.ACCOUNT_USAGE.USERS WHERE NAME = ? AND DELETED_ON IS NULL",
            binds: [username]
        });
        var result = stmt.execute();
        result.next();
        return result.getColumnValue(1) > 0;
    }
    // ----------------------------------------

    try {
        var usernames = JSON.parse(P_USERNAMES_JSON);
        var roles = JSON.parse(P_ROLES_JSON);
        var subroles = JSON.parse(P_SUBROLES_JSON);
        
        if (usernames.length !== roles.length || usernames.length !== subroles.length) {
            return "ERROR: The arrays for USERNAME, ROLE, and SUBROLE must have the same length.";
        }
        
        row_count = usernames.length;
        
        var insert_values = [];
        for (var i = 0; i < row_count; i++) {
            
            var username_val = usernames[i].toUpperCase();
            
            // --- VALIDACIÓN DE EXISTENCIA DEL USUARIO (Abortar si no existe) ---
            if (!checkUserExists(username_val)) {
                return "ERROR: The user '" + username_val + "' does not exist in the Snowflake account. Aborting batch operation.";
            }
            // --------------------------------------------
            
            var role_name = roles[i].toUpperCase(); 
            var normalized_role = role_name.replace('ROL_', '');
            
            var company_id_val = ''; // Usaremos una cadena para la inserción
            
            // 1. Manejo del Rol 'ALL' (Permiso Universal)
            if (role_name === 'ALL') {
                company_id_val = '0'; // Inserta NULL en COMPANY_ID
            } else {
                // 2. Mapeo de Rol Normal
                var mapped_id = ROLE_TO_COMPANY_ID_MAP[role_name] || ROLE_TO_COMPANY_ID_MAP[normalized_role];

                if (mapped_id === undefined) {
                    skipped_count++;
                    continue; // OMITE esta inserción y pasa al siguiente elemento del arreglo.
                }

                company_id_val = mapped_id;
            }
            
            var subrole_raw = subroles[i];
            var subrole_val = (subrole_raw === null || subrole_raw.trim() === '') ? 'NULL' : "'" + subrole_raw.toUpperCase() + "'"; 

            // Construir la tupla para el MERGE source (CTE)
            insert_values.push(
                "(" +
                "'" + username_val + "'," +
                "'" + role_name + "'," +
                subrole_val + "," + 
                company_id_val + "," +                  // Aquí usamos el valor NULL o ID
                "'" + DEFAULT_GROUP_NAME + "'," +   
                DEFAULT_IS_ACTIVE                   
                + ")"
            );
        }

        // Si no hay valores para insertar (todos fueron omitidos), terminamos
        if (insert_values.length === 0) {
            return `SUCCESS: Batch operation completed. No records inserted or updated. ${skipped_count} invalid Role(s) skipped.`;
        }

        // --- MERGE/UPSERT LOGIC ---
        var source_data = insert_values.join(",");
        
        sql_command = `
            MERGE INTO QA_BI.PERMISSIONS.ROLE_COMPANY_GROUP AS T
            USING (
                SELECT 
                    A.$1 AS USERNAME, 
                    A.$2 AS ROLE, 
                    A.$3 AS SUBROLE, 
                    A.$4 AS COMPANY_ID, 
                    A.$5 AS GROUP_NAME, 
                    A.$6 AS IS_ACTIVE 
                FROM VALUES ${source_data} AS A
            ) AS S
            ON T.USERNAME = S.USERNAME 
            AND T.ROLE = S.ROLE
            AND (T.SUBROLE = S.SUBROLE OR (T.SUBROLE IS NULL AND S.SUBROLE IS NULL))

            WHEN MATCHED THEN 
                UPDATE SET T.IS_ACTIVE = S.IS_ACTIVE, 
                           T.COMPANY_ID = S.COMPANY_ID,
                           T.GROUP_NAME = S.GROUP_NAME

            WHEN NOT MATCHED THEN
                INSERT (USERNAME, ROLE, SUBROLE, COMPANY_ID, GROUP_NAME, IS_ACTIVE)
                VALUES (S.USERNAME, S.ROLE, S.SUBROLE, S.COMPANY_ID, S.GROUP_NAME, S.IS_ACTIVE);
        `;
                      
        var result = snowflake.execute({sqlText: sql_command});
        
        // CORRECCIÓN DE INDEXING: 
        result.next();
        var num_matched = result.getColumnValue(1); 
        var num_inserted = result.getColumnValue(2);
        
        var update_status_message = (num_matched > 0) 
            ? `Records updated/re-enabled: ${num_matched}.` 
            : `Records updated/re-enabled: 0.`;

        return `SUCCESS: Batch operation completed. Records inserted: ${num_inserted}. ${update_status_message} ${skipped_count} invalid Role(s) skipped.`;
        
    } catch (err) {
        return "ERROR during SP execution: " + err.message + " (Generated Query: " + sql_command + ")";
    }
$$;





GRANT MONITOR USAGE ON ACCOUNT TO ROLE ROLE_ADMIN_XBOT;



USE ROLE ACCOUNTADMIN;

-- Esto permite que Streamlit lea la identidad del usuario
GRANT APPLICATION ROLE SNOWFLAKE.CORE.USER_NAME 
TO ROLE ROLE_ADMIN_XBOT;


SELECT COUNT(*) 
            FROM QA_BI.PERMISSIONS.ROLE_COMPANY_GROUP 
            WHERE UPPER(USERNAME) = current_user()
            AND IS_ACTIVE = TRUE 
            AND IS_QUERY_SHOWN = FALSE



GRANT ROLE ACCOUNTADMIN TO USER Andreap;
GRANT ROLE SECURITYADMIN TO USER Andreap;
GRANT ROLE useradmin TO USER Andreap;
GRANT ROLE sysadmin TO USER Andreap;




-- 1. Cambia al rol con poder total
USE ROLE ACCOUNTADMIN;

-- 2. Conceder privilegios sobre la base de datos de metadatos (Fundamental)
-- Esto permite que tu rol pueda "heredar" la visibilidad de objetos del sistema
GRANT IMPORTED PRIVILEGES ON DATABASE SNOWFLAKE TO ROLE ROLE_ADMIN_XBOT;

-- 3. Habilitar el rol de aplicación de usuario
-- Si la ruta 'CORE' falla, Snowflake permite usar la ruta directa en algunas regiones
GRANT APPLICATION ROLE SNOWFLAKE.CORE.USER_NAME TO ROLE ROLE_ADMIN_XBOT;

-- 4. El permiso "Maestro" de visibilidad
-- Este otorga la capacidad de ver quién dispara consultas en el Warehouse
GRANT MONITOR USAGE ON ACCOUNT TO ROLE ROLE_ADMIN_XBOT;


select * from qa_bi.wm.vw_cat_company;