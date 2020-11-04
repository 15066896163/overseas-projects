4421-0-31715 / 4421-0-31714/ 4421-0-31716

select * from LC_TPRODUCT c where c.pd_lcnum in( '4421-0-31714'
,'4421-0-31715','4421-0-31716'
) for update;

select d.lc_deliverydate from LC_LETTERCREDIT d where d.lc_num in( '4421-0-31714'
,'4421-0-31715','4421-0-31716'
) for update;

