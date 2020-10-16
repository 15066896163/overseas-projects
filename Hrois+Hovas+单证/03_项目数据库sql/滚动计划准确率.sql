SELECT U.NAME AS PROD_MANAGER_NAME,
       TMP.PROD_MANAGER, --��Ʒ�������
       SUM(ACTUAL_QUANTITY) AS ROLLPLAN_QUANTITY, --�����ƻ�����
       SUM(QUANTITY) AS PREPARE_QUANTITY, --�Ѿ���������
       SUM(TMP.RATIO_VAL) AS OVERSTEP_QUANTITY, --����
       CASE
         WHEN SUM(TMP.RATIO_VAL) < SUM(TMP.ACTUAL_QUANTITY) THEN
          ROUND(SUM(TMP.RATIO_VAL) / SUM(TMP.ACTUAL_QUANTITY) * 100, 2)
         WHEN SUM(TMP.RATIO_VAL) = 0 THEN
          0
         WHEN SUM(TMP.RATIO_VAL) >= SUM(TMP.ACTUAL_QUANTITY) THEN
          100
       END AS OVERSTEP_RATE, --������
       CASE
         WHEN SUM(TMP.RATIO_VAL) < SUM(TMP.ACTUAL_QUANTITY) THEN
          ROUND((1 - SUM(TMP.RATIO_VAL) / SUM(TMP.ACTUAL_QUANTITY)) * 100, 2)
         WHEN SUM(TMP.RATIO_VAL) = 0 THEN
          100
         WHEN SUM(TMP.RATIO_VAL) >= SUM(TMP.ACTUAL_QUANTITY) THEN
          0
       END AS ACCURACY_RATE --׼ȷ��

  FROM (SELECT SOR.PROD_TYPE_CODE,
               SOR.MARKET,
               SOR.FACTORY_CODE,
               SOR.MATERIAL_CODE,
               SOR.HAIER_MODEL,
               SOR.CUSTOMER_MODEL,
               SOR.ROLL_RATE,
               SOR.START_DATE,
               SOR.END_DATE,
               SOR.MONTH_DATE,
               SOR.MONTH_N,
               SOR.WEEK_N,
               SUM(SOR.WEEK_QUANTITY) WEEK_QUANTITY,
               SUM(SOR.ACTUAL_QUANTITY) ACTUAL_QUANTITY, --�����ƻ�����
               SOR.R3_DATE,
               SOR.ERROR_DECRIBE,
               SOR.REASON,
               SOR.PROD_MANAGER, --��Ʒ����
               SOR.DEPT_CODE, --��Ӫ��
               NVL((SELECT SUM(V.QUANTITY)
                     FROM VI_ROLLPLAN_ACT_PREPARE V
                    WHERE V.MATERIAL_CODE = SOR.Material_Code
                      AND V.MANU_END_DATE BETWEEN SOR.START_DATE AND
                          SOR.END_DATE
                      AND V.ORDER_PROD_MANAGER = SOR.PROD_MANAGER),
                   0) AS QUANTITY, --�Ѿ���������
               ABS(NVL((SELECT SUM(V.QUANTITY)
                         FROM VI_ROLLPLAN_ACT_PREPARE V
                        WHERE V.MATERIAL_CODE = SOR.MATERIAL_CODE
                          AND V.MANU_END_DATE BETWEEN SOR.START_DATE AND
                              SOR.END_DATE
                          AND V.ORDER_PROD_MANAGER = SOR.PROD_MANAGER),
                       0) - SUM(SOR.ACTUAL_QUANTITY)) AS RATIO_VAL
          FROM SI_OES_ROLLPLAN SOR
         GROUP BY SOR.PROD_TYPE_CODE,
                  SOR.MARKET,
                  SOR.FACTORY_CODE,
                  SOR.MATERIAL_CODE,
                  SOR.HAIER_MODEL,
                  SOR.CUSTOMER_MODEL,
                  SOR.ROLL_RATE,
                  SOR.START_DATE,
                  SOR.END_DATE,
                  SOR.MONTH_DATE,
                  SOR.MONTH_N,
                  SOR.WEEK_N,
                  SOR.R3_DATE,
                  SOR.ERROR_DECRIBE,
                  SOR.REASON,
                  SOR.PROD_MANAGER,
                  SOR.DEPT_CODE) TMP
  LEFT JOIN USER_INFO U
    ON U.EMP_CODE = TMP.PROD_MANAGER
 WHERE 1 = 1
   AND tmp.PROD_MANAGER = '00065505'
   AND tmp.WEEK_N >= 3
   AND tmp.WEEK_N <= 3
   AND tmp.ROLL_RATE = TO_DATE('2014-04-28', 'yyyy-MM-dd')
	   GROUP BY U.NAME, TMP.PROD_MANAGER
