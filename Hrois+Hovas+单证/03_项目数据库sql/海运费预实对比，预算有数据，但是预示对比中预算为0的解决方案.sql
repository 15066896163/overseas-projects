--��ѯ�����ݣ�ɾ���󽫶�����������AA_LIN_TEMP2���е�char1�ֶ���
select* from AA_LIN_TEMP2 for update;

--�Ҽ��༭�洢���̣����˷Ѿʹ򿪺��˷ѹ��̣���·�Ѿʹ���·�ѹ��̣�Ȼ��������
PRC_LIN_TEMP1;

--ִ����洢���̺󣬲鿴SEE_FEE���е�amount�Ƿ�Ϊ0
select  * from SEE_FEE a where a.order_code = '0004274857'

--�鿴amount�Ƿ�Ϊ0�����Ϊ0�����δ����Ԥ�㣬ȥ����
SELECT P.XLH,
           (SELECT MAX(O.FEE_ROW_ID)
              FROM SEE_FEE_ITEM O
             WHERE O.ORDER_CODE = M.ORDER_NUM),
           M.ORDER_NUM,
           (SELECT NVL(SUM(N.ACTUAL_AMOUNT), 0)
              FROM SEE_FEE_ITEM N
             WHERE N.ORDER_CODE = M.ORDER_NUM) as amount,
           P.CURRENCY,
           '1',
           NULL,
           P.EMP_CODE,
           SYSDATE,
           NULL,
           NULL
      FROM SEE_FEE_BILL P, ACT_SHIP_ORDER M,SO_SALES_ORDER SO
     WHERE P.BILL_NUM = M.BILL_NUM
       AND so.order_code = '0004274857'
       AND SO.ORDER_CODE = M.ORDER_NUM

--����sql����ܲ�ѯ��amount��ִ��update
update SEE_FEE c
   set c.amount =
       (SELECT B.AMOUNT
          FROM IF_BCC_FEE B, AA_LIN_TEMP2 a
         WHERE B.ORDER_NUM = a.char1
           AND B.SUBJECT_NAME = '59'
           and c.order_code = a.char1
           AND B.SUB_SUBJECT IS NULL)
 where EXISTS (SELECT 1
          FROM IF_BCC_FEE B, AA_LIN_TEMP2 a
         WHERE B.ORDER_NUM = a.char1
           AND B.SUBJECT_NAME = '59'
           and c.order_code = a.char1
           AND B.SUB_SUBJECT IS NULL);

--�޸ıȽ�ֵ
update SEE_FEE c
   set c.bijiao =
       (c.actual_amount - c.amount)
 where c.order_code in (select char1 from AA_LIN_TEMP2);

--�޸Ĳ���ֵ
update SEE_FEE c
   set c.chayi =
       (c.actual_amount - c.amount)
 where c.order_code in (select char1 from AA_LIN_TEMP2);
