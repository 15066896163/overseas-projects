delete from so_sales_order a where a.order_code = '0004337089';

delete from so_sales_order_item b where b.order_code = '0004337089';

delete from so_sales_order_condition c where c.order_code = '0004337089';

--查看状态是否等于1，如果不等于1则修改为1
SELECT * FROM WF_PROCINSTANCE T WHERE 
T.BUSINFORM_ID in(
'0004394158'
) for update;
--查看SUSPENSION_STATE_是否不等于1，如果等于1则修改为2
select * from ACT_RU_TASK p where p.PROC_INST_ID_ in (
'116464507'
) for update;

SELECT CD.ACT_ID,
       CD.ACT_NAME,
       CD.ACT_DESC,
       SO.PLAN_FINISH_DATE,
       SO.ACTUAL_FINISH_DATE,
       SO.PLAN_START_DATE,
       SO.STATUS_CODE 
  FROM SO_ACT SO, CD_ACT_SET CD, USER_INFO EM
 WHERE SO.ACT_ID = CD.ACT_ID(+)
   AND SO.ACT_USER_ID = EM.EMP_CODE(+)
   AND SO.ORDER_NUM = '0004394158'
  --AND CD.PAR_ROW = '0'
 ORDER BY CD.Order_By


select a.*
  from SO_ACT a
 where a.order_num = '0004337089'

