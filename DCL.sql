use mysql;
select * from user;

create user 'test'@localhost identified by 'test';
select * from user;

set password for 'test'@localhost = '1234';

grant select, delete on practice.회원테이블 to 'test'@localhost;

revoke delete on practice.회원테이블 from 'test'@localhost;

grant all on practice.회원테이블 to 'test'@localhost;

revoke all on practice.회원테이블 from 'test'@localhost;

drop user 'test'@localhost;

select * from user;