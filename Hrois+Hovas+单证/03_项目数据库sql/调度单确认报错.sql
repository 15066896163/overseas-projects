--���ȵ�ȷ�ϱ���
--������״̬��Ϊ1����
 select t.suspension_state_,t.assignee_,t.task_def_key_,t.*,t.rowid from ACT_RU_TASK t
 where  t.proc_inst_id_  in (select t.processinstance_id from wf_procinstance t
 where t.businform_id  in 
 ('0004332172' ));
-- status״̬λ�ĳ�0
   SELECT t.*,t.rowid
  FROM WF_PROCINSTANCE T 
 WHERE T.BUSINFORM_ID in ('0004332172' )
