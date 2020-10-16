SELECT DISTINCT PO.ACT_PREPARE_CODE, -- ��������   
                PO.ORDER_NUM, --������   
                SO.CONTRACT_CODE, -- ��ͬ��  
                C.NAME, --���ڹ���      
                PO.CHECK_CODE, --�̼����κ�               
                PO.FIRST_SAMPLE_DATE, --������ʼʱ��  
                PO.MANU_START_DATE, --�����ƻ���ʼ    
                PO.PACKING_START_DATE, --װ��ƻ���ʼ    
                PO.CHECK_START_DATE, --�̼�ƻ���ʼ  
                PO.MANU_END_DATE, --�����ƻ�����    
                PO.PACKING_END_DATE, --װ��ƻ���ʼ    
                PO.CHECK_END_DATE, --�̼�ƻ���ʼ    
                CUST.NAME AS CUSTNAME, --�ͻ�     
                DT.DEPT_NAME_CN AS DEPTNAME, --��Ӫ����    
                DECODE(SO.ORDER_BUYOUT_FLAG, '0', '��', '1', '��') AS ORDER_BUYOUT_FLAG, --�Ƿ����  
                LO.ITEM_NAME_CN AS SALES_ORG_NAME, --������֯    
                L.ITEM_NAME_CN AS SALES_CHENNEL, --��������    
                DECODE(PO.SETTLEMENT_TYPE, '0', '����', '1', '�չ�') AS ORDER_SETTLEMENT_TYPE, --���㷽ʽ      
                PO.FACTORY_PRODUCE_CODE || FACTORY.DEPT_NAME_CN AS FACTORYPRODUCENAME, --��������    
                PO.FACTORY_SETTLEMENT_CODE || FACTORYT.DEPT_NAME_CN AS FACTORY_SETTLEMENT_NAME, --���㹤��
                SO.ORDER_SHIP_DATE, --����ʱ��
                POI.ORDER_ITEM_ID AS ORDER_LINECODE, --����Ŀ��
                PT.PROD_TYPE, --��Ʒ����
                SOI.HAIER_MODEL, --�����ͺ�
                SOI.CUSTOMER_MODEL, --�ͻ��ͺ�
                SOI.AFFIRM_NUM, --�ؼ�����
                POI.MATERIAL_CODE, --BOM��
                POI.QUANTITY, --����
                ORDERTYPE.ITEM_NAME_CN ORDER_TYPE, --��������
                PO.CREATED,
                SO.ORDER_AUDIT_DATE ACTUAL_FINISH_DATE
FROM   ACT_PREPARE_ORDER PO
JOIN   ACT_PREPARE_ORDER_ITEM POI
ON     PO.ACT_PREPARE_CODE = POI.ACT_PREPARE_ORDER_CODE
LEFT   JOIN SO_SALES_ORDER SO
ON     PO.ORDER_NUM = SO.ORDER_CODE
JOIN   SO_SALES_ORDER_ITEM SOI
ON     (SOI.ORDER_CODE = PO.ORDER_NUM AND
       POI.MATERIAL_CODE = SOI.MATERIAL_CODE)
LEFT   JOIN CD_PROD_TYPE PT
ON     PT.PROD_TYPE_CODE = SOI.PROD_T_CODE
LEFT   JOIN SYS_LOV L
ON     (PO.SALES_CHENNEL = L.ITEM_CODE AND L.ITEM_TYPE = '20')
LEFT   JOIN SYS_LOV LO
ON     (LO.ITEM_CODE = PO.SALES_ORG_CODE AND LO.ITEM_TYPE = '21')
LEFT   JOIN CD_DEPARTMENT DT
ON     (SO.DEPT_CODE = DT.DEPT_CODE AND DT.DEPT_TYPE = '1')
LEFT   JOIN CD_CUSTOMER CUST
ON     SO.ORDER_SOLD_TO = CUST.CUSTOMER_CODE
LEFT   JOIN CD_COUNTRY C
ON     SO.COUNTRY_CODE = C.COUNTRY_CODE
LEFT   JOIN CD_DEPARTMENT FACTORY
ON     (FACTORY.DEPT_CODE = PO.FACTORY_PRODUCE_CODE AND
       FACTORY.DEPT_TYPE = '0')
LEFT   JOIN CD_DEPARTMENT FACTORYT
ON     (FACTORYT.DEPT_CODE = PO.FACTORY_SETTLEMENT_CODE AND
       FACTORYT.DEPT_TYPE = '0')
LEFT   JOIN SYS_LOV ORDERTYPE
ON     (ORDERTYPE.ITEM_CODE = SO.ORDER_TYPE AND ORDERTYPE.ITEM_TYPE = '0')
WHERE  PO.ORDER_NUM = #{ORDERNUM}
ORDER  BY PO.ACT_PREPARE_CODE
