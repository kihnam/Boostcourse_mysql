use practice;

drop table 회원테이블;

create table 회원테이블 (
회원번호 int primary key,
이름 varchar(20),
가입일자 date not null,
수신동의 bit
);

begin;

insert into 회원테이블 values (1001, '남기훈', '2022-01-01', 1);
select * from 회원테이블;

rollback;
select * from 회원테이블;

begin;

insert into 회원테이블 values (1002,'장보고', '2022-01-02', 0);

commit;
select * from 회원테이블;

delete from 회원테이블;
select * from 회원테이블;

begin;
insert into 회원테이블 values (1001, '남기훈', '2022-01-01', 1);
savepoint s1;
update 회원테이블
set 이름 = '이순신';
select * from 회원테이블;
delete from 회원테이블
where 이름= '이순신';
select * from 회원테이블;
rollback;
select * from 회원테이블;

select * from 회원테이블;

begin;
insert into 회원테이블 values (1001, '남기훈', '2022-01-01', 1);
savepoint s1;
select * from 회원테이블;
update 회원테이블
set 이름 ='이순신';
savepoint s2;
select * from 회원테이블;
delete from 회원테이블;
savepoint s3;
select * from 회원테이블;

rollback to s1;
select * from 회원테이블;
rollback to s2;
select * from 회원테이블;
rollback to s3;

begin;
select * from 회원테이블;
delete from 회원테이블;
begin;
insert into 회원테이블 values (1001, '남기훈', '2021-01-01', 1);
select * from 회원테이블;
update 회원테이블
set 이름 ='이순신';
select * from 회원테이블;
savepoint s1;
update 회원테이블
set 가입일자 ='2021-01-02';
savepoint s2;
update 회원테이블
set 수신동의 = 0;
select * from 회원테이블;
savepoint s3;

select * from 회원테이블;
rollback to s2;
select * from 회원테이블;

commit;
select * from 회원테이블;

