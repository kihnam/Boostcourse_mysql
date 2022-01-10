drop database practice;
create database practice;
use practice;
create table 회원테이블 (
회원번호 int primary key, 
이름 varchar(20),
가입일자 date not null,
수신동의 bit
);
select *
from 회원테이블;

alter table 회원테이블 add 성별 varchar(2);
select * from 회원테이블;

alter table 회원테이블 modify 성별 varchar(20);

alter table 회원테이블 change 성별 성 varchar(2);

alter table 회원테이블 rename 회원정보;

drop table 회원정보;

select *
from 회원정보;

create database practice
use practice;

use practice;

create table 회원테이블 (
회원번호 int primary key,
이름 varchar(20),
가입일자 date not null,
수신동의 bit
);

select * from 회원테이블;

insert into 회원테이블 values (1001, '홍길동', '2020-01-02', 1);
select * from 회원테이블;
insert into 회원테이블 values (1002, '이순신', '2020-01-03', 0);
insert into 회원테이블 values (1003, '장영실', '2020-01-04', 1);
insert into 회원테이블 values (1004, '유관순', '2020-01-05', 0);
select * from 회원테이블;
select * from 회원테이블;

insert into 회원테이블 values (1004, '남기훈', '2020-01-05', 1);
insert into 회원테이블 values (1005, '남기훈', null, 1);
select * from 회원테이블;

select 회원번호, 이름 from 회원테이블;
select 회원번호, 이름 as 성명 from 회원테이블;

use practice;

update 회원테이블
set 수신동의 = 0;
select 수신동의 from 회원테이블;

select * from 회원테이블;

update 회원테이블
set 수신동의 = 1;
where 가입일자 = '2020-01-05';

select * from 회원테이블;

update 회원테이블
set 수신동의 = 1
where 이름 = '2020-01-05';

select * from 회원테이블;

update 회원테이블
set 수신동의 = 1
where 회원번호 = 1004;

select * from 회원테이블;

update 회원테이블
set 수신동의 = 1
where 가입일자 = '2020-01-04';

select * from 회원테이블;


update 회원테이블
set 수신동의 = 1
where 이름 = '홍길동';

select * from 회원테이블;

update 회원테이블
set 이름 = '홍길동'
where 회원번호 = 1001;

select * from 회원테이블;
update 회원테이블
set 이름 = '이순신'
where 회원번호 = 1002;

update 회원테이블
set 이름 = '남기훈'
where 회원번호 = 1003;

update 회원테이블
set 이름 = '이동학'
where 회원번호 = 1004;

select * from 회원테이블;

update 회원테이블
set 수신동의 = 1
where 이름 = '홍길동';

select * from 회원테이블;

delete
from 회원테이블
where 이름 = '이동학';

select * from 회원테이블;

delete
from 회원테이블
where 이름 = '남기훈';

select * from 회원테이블;

delete
from 회원테이블;

select * from 회원테이블;
