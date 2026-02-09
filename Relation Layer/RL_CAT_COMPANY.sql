create view RL.WM.CAT_COMPANY
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