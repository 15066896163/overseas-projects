SELECT *
  FROM CD_DEPARTMENT CD, CD_DB_LINK DL
 WHERE CD.WMS_SERVER = DL.DB_ID(+)
   AND dl.DB_ID = '20190318001'
   AND CD.DEPT_TYPE = 0;

select ccc.check_code from CD_DEPARTMENT ccc where ccc.check_code is not null
   
select * from CD_DEPARTMENT where dept_code in( '1010') --for update;
select * from CD_DEPARTMENT where  WMS_SERVER = '20200731005' --for update;
select * from CD_DB_LINK where DB_ID in ('20130902001')
select * from CD_DB_LINK where DB_ID in ('20130618036','20151125001')
select * from CD_DB_LINK where DB_ID in ('20180206001','20200731001')  --for update;
select * from CD_DB_LINK where DB_ID in ('20190318001','20200731002')  --for update;
select * from CD_DB_LINK where DB_ID in ('20130618013','20200731003')  --for update;
select * from CD_DB_LINK where DB_ID in ('20181221100','20200731004')  --for update;
select * from CD_DB_LINK where DB_ID in ('201309020010','20200731005') --for update;
select * from CD_DB_LINK where DB_ID in ('20130618023','20200731006') --for update;
select * from CD_DB_LINK where DB_ID in ('20130711002','20130618007')  --for update;
--�Ϸʹ�Ͳϴ�»�
select * from CD_DB_LINK where DB_ID in ('20200527001','20200731007') --for update
--���캣��ϴ�»�
select * from CD_DB_LINK where DB_ID in ('20160717001','20200731008') --for update
--����յ�
select * from CD_DB_LINK where DB_ID in ('20130618007','20200731009') --for update
--�Ϸ�ϴ�»�
select * from CD_DB_LINK where DB_ID in ('20130618026','20200731010') --for update
--�Ϸʿյ�
select * from CD_DB_LINK where DB_ID in ('20130618034','20200731011') for update

select * from CD_DB_LINK where DB_name like '%1010%'


