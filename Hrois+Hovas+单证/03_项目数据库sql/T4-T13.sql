SELECT DISTINCT TMP.PROD_TYPE AS ��Ʒ����, --��Ʒ����
                TMP.PROD_T_CODE AS ��Ʒ�������, --��Ʒ����Code
                TMP.MATERIAL_CODE AS ����, --����
                TMP.HAIER_MODEL AS �����ͺ�, --�����ͺ�
                TMP.CUSTOMER_MODEL AS �ͻ��ͺ�, --�ͻ��ͺ�
                TMP.ROLL_RATE AS �ƻ�ʱ��, --�ƻ�ʱ��
                TMP.START_DATE AS ��ʼʱ��, --��ʼʱ��
                TMP.END_DATE AS ����ʱ��, --����ʱ��
                TMP.PROD_MANAGER AS ����,
                TMP.NAME AS ��Ʒ����, --��Ʒ����
                SUM(TMP.WEEK_QUANTITY) AS �ƻ�����,
                SUM(TMP.ACTUAL_QUANTITY) AS �����ƻ��������, --�����ƻ�����
                SUM(TMP.PROD_QUANTITY) AS �Ѿ���������, --�Ѿ���������
                SUM(TMP.RATIO_VAL) AS ����, --����
                CASE
                  WHEN SUM(TMP.RATIO_VAL) < SUM(TMP.ACTUAL_QUANTITY) THEN
                   ROUND(SUM(TMP.RATIO_VAL) / SUM(TMP.ACTUAL_QUANTITY) * 100,
                         2)
                  WHEN SUM(TMP.RATIO_VAL) = 0 THEN
                   0
                  WHEN SUM(TMP.RATIO_VAL) >= SUM(TMP.ACTUAL_QUANTITY) THEN
                   100
                END AS ������, --������
                CASE
                  WHEN SUM(TMP.RATIO_VAL) < SUM(TMP.ACTUAL_QUANTITY) THEN
                   ROUND((1 - SUM(TMP.RATIO_VAL) / SUM(TMP.ACTUAL_QUANTITY)) * 100,
                         2)
                  WHEN SUM(TMP.RATIO_VAL) = 0 THEN
                   100
                  WHEN SUM(TMP.RATIO_VAL) >= SUM(TMP.ACTUAL_QUANTITY) THEN
                   0
                END AS ׼ȷ�� --׼ȷ��
FROM   (
        
        SELECT DISTINCT CPT.PROD_TYPE,
                         PI.PROD_T_CODE,
                         PI.MATERIAL_CODE AS MATERIAL_CODE,
                         PI.HAIER_MODEL,
                         PI.CUSTOMER_MODEL,
                         TO_DATE('2013-12-16', 'YYYY-MM-DD') AS ROLL_RATE,
                         TO_DATE('2013-12-16', 'YYYY-MM-DD')+28 AS START_DATE,
                         TO_DATE('2013-12-16', 'YYYY-MM-DD')+91 AS END_DATE,
                         NVL((SELECT SUM(S1.WEEK_QUANTITY)
                             FROM   SI_OES_ROLLPLAN S1
                             WHERE  S1.ROLL_RATE =
                                    TO_DATE('2013-12-16', 'YYYY-MM-DD')
                             AND    S1.WEEK_N <> '3'
                             AND    S1.MATERIAL_CODE = PI.MATERIAL_CODE
                             AND    S1.PROD_MANAGER = S.ORDER_PROD_MANAGER),
                             0) AS WEEK_QUANTITY,
                         NVL((SELECT SUM(SR.ACTUAL_QUANTITY)
                             FROM   SI_OES_ROLLPLAN SR
                             WHERE  SR.MATERIAL_CODE = PI.MATERIAL_CODE
                             AND    SR.PROD_MANAGER = S.ORDER_PROD_MANAGER
                             AND    SR.ROLL_RATE =
                                    TO_DATE('2013-12-16', 'YYYY-MM-DD')
                             AND    SR.WEEK_N <> '3'),
                             0) AS ACTUAL_QUANTITY,
                         
                         (SELECT SUM(SSOI.PROD_QUANTITY)
                          FROM   SO_SALES_ORDER_ITEM SSOI,
                                 SO_ACT              AA,
                                 SO_SALES_ORDER      SSO
                          WHERE  SSOI.MATERIAL_CODE = PI.MATERIAL_CODE
                          AND    AA.ORDER_NUM = SSOI.ORDER_CODE
                          AND    SSOI.ORDER_CODE = SSO.ORDER_CODE
                          AND    AA.ACT_ID = 'followGoods'
                          AND    (SSO.ORDER_AUDIT_FLAG = '1' OR
                                SSO.ORDER_AUDIT_FLAG = '3' OR
                                SSO.ORDER_AUDIT_FLAG IS NULL)
                          AND    SSO.ORDER_PROD_MANAGER = S.ORDER_PROD_MANAGER
                          AND    AA.PLAN_FINISH_DATE BETWEEN
                                 TO_DATE('2013-12-16', 'YYYY-MM-DD')+28 AND
                                 TO_DATE('2013-12-16', 'YYYY-MM-DD')+91
                          
                          ) AS PROD_QUANTITY,
                         
                         ABS(NVL((SELECT SUM(SR.ACTUAL_QUANTITY)
                                 FROM   SI_OES_ROLLPLAN SR
                                 WHERE  SR.MATERIAL_CODE = PI.MATERIAL_CODE
                                 AND    SR.PROD_MANAGER = S.ORDER_PROD_MANAGER
                                 AND    SR.ROLL_RATE =
                                        TO_DATE('2013-12-16', 'YYYY-MM-DD')
                                 AND    SR.WEEK_N <> '3'),
                                 0) -
                             (SELECT SUM(SSOI.PROD_QUANTITY)
                              FROM   SO_SALES_ORDER_ITEM SSOI,
                                     SO_ACT              AA,
                                     SO_SALES_ORDER      SSO
                              WHERE  SSOI.MATERIAL_CODE = PI.MATERIAL_CODE
                              AND    AA.ORDER_NUM = SSOI.ORDER_CODE
                              AND    SSOI.ORDER_CODE = SSO.ORDER_CODE
                              AND    AA.ACT_ID = 'followGoods'
                              AND    (SSO.ORDER_AUDIT_FLAG = '1' OR
                                    SSO.ORDER_AUDIT_FLAG = '3' OR
                                    SSO.ORDER_AUDIT_FLAG IS NULL)
                              AND    SSO.ORDER_PROD_MANAGER =
                                     S.ORDER_PROD_MANAGER
                              AND    AA.PLAN_FINISH_DATE BETWEEN
                                     TO_DATE('2013-12-16', 'YYYY-MM-DD')+28 AND
                                     TO_DATE('2013-12-16', 'YYYY-MM-DD')+91
                              
                              )) AS RATIO_VAL,
                         
                         TO_DATE('2013-12-16', 'YYYY-MM-DD')+28 AS WEEK_START,
                         S.ORDER_PROD_MANAGER AS PROD_MANAGER,
                         UI.NAME
        
        FROM   SO_SALES_ORDER      S,
                SO_ACT              A,
                SO_SALES_ORDER_ITEM PI,
                CD_PROD_TYPE        CPT,
                USER_INFO           UI
        WHERE  1 = 1
        AND    A.ORDER_NUM = S.ORDER_CODE
        AND    PI.ORDER_CODE = S.ORDER_CODE
        AND    (S.ORDER_AUDIT_FLAG = '1' OR S.ORDER_AUDIT_FLAG = '3' OR
              S.ORDER_AUDIT_FLAG IS NULL)
        AND    A.ACT_ID = 'followGoods'
        AND    A.PLAN_FINISH_DATE BETWEEN TO_DATE('2013-12-16', 'YYYY-MM-DD')+28 AND
               TO_DATE('2013-12-16', 'YYYY-MM-DD')+91
        AND    PI.PROD_T_CODE = CPT.PROD_TYPE_CODE
        AND    S.ORDER_PROD_MANAGER = UI.EMP_CODE
              --AND S.ORDER_PROD_MANAGER = '00081141'
        AND    PI.FACTORY_CODE NOT IN ('9390', '9380', '9330') --1739374
        GROUP  BY CPT.PROD_TYPE,
                   PI.PROD_T_CODE,
                   PI.MATERIAL_CODE,
                   PI.HAIER_MODEL,
                   PI.CUSTOMER_MODEL,
                   PI.FACTORY_CODE,
                   S.ORDER_PROD_MANAGER,
                   A.PLAN_FINISH_DATE,
                   UI.NAME
        
        UNION ALL
        
        SELECT CPT.PROD_TYPE, --��Ʒ����
               SOR.PROD_TYPE_CODE, --��Ʒ����Code
               SOR.MATERIAL_CODE, --����
               sor.haier_model,
               sor.customer_model,
               SOR.ROLL_RATE, --�ƻ�ʱ��
               TO_DATE('2013-12-16', 'YYYY-MM-DD')+28 AS START_DATE, --��ʼʱ��
               TO_DATE('2013-12-16', 'YYYY-MM-DD')+91 AS END_DATE, --����ʱ��
               SUM(SOR.WEEK_QUANTITY) AS WEEK_QUANTITY,
               SUM(SOR.ACTUAL_QUANTITY) AS ACTUAL_QUANTITY,
               0 AS PROD_QUANTITY,
               SUM(SOR.ACTUAL_QUANTITY) AS RATIO_VAL,
               TO_DATE('2013-12-16', 'YYYY-MM-DD')+28 AS WEEK_START,
               SOR.PROD_MANAGER AS PROD_MANAGER,
               UI.NAME
        
        FROM   SI_OES_ROLLPLAN SOR,
               CD_PROD_TYPE    CPT,
               USER_INFO       UI
        WHERE  SOR.ROLL_RATE = TO_DATE('2013-12-16', 'YYYY-MM-DD')
        AND    SOR.PROD_TYPE_CODE = CPT.PROD_TYPE_CODE(+)
        AND    SOR.WEEK_N <> '3'
        AND    SOR.PROD_MANAGER = UI.EMP_CODE(+)
        AND    SOR.MATERIAL_CODE NOT IN
               (SELECT T.MATERIAL_CODE
                 FROM   SO_SALES_ORDER_ITEM T,
                        SO_ACT              A,
                        SO_SALES_ORDER      S
                 WHERE  A.ORDER_NUM = T.ORDER_CODE
                 AND    A.ACT_ID = 'followGoods'
                 AND    S.ORDER_CODE = T.ORDER_CODE
                 AND    (S.ORDER_AUDIT_FLAG = '1' OR S.ORDER_AUDIT_FLAG = '3' OR
                       S.ORDER_AUDIT_FLAG IS NULL)
                 AND    S.ORDER_PROD_MANAGER = SOR.PROD_MANAGER
                 AND    SOR.ACTUAL_QUANTITY > 0
                 AND    A.PLAN_FINISH_DATE BETWEEN
                        TO_DATE('2013-12-16', 'YYYY-MM-DD')+28 AND
                        TO_DATE('2014-01-19', 'YYYY-MM-DD')+91)
        GROUP  BY CPT.PROD_TYPE, --��Ʒ����
                  SOR.PROD_TYPE_CODE, --��Ʒ����Code
                  SOR.MATERIAL_CODE, --����
                   sor.haier_model,
               sor.customer_model,
                  SOR.ROLL_RATE,
                  SOR.PROD_MANAGER,
                  UI.NAME
        
        ) TMP

GROUP  BY TMP.PROD_TYPE, --��Ʒ����
          TMP.PROD_T_CODE, --��Ʒ����Code
          TMP.HAIER_MODEL,
          TMP.CUSTOMER_MODEL,
          TMP.MATERIAL_CODE, --����
          TMP.ROLL_RATE, --�ƻ�ʱ��
          TMP.START_DATE, --��ʼʱ��
          TMP.END_DATE, --����ʱ��
          TMP.NAME,
          TMP.PROD_MANAGER
ORDER  BY TMP.START_DATE,
          TMP.MATERIAL_CODE
