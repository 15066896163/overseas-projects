--���װ������*�����װ����(kg) = �ܾ���
--���װ������*�����װë��(kg) = ��ë��

--���䲻ͳ���������������鿴����ר�ú�һ����һ���ĺ����׺��-1����Ϣ��


--��ѯ��ϸ�����Ƿ���ȷ
SELECT *
  FROM CD_SPECIAL_CNT_item a
 where a.special_cnt_prod_id in ('2020101700113637', '2020101700113638')
 and a.outer_info_flag = '1';

SELECT *
  FROM CD_SPECIAL_CNT_PROD a
 where a.special_cnt_prod_id in ('2020101700113637', '2020101700113638')
 and a.outer_info_flag = '1';

select *
  from CD_SPECIAL_CNT c
 where c.special_cnt_num like '%̩��ɢ������36��������40HQ48�����������201017%';
