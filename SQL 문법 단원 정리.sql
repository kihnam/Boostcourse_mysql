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
        
/* 2. (1) 명령어에서 성별이 남성회원 조건을 추가한 뒤, 회원수가 50명 이상인 조건을 추가하시오. */
/* where절 / having절 활용 */

select  addr as 지역
		,year(join_date) as 가입연도
		,count(mem_no) as 회원수
  from  customer
 where  gender = 'Man'
 group  
    by  addr
		,year(join_date)
having  count(mem_no) > 50;

/* 3. (2) 명령어에서 회원수를 내림차순으로 정렬하시오 */

select  addr as 지역
		,year(join_date) as 가입연도
		,count(mem_no) as 회원수
  from  customer
 where  gender = 'Man'
 group  
    by  addr
		,year(join_date)
having  count(mem_no) > 50
 order  
    by  count(mem_no) desc;
    
/* 4. sales 테이블 기준으로 product 테이블을 left join 하시오. */
/* left join 활용 */

select  *
  from  sales as A
  left  
  join  product AS B
    on  A.product_code = B.product_code;
    
/* 5. (1)에서 결합된 테이블을 활용하여, 브랜드별 판매수량을 구하시오. */
/* group by절 / sum 함수 활용 */

select  B.brand
        ,sum(sales_qty) as 판매수량
  from  sales as A
  left  
  join  product AS B
    on  A.product_code = B.product_code
 group  
    by  B.brand;

/* 6. customer 및 sales 테이블을 활용하여, 회원가입만하고 주문이력이 없는 회원수를 구하시오. */
/* left join 활용 */

select  count(A.mem_no)
  from  customer as A
  left 
  join  sales as B
    on  A.mem_no = B.mem_no
 where  B.mem_no is null;
 
 /* 7. from절 서브쿼리를 활용하여, sales 테이블의 product_code별 판매수량을 구하시오. */
 /* from절 서브쿼리 / sum 함수 활용 */
 
 select *
   from (
		 select  product_code
				 ,sum(sales_qty) as 판매수량
		   from  sales
		  group  
			 by  product_code
		 ) as A;
         
/* 8. (1) 명령어를 활용하여, product 테이블과 left join 하시오 */
/* left join 활용 */

select  *
  from  (
		select  product_code
		        ,sum(sales_qty) as 판매수량
		  from  sales
		  group  
			 by  product_code
		 ) as A
   left  
   join  product as B
     on  A.product_code = B.product_code;
     
/* 9. (2) 명령어를 활용하여, 카테고리 및 브랜드별 판매수량을 구하시오. */
/* group by절 / sum 함수 활용 */

select  category
		,brand
        ,sum(판매수량) as 판매수량
  from  (
		select  product_code
		        ,sum(sales_qty) as 판매수량
		  from  sales
		  group  
			 by  product_code
		 ) as A
   left  
   join  product as B
     on  A.product_code = B.product_code
  group  
     by  category
         ,brand;