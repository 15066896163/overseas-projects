select DISTINCT oi.prod_quantity as orderQuatity, --订单数量
                decode(nvl(cm.split_flag, '0'),
                       '1',
                       oi.prod_quantity * nvl(cmcc.countNum, 1),
                       '0',
                       oi.prod_quantity) as orderNumber, --订单件数 
                (oi.prod_quantity * nvl(cmcc.countNum, 1) -
                nvl(TMP.BUDGET_QUANTITY, 0)) as budgetOrderNumber, --可预算件数
                (oi.prod_quantity * nvl(cmcc.countNum, 1)),
                oi.order_item_id
  from so_sales_order_item oi,
       cd_material         cm,
       VI_SO_CONTAINER     vi,
       
       (SELECT CI.ORDER_ITEM_ID as order_item_id,
               SUM(CI.BUDGET_QUANTITY) BUDGET_QUANTITY
          FROM ACT_CNT_ITEM CI
         GROUP BY CI.ORDER_ITEM_ID) TMP,
       (select nvl(sum(cmc.complete_quotiety), 0) as countNum,
               cmc.complete_material_code
          from cd_material_complete cmc
         group by complete_material_code) cmcc
 where oi.material_code = cm.material_code(+)
   and OI.material_code = cmcc.complete_material_code(+)
   and oi.order_item_id = TMP.order_item_id(+)
   and oi.order_code = vi.ORDER_CODE(+)
   and oi.order_item_linecode = vi.ORDER_ITEM_LINECODE(+)
   and oi.order_code = '0004342793';

select order_item_id, prod_quantity
  from so_sales_order_item a
 where a.order_code = '0004308481'
 (SELECT CI.ORDER_ITEM_ID as order_item_id,
               SUM(CI.BUDGET_QUANTITY) BUDGET_QUANTITY
          FROM ACT_CNT_ITEM CI
         where ci.ORDER_ITEM_ID in
               ('2020082603599534', '2020082603599535', '2020082603599536')
         GROUP BY CI.ORDER_ITEM_ID);

--如果prod_quantity-BUDGET_QUANTITY
