--�������չʾ�ֶ�
select * from CD_ORDER_AUDIT_SET

--�������չʾ�ֶ���Ϣ�����޸�
SELECT ROW_ID,
       ORDER_NUM,
       RESPONSIBILITY,
       AUDIT_RESULTS,
       AUDIT_DATE,
       AUDIT_ITEM,
       AUDIT_VALUE,
       AUDIT_EVALUATE,
       CREATED_BY,
       CREATED,
       LAST_UPD_BY,
       LAST_UPD,
       MODIFICATION_NUM,
       REMARKS
  FROM SO_AUDIT_MAIN AuditMain_
 WHERE AuditMain_.ORDER_NUM = '0004339992'
   for update
