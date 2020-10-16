SELECT HO.EXE_DATE, --����ʱ��
       PO.ORDER_NUM, --������
       PO.ACT_PREPARE_CODE, --��������  
       DT.DEPT_NAME_CN     AS FACTORY_PRODUCE_CODE, --�������� 
       HO.MATERIAL_CODE, -- ���Ϻ�   
       HO.AFFIRM_CODE      AS AFFIRM_NUM, --�ؼ����� 
       HO.QUANTITY, -- ����   
       SO.SALES_ORG_CODE, --������֯ 
       HO.SHIP_TO, -- �ͻ��۴﷽ 
       HO.STORAGE_AREA, -- ���ص�
       HO.ORDER_HGVS_CODE, --HGVS���۶����� 
       HO.EXE_FLAG, -- ȡ����ʶ  
       HO.EXE_RESULT, --�ӿ���Ϣ  
       HO.TJ_FLAG, --�׻���ʶ  
       SO.ORDER_TYPE, --��������  
       HO.ORDER_HGVS_TYPE, --����GVS����
       CY.NAME, --����    
       PO.MANU_END_DATE --�����ƻ�����ʱ�� 
FROM   ACT_PREPARE_ORDER    PO,
       SO_SALES_ORDER       SO,
       CD_COUNTRY           CY,
       CD_DEPARTMENT        DT,
       SI_HGVS_ORDER_CREATE HO
WHERE  PO.ORDER_NUM = SO.ORDER_CODE
AND    SO.COUNTRY_CODE = CY.COUNTRY_CODE
AND    DT.DEPT_CODE = PO.FACTORY_PRODUCE_CODE
AND    HO.ORDER_CODE = PO.ORDER_NUM
