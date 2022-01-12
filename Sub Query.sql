use practice;

select  *
		,(select gender from customer where A.mem_no = mem_no) as gender
  from  sales as A;
  
select  *
  from  customer
 where  mem_no = '1000970';
 
select *
  from (
		select  mem_no
			    ,count(order_no) as 주문횟수
		  from  sales
		 group  
            by  mem_no
		)AS A;
        
select  count(order_no) as 주문횟수
  from  sales
 where  mem_no in (select mem_no from customer where year(join_date) = 2019);
        
        
select  *
	    ,year(join_date)
  from  customer;
  
select  count(order_no) as 주문횟수
  from  sales as A
 inner  
  join  customer as B
    on  A.mem_no = B.mem_no
 where  year(B.join_date) = 2019;

create temporary table sales_sub_query
select  A.구매횟수
	    ,B.*
  from  (
	    select  mem_no
			    ,count(order_no) as 구매횟수
		  from  sales
		 group  
            by  mem_no
		)as A
 inner
  join  customer as B
    on  A.mem_no = B.mem_no;
    
select  *
  from  sales_sub_query;
  
select  addr
	    ,sum(구매횟수) as 구매횟수
  from  sales_sub_query
 where  gender = 'Man'
 group  
    by  addr
having  sum(구매횟수) < 100
 order  
    by  sum(구매횟수) asc;
    
select  A.구매횟수
		,B.*
  from  (
		select  mem_no
				,count(order_no) as 구매횟수
          from  sales
		 group
            by  mem_no
		) As A
 inner  
  join  customer as B
    on  A.mem_no = B.mem_no;
