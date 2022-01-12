use practice;

select  *
  from  customer as A
 inner
  join  sales as B
    on  A.mem_no = B.mem_no
 where  A.mem_no = '1000970';
 
select  *
  from  customer as A
  left  
  join  sales as B
    on  A.mem_no = B.mem_no;
    
select  *
  from  customer as A
 right
  join  sales as B
    on  A.mem_no = B.mem_no
 where  A.mem_no is null;
  
select  *
  from customer as A
  join sales as B
    on A.mem_no= B.mem_no;
    
create temporary table customer_sales_inner_join
select  A.*
	    ,B.order_no
  from  customer as A
 inner  
  join  sales as B
    on  A.mem_no = B.mem_no;
    
select  *
  from  customer_sales_inner_join;
  
select  *
  from  customer_sales_inner_join
 where  gender = 'Man';
 
select  addr
		,count(order_no) as 구매횟수
  from  customer_sales_inner_join
 where  gender = 'Man'
 group
    by  addr;


select  addr
		,count(order_no) as 구매횟수
  from  customer_sales_inner_join
 where  gender = 'Man'
 group  
    by  addr
 having count(order_no) < 100;
 
select  addr
		,count(order_no) as 구매횟수
  from  customer_sales_inner_join
 where gender = 'Man'
 group  
    by  addr
having  count(order_no) < 100
 order  
    by  count(order_no) asc;
    
select  *
  from  sales as A
  left  
  join  customer as B
    on  A.mem_no = B.mem_no
  left  
  join  product as C
    on  A.product_code = c.product_code;
    
    
