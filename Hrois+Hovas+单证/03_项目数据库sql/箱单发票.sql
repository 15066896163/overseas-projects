 SELECT  * FROM (SELECT S.ORDER_CODE AS, --������
           S.INVOICE_NUM, --��Ʊ��
           S.ORDER_SHIP_DATE, --������
           '' AS LOADING_BOX_CODE, --��װ���
           SL.ITEM_NAME_EN AS ITEM_NAME_CN, --���˷�ʽ
           S.ORDER_PO_CODE, --PO  
           'bz' AS ORDER_TYPE, --��������  
           SI.ORDER_ITEM_ID AS ITEM_ID,
           SI.HAIER_MODEL,
           SI.CUSTOMER_MODEL,
           '' AS PROD_MODEL,
           SI.PROD_QUANTITY,
           DECODE(SI.UNIT, '', 'PC', SI.UNIT) AS UNIT,
           DECODE(M.GOODS_GROSS_WEIGHT, '', 0, M.GOODS_GROSS_WEIGHT) AS GROSS_WEIGHT,
               'G/W:' || DECODE(M.GOODS_GROSS_WEIGHT, '', 0, M.GOODS_GROSS_WEIGHT) || ' KGS' AS GROSS_WEIGHT_STRING,
               DECODE(MM.NET_WEIGHT, '', 0, MM.NET_WEIGHT) *
               SI.PROD_QUANTITY AS NET_WEIGHT,
               M.SIMPLE_CODE AS SIMPLE_CODE,
               M.GOODS_DESC AS HAIER_PROD_DESC
    FROM   SO_SALES_ORDER S
    LEFT   JOIN SYS_LOV SL
    ON     (SL.ITEM_CODE = S.ORDER_SHIPMENT AND SL.ITEM_TYPE = '7')
    LEFT   JOIN SO_SALES_ORDER_ITEM SI
    ON     (S.ORDER_CODE = SI.ORDER_CODE  AND
                 S.ORDER_TYPE IN ('005', '046', '047'))
    JOIN   ACT_BOOK_ORDER_ITEM M
    ON     (S.ORDER_CODE = M.ORDER_CODE AND
           SI.ORDER_ITEM_LINECODE = M.ORDER_ITEM_CODE)
        LEFT   JOIN CD_MATERIAL MM
    ON     MM.MATERIAL_CODE = SI.MATERIAL_CODE
    WHERE  M.BOOK_CODE = #{bookCode}
    AND   S.ORDER_CODE NOT IN  (SELECT MO.MERGE_ORDER_NUM
        FROM   SO_ORDER_MERGE MO
        WHERE  MO.MERGE_ORDER_NUM IS NOT NULL
        UNION
        SELECT M1.ORDER_NUM FROM SO_ORDER_MERGE M1 WHERE M1.ORDER_NUM IS NOT NULL)
    UNION
    SELECT S.ORDER_CODE AS, --������
           S.INVOICE_NUM, --��Ʊ��
           S.ORDER_SHIP_DATE, --������
           '' AS LOADING_BOX_CODE, --��װ���
           SL.ITEM_NAME_EN AS ITEM_NAME_CN, --���˷�ʽ
           S.ORDER_PO_CODE, --PO  
           'bz' AS ORDER_TYPE, --��������  
           SI.ORDER_ITEM_ID AS ITEM_ID,
           SI.HAIER_MODEL,
           SI.CUSTOMER_MODEL,
           '' AS PROD_MODEL,
           SI.PROD_QUANTITY,
           DECODE(SI.UNIT, '', 'PC', SI.UNIT) AS UNIT,
           0 AS GROSS_WEIGHT,
           'G/W:' || 0 ||
           ' KGS' AS GROSS_WEIGHT_STRING,
           0 AS NET_WEIGHT,
           M.SIMPLE_CODE AS SIMPLE_CODE,
           M.GOODS_DESC AS HAIER_PROD_DESC
    FROM   SO_SALES_ORDER S
    LEFT   JOIN SYS_LOV SL
    ON     (SL.ITEM_CODE = S.ORDER_SHIPMENT AND SL.ITEM_TYPE = '7')
    LEFT   JOIN SP_SALES_ORDER_ITEM SI
    ON     (S.ORDER_CODE = SI.ORDER_CODE  AND
                 S.ORDER_TYPE IN ('5', '6', '9'))
    JOIN   ACT_BOOK_ORDER_ITEM M
    ON     (S.ORDER_CODE = M.ORDER_CODE AND M.MARKS = SI.HGMS_ITEM_CODE) 
    LEFT   JOIN CD_MATERIAL MM
    ON     MM.MATERIAL_CODE = SI.MATERIAL_CODE
    WHERE  M.BOOK_CODE = #{bookCode}
    AND    SI.PROD_QUANTITY IS NOT NULL
    UNION
    SELECT S.ORDER_CODE, --������
           S.INVOICE_NUM, --��Ʊ��
           S.ORDER_SHIP_DATE, --������
           '' AS LOADING_BOX_CODE, --��װ���
           SL.ITEM_NAME_EN AS ITEM_NAME_CN, --���˷�ʽ
           S.ORDER_PO_CODE, --PO  
           'hb' AS ORDER_TYPE, --��������
           '' AS ITEM_ID,
           SM.HAIER_MODEL,
           SM.CUSTOMER_MODEL,
           SM.CUSTOMER_MODEL || '/' || SM.HAIER_MODEL AS PROD_MODEL,
           SM.QUANTITY AS PROD_QUANTITY,
           DECODE(SM.UNIT, '', 'PC', SM.UNIT) AS UNIT,
           DECODE(SM.GROSS_WEIGHT, '', 0, SM.GROSS_WEIGHT) AS GROSS_WEIGHT,
           'G/W:' || DECODE(SM.GROSS_WEIGHT, '', 0, SM.GROSS_WEIGHT) || ' KGS' AS GROSS_WEIGHT_STRING,
           SM.NET_WEIGHT AS NET_WEIGHT,
           SM.SIMPLE_CODE AS SIMPLE_CODE,
           SM.HAIER_PROD_DESC AS HAIER_PROD_DESC
    FROM   SO_SALES_ORDER S
    LEFT   JOIN SYS_LOV SL
    ON     (SL.ITEM_CODE = S.ORDER_SHIPMENT AND SL.ITEM_TYPE = '7')
    LEFT   JOIN SO_ORDER_MERGE SM
    ON     S.ORDER_CODE = SM.ORDER_NUM
    JOIN   ACT_BOOK_ORDER_ITEM M
    ON     S.ORDER_CODE = M.ORDER_CODE
    WHERE  M.BOOK_CODE = #{bookCode}
    AND    SM.CUSTOMER_MODEL IS NOT NULL
    <if test="queryFlag=='1'.toString()">
    UNION
    SELECT S.ORDER_CODE, --������
           S.INVOICE_NUM, --��Ʊ��
           S.ORDER_SHIP_DATE, --������
           '' AS LOADING_BOX_CODE, --��װ���
           SL.ITEM_NAME_EN AS ITEM_NAME_CN, --���˷�ʽ
           S.ORDER_PO_CODE, --PO    
           'sj' AS ORDER_TYPE,
           SI.ORDER_ITEM_ID AS ITEM_ID,
           '' HAIER_MODEL,
           '' CUSTOMER_MODEL,
           AI.PART_NAME_ENGLISH AS PROD_MODEL,
           SUM(AI.OUTER_QUA) AS PROD_QUANTITY,
           DECODE(SI.UNIT, '', 'PC', SI.UNIT) AS UNIT,
           SUM(AI.OUTER_GROSS_WEIGHT * AI.OUTER_QUA) AS GROSS_WEIGHT,
           'G/W:' || SUM(AI.OUTER_GROSS_WEIGHT * AI.OUTER_QUA) AS GROSS_WEIGHT_STRING,
           0 AS NET_WEIGHT,
           '' AS SIMPLE_CODE,
           '' AS HAIER_PROD_DESC
    FROM   SO_SALES_ORDER S
    LEFT   JOIN SO_SALES_ORDER_ITEM SI
    ON     S.ORDER_CODE = SI.ORDER_CODE
    LEFT   JOIN SYS_LOV SL
    ON     SL.ITEM_CODE = S.ORDER_SHIPMENT
    LEFT   JOIN ACT_ORDER_SPECIAL_ITEM AI
    ON     (S.ORDER_CODE = AI.ORDER_NUM AND AI.PROD_CODE = SI.HAIER_MODEL AND
           AI.AFFIRM_NUM = SI.AFFIRM_NUM)
    JOIN   ACT_BOOK_ORDER_ITEM M
    ON     (S.ORDER_CODE = M.ORDER_CODE AND
           M.ORDER_ITEM_CODE = SI.ORDER_ITEM_LINECODE)
    WHERE  M.BOOK_CODE = #{bookCode}
    AND AI.PART_NAME_ENGLISH IS NOT NULL
    GROUP  BY S.ORDER_CODE,
              S.INVOICE_NUM,
              S.ORDER_SHIP_DATE,
              SL.ITEM_NAME_EN,
              S.ORDER_PO_CODE,
              SI.ORDER_ITEM_ID,
              AI.PART_NAME_ENGLISH,SI.UNIT
     </if> 
              ) A
     ORDER BY A.ORDER_CODE
