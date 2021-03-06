--查询每一周做的滚动计划
SELECT R.*,
       R.ROWID
FROM   RP_INPUT R
WHERE  R.MONTH_N = '2013-11-18'
AND r.prod_manager_code='00086060';
--查询数量
SELECT COUNT(*) FROM RP_INPUT R WHERE R.MONTH_N = '2013-10-14';
--查询产品经理数量
SELECT R.*
FROM   th_RP_INPUT R
WHERE  R.MONTH_N = '2020-11-02'
and r.contract_code = 'SC10000037'
GROUP  BY R.PROD_MANAGER_CODE;
