select * from IF_BCC_FEE a where a.order_num in(
'0004316649','0004316653'
) and a.subject_name = '59' and a.sub_subject is null for update



select STATUS_CODE from SI_EXP_BUDGET_BCC b where b.order_num in(
'0004316649','0004316653'
) and b.item_id = '59'


select * from SI_EXP_BUDGET_BCC@OLDHROIS c where c.order_num in('0004316649','0004316653')

