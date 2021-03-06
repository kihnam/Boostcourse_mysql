USE PRACTICE;

SELECT  A.MEM_NO, A.GENDER, A.BIRTHDAY, A.ADDR, A.JOIN_DATE
        ,SUM(B.SALES_QTY * PRICE) AS 구매금액
        ,SUM(B.ORDER_NO) AS 구매횟수
        ,SUM(B.SALES_QTY) AS 구매수량
  FROM  CUSTOMER AS A
  LEFT
  JOIN  SALES AS B
    ON  A.MEM_NO = B.MEM_NO
  LEFT
  JOIN  PRODUCT AS C
    ON  B.PRODUCT_CODE = C.PRODUCT_CODE
 GROUP  
    BY  A.MEM_NO, A.GENDER, A.BIRTHDAY, A.ADDR, A.JOIN_DATE;
    
CREATE TEMPORARY TABLE CUSTOMER_PUR_INFO AS
SELECT  A.MEM_NO, A.GENDER, A.BIRTHDAY, A.ADDR, A.JOIN_DATE
        ,SUM(B.SALES_QTY * PRICE) AS 구매금액
        ,SUM(B.ORDER_NO) AS 구매횟수
        ,SUM(B.SALES_QTY) AS 구매수량
  FROM  CUSTOMER AS A
  LEFT
  JOIN  SALES AS B
    ON  A.MEM_NO = B.MEM_NO
  LEFT
  JOIN  PRODUCT AS C
    ON  B.PRODUCT_CODE = C.PRODUCT_CODE
 GROUP  
    BY  A.MEM_NO, A.GENDER, A.BIRTHDAY, A.ADDR, A.JOIN_DATE;
    
SELECT  *
  FROM  CUSTOMER_PUR_INFO;
  
SELECT  *
	    , 2022-YEAR(BIRTHDAY) + 1 AS 나이
  FROM  CUSTOMER;
  
SELECT  *
		, CASE WHEN 나이 < 10 THEN '1O대 미만'
         	   WHEN 나이 < 20 THEN '2O대 미만'
               WHEN 나이 < 30 THEN '3O대 미만'
               WHEN 나이 < 40 THEN '4O대 미만'
               WHEN 나이 < 50 THEN '5O대 미만'
               ELSE '50대 이상' END AS 연령대
  FROM  (
		SELECT  *
				, 2022-YEAR(BIRTHDAY) + 1 AS 나이
		  FROM  CUSTOMER
		) AS A;
        
CREATE TEMPORARY TABLE CUSTOMER_AGEBAND AS
SELECT  *
		, CASE WHEN 나이 < 10 THEN '1O대 미만'
         	   WHEN 나이 < 20 THEN '2O대 미만'
               WHEN 나이 < 30 THEN '3O대 미만'
               WHEN 나이 < 40 THEN '4O대 미만'
               WHEN 나이 < 50 THEN '5O대 미만'
               ELSE '50대 이상' END AS 연령대
  FROM  (
		SELECT  *
				, 2022-YEAR(BIRTHDAY) + 1 AS 나이
		  FROM  CUSTOMER
		) AS A;
        
SELECT  *
  FROM  CUSTOMER_AGEBAND;
  
CREATE TEMPORARY TABLE CUSTOMER_PUR_INFO_AGEBAND AS
SELECT  A.*
		,B.연령대
  FROM  CUSTOMER_PUR_INFO AS A  
  LEFT  
  JOIN  CUSTOMER_AGEBAND AS B
    ON  A.MEM_NO = B.MEM_NO;
    
SELECT  *
  FROM  CUSTOMER_PUR_INFO_AGEBAND;
  
SELECT  A.MEM_NO
		,B.CATEGORY
		,COUNT(ORDER_NO) AS 구매횟수
        ,ROW_NUMBER() OVER(PARTITION BY A.MEM_NO ORDER BY COUNT(A.ORDER_NO) DESC) AS 구매횟수_순위
  FROM  SALES AS A
  LEFT  
  JOIN  PRODUCT AS B
    ON  A.PRODUCT_CODE = B.PRODUCT_CODE
 GROUP
    BY  A.MEM_NO
		,B.CATEGORY;
        
SELECT  *
  FROM  (
		SELECT  A.MEM_NO
				,B.CATEGORY
				,COUNT(ORDER_NO) AS 구매횟수
				,ROW_NUMBER() OVER(PARTITION BY A.MEM_NO ORDER BY COUNT(A.ORDER_NO) DESC) AS 구매횟수_순위
		  FROM  SALES AS A
		  LEFT  
		  JOIN  PRODUCT AS B
		    ON  A.PRODUCT_CODE = B.PRODUCT_CODE
		 GROUP  
		    BY  A.MEM_NO
			    ,B.CATEGORY
		) AS A
 WHERE  구매횟수_순위 = 1;
 
CREATE TEMPORARY TABLE CUSTOMER_PRE_CATEGORY AS
SELECT  *
  FROM  (
		SELECT  A.MEM_NO
				,B.CATEGORY
				,COUNT(ORDER_NO) AS 구매횟수
				,ROW_NUMBER() OVER(PARTITION BY A.MEM_NO ORDER BY COUNT(A.ORDER_NO) DESC) AS 구매횟수_순위
		  FROM  SALES AS A
		  LEFT  
		  JOIN  PRODUCT AS B
		    ON  A.PRODUCT_CODE = B.PRODUCT_CODE
		 GROUP  
		    BY  A.MEM_NO
			    ,B.CATEGORY
		) AS A
 WHERE  구매횟수_순위 = 1;
 
 SELECT  * 
   FROM  CUSTOMER_PRE_CATEGORY;
 
 CREATE TEMPORARY TABLE CUSTOMER_PUR_INFO_AGEBAND_PRE_CATEGORY AS
 SELECT  A.*
		 ,B.CATEGORY AS PRE_CATEGORY
   FROM  CUSTOMER_PUR_INFO_AGEBAND AS A
   LEFT
   JOIN  CUSTOMER_PRE_CATEGORY AS B
     ON  A.MEM_NO = B.MEM_NO;

SELECT  *
  FROM  CUSTOMER_PUR_INFO_AGEBAND_PRE_CATEGORY;
  
CREATE TABLE CUSTOMER_MART AS
SELECT  *
  FROM  CUSTOMER_PUR_INFO_AGEBAND_PRE_CATEGORY;

SELECT  *
  FROM  CUSTOMER_PUR_INFO_AGEBAND_PRE_CATEGORY;

/* 데이터 중복 확인 (데이터 정합성) */
SELECT  COUNT(MEM_NO)
		,COUNT(DISTINCT MEM_NO)
  FROM  CUSTOMER_MART;
  
/*요약 및 파생 변수 오류 확인 */
SELECT  SUM(A.SALES_QTY * B.PRICE) AS 구매금액
		,COUNT(A.ORDER_NO)         AS 구매횟수
        ,SUM(A.SALES_QTY)          AS 구매수량
  FROM  SALES AS A
  LEFT
  JOIN  PRODUCT AS B
    ON  A.PRODUCT_CODE = B.PRODUCT_CODE
 WHERE  MEM_NO = '1000005';
 
SELECT  *
  FROM  CUSTOMER_MART;
  
SELECT  *
  FROM  SALES AS A
  LEFT
  JOIN  PRODUCT AS B
    ON  A.PRODUCT_CODE = B.PRODUCT_CODE
 WHERE  MEM_NO = '1000005';
 
SELECT  *
  FROM  CUSTOMER AS A
  LEFT
  JOIN  SALES AS B
    ON  A.MEM_NO = B.MEM_NO;
 
SELECT  *
  FROM  CUSTOMER AS A
  LEFT
  JOIN  (
		SELECT  DISTINCT MEM_NO
          FROM  SALES
		) AS B
	ON  A.MEM_NO = B.MEM_NO;
    
SELECT  *
		,CASE WHEN B.MEM_NO IS NOT NULL THEN '구매'
			  ELSE '미구매' END AS 구매여부
  FROM  CUSTOMER AS A
  LEFT
  JOIN  (
		SELECT  DISTINCT MEM_NO
          FROM  SALES
		) AS B
	ON  A.MEM_NO = B.MEM_NO;
    
SELECT  구매여부
		,COUNT(MEM_NO) AS 회원수
  FROM  (
		SELECT  A.*
			   ,CASE WHEN B.MEM_NO IS NOT NULL THEN '구매'
					 ELSE '미구매' END AS 구매여부
		  FROM  CUSTOMER AS A
		  LEFT
		  JOIN  (
				SELECT  DISTINCT MEM_NO
				  FROM  SALES
		        ) AS B
		    ON  A.MEM_NO = B.MEM_NO
        ) AS A
 GROUP
    BY  구매여부;
    
SELECT  *
  FROM  CUSTOMER_MART
 WHERE  구매금액 IS NULL;
 
SELECT  *
  FROM  CUSTOMER_MART
 WHERE  구매금액 IS NOT NULL;
