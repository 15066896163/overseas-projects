--�鿴���б��������
select t.table_name,t.num_rows from user_tables t ORDER BY NUM_ROWS DESC;

--�鿴dblink�ģ�
select t.table_name,t.num_rows from user_tables@dblink t ORDER BY NUM_ROWS DESC;
