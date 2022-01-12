use practice;

/* 1. Customer 테이블의 가입연도별 및 지역별 회원수를 조회하시오. */
/* from절 / group by절 / select절 / year 및 count 함수 활용 */

select  addr as 지역
		,year(join_date) as 가입연도
		,count(mem_no) as 회원수
  from  customer
 group  
    by  addr
		,year(join_date);