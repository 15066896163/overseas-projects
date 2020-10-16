--��ѯ�϶���
SELECT DISTINCT POI.ACT_CONF_PAY_ITEM_CODE ROW_ID,
                    AR.ORDER_CODE, AR.CUSTOMER_CODE, AR.CURRENCY, AR.CUST_NUM*-1,
    DECODE(AR.CPAYTYPE,'O/A','O','T/T','H','L/C','L','B/L��L/C','L','D/P','P','D/A','D','����','G','��������֤','S') CPAYTYPE
FROM   SI_AR_MONEY_INVOKE      AR,
       SO_SALES_ORDER          SO,
       ACT_CONF_PAY_ORDER_ITEM POI
WHERE  AR.ORDER_CODE <> SO.ORDER_CODE
AND    AR.ORDER_CODE = POI.CREATED_BY(+)
AND    DECODE(AR.CPAYTYPE,
              'O/A',
              'O',
              'T/T',
              'H',
              'L/C',
              'L',
              'B/L��L/C',
              'L',
              'D/P',
              'P',
              'D/A',
              'D',
              '����',
              'G',
              '��������֤',
              'S') = POI.PAYMENT_METHOD(+)
