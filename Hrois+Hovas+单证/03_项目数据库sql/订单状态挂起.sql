--��˱��,NULL=�������Ĳ�¼״̬��
--0=�������������(��δ���)��
--1=���������ɣ�
--2=�����ѱ�ȡ���� 
--3=���ȵ�����״̬,
--4=���ȵ������ɸ���
--5=�޸�����ͨ�������޸Ķ��� 

--�鿴����״̬�Ƿ�Ϊ��������״̬�޸�Ϊ4
select a.order_code, a.order_audit_flag
  from so_sales_order a
 where a.order_code in (
'0004287382'
)for update;

--�鿴������
SELECT T.STATUS,P.SUSPENSION_STATE_,t.*
  FROM WF_PROCINSTANCE T, ACT_RU_TASK P
 WHERE T.BUSINFORM_ID in ('0040004422')
   AND T.PROCESSINSTANCE_ID = P.PROC_INST_ID_;

--�鿴״̬�Ƿ����1�����������1���޸�Ϊ1
SELECT * FROM WF_PROCINSTANCE T WHERE t.row_id = '2018041600097828'
T.BUSINFORM_ID in(
'0004328227'
) for update;
--�鿴SUSPENSION_STATE_�Ƿ񲻵���1���������1���޸�Ϊ2
select * from ACT_RU_TASK p where p.PROC_INST_ID_ in (
'113337543'
) --for update;

--select * from ACT_RU_IDENTITYLINK i where I.TASK_ID_ = '90358892'--for update

--����ϵͳ��������������ģ�飬�鿴���ݣ�ѡ�������Ȼ�󶩵�Ӧ�þͽ�ҳɹ���
---------------------------------------------------------------------------------
update ACT_RU_TASK p
   set p.assignee_ = '97028546'
 where p.PROC_INST_ID_ in
       (SELECT T.PROCESSINSTANCE_ID
          FROM WF_PROCINSTANCE T
         WHERE T.BUSINFORM_ID in ('0004312619', '0004312620'));
---------------------------------------------------------------------------------
