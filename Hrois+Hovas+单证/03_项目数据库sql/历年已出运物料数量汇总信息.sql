select a.char1,to_char(b.order_ship_date,'yyyy'),b.FACTORY_CODE,count(*)
  from aa_lin_temp2 a, so_sales_order b, so_sales_order_item c
  where b.order_code = c.order_code
  and c.material_code = a.char1
  and b.order_ship_date is not null
  group by a.char1,to_char(b.order_ship_date,'yyyy'),b.FACTORY_CODE
  
  
  select * from aa_lin_temp2 for update;
