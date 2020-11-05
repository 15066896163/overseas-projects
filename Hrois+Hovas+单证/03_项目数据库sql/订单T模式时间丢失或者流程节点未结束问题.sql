SELECT CD.ACT_ID,
       CD.ACT_NAME,
       CD.ACT_DESC,
       SO.PLAN_FINISH_DATE,
       SO.ACTUAL_FINISH_DATE,
       SO.PLAN_START_DATE,
       SO.STATUS_CODE£¨
       so.order_num
  FROM SO_ACT SO, CD_ACT_SET CD, USER_INFO EM
 WHERE SO.ACT_ID = CD.ACT_ID(+)
   AND SO.ACT_USER_ID = EM.EMP_CODE(+)
   and cd.act_name like '%∂©µ•»∑»œ%'
   and so.status_code = 'start'
  -- AND SO.ORDER_NUM = '0004394158'
  --AND CD.PAR_ROW = '0'
 ORDER BY CD.Order_By


select a.actual_finish_date,a.status_code£¨a.*
  from SO_ACT a
 where a.order_num = '0004394158'
  and a.act_id = 'businessManagerSalesOrder'
   for update
