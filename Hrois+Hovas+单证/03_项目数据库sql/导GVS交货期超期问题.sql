-- �����޷���HGVS��ϵͳ��ʾ�����ڹ���
-- ����취���޸��ֶ�MANU_END_DATE�������ڸ�Ϊ����

select MANU_END_DATE from ACT_PREPARE_ORDER where order_num in (
'0004287607'
) for update;
