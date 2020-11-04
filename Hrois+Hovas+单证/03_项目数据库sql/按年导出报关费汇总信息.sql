select TO_CHAR(a.expt_ship_date,'YYYY'),count(a.invoice_amount) from SI_EXP_BUDGET_BCC a where a.item_id = '17' 
GROUP BY TO_CHAR(a.expt_ship_date,'YYYY')   
ORDER BY TO_CHAR(a.expt_ship_date,'YYYY') ASC NULLS  LAST 
