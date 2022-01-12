use practice;

select *
from customer;

select *
from customer
where gender = 'man';

select addr, count(mem_no) as 회원수
from customer
where gender = 'Men'
group by addr;

select addr, count(MEM_NO) as 회원수
from customer
where gender = 'Men'
group by addr;

select addr, count(mem_no) as 회원수
from customer
where gender = 'Man'
group by addr;

select addr, count(mem_no) as 회원수
from customer
where gender = 'Man'
group by addr;
having count(mem_no) < 100;

select addr, count(mem_no) as 회원수
from customer
where gender = 'Man'
group by addr;
having count(mem_no) < 100;

select addr, count(mem_no) as 회원수
from customer
where gender = 'Man'
group by addr
HAVING count(mem_no) < 100;

select addr, count(mem_no) as 회원수
from customer
where gender = 'Man'
group by addr
having count(mem_no) < 100
order by count(mem_no) desc;

select addr, count(mem_no) as 회원수
from customer
group by addr;

select addr, gender, count(mem_no) as 회원수
from customer
group by addr, gender;

select addr, gender, count(mem_no) as 회원수
from customer
where addr in ('SEOUL','INCHEON')
group by addr, gender;

select *, count(mem_no)
from customer
where gender = 'Man'
group by addr
having count(mem_no) < 100
order by count(mem_no) desc;

select  *
from  customer;

select  addr
		,count(mem_no) as 회원수
  from  customer
 where  gender = 'Man'
 group
    by  addr
having  count(mem_no) < 100
 order
    by  count(mem_no) desc;