select a.* from RESOURCE_INFO a,role_resource b,role_group c,group_info d where 
a.id = b.resource_id
and b.role_id = c.role_id
and c.group_id = d.id 
and a.name like '¶©µ¥³öÔË%'

select a.* from RESOURCE_INFO a,role_resource b,role_group c,group_info d where 
a.id = b.resource_id
and b.role_id = c.role_id
and c.group_id = d.id 
and a.name like 'HOPE%'

select * from role_resource  where resource_id = '6645'

select * from role_group  where role_id in ('1') 

select * from group_info  where id in ('1') 


select ug.*
  from user_info ui, user_group ug, group_info gi
 where ui.id = ug.user_id
   and gi.id = ug.group_id
--and ui.emp_code = '01492130'
   and gi.code = 'BUSSINESSMANAGER'
   
    
   select * from user_group aa where aa.group_id = '6' and aa.emp_code = '01492130' for update
