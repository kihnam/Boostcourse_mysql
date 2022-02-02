USE PRACTICE;

/* SQL 데이터 분석 단원 분석용 데이터 마트  */

CREATE TABLE SQL_DATA_ANALYSIS AS
SELECT  A.*
		,DATE_FORMAT(A.JOIN_DATE, '%Y-%m') AS 가입년월
        ,CASE WHEN 2021 - YEAR(BIRTHDAY) +1 < 20 THEN '10대이하'
			  WHEN 2021 - YEAR(BIRTHDAY) +1 < 30 THEN '20대'
              WHEN 2021 - YEAR(BIRTHDAY) +1 < 40 THEN '30대'
              WHEN 2021 - YEAR(BIRTHDAY) +1 < 50 THEN '40대'
              ELSE '50대 이상' END AS 연령대
		,CASE WHEN C.MEM_NO IS NOT NULL THEN '구매'
			  ELSE '미구매' END AS 구매여부
              
		,B.구매금액 AS 2020_구매금액
        ,B.구매횟수 AS 2020_구매횟수
        ,CASE WHEN B.구매금액 > 5000000 THEN 'VIP'
              WHEN B.구매금액 > 1000000 OR B.구매횟수 > 3 THEN '우수회원'
              WHEN B.구매금액 >       0 THEN '일반회원'
              ELSE '잠재회원' END AS 2020_회원세분화
              
		,CASE WHEN DATE_ADD(C.최초구매일자, INTERVAL +1 DAY) <= C.최근구매일자 THEN 'Y' ELSE 'N' END AS 재구매여부
        ,DATEDIFF(C.최근구매일자, C.최초구매일자) AS 구매간격
        ,CASE WHEN C.구매횟수 -1 = 0 OR DATEDIFF(C.최근구매일자, C.최초구매일자) = 0 THEN 0
			  ELSE DATEDIFF(C.최근구매일자, C.최초구매일자) / (C.구매횟수 -1) END AS 구매주기
  FROM  CUSTOMER AS A
  LEFT
  JOIN  (
		SELECT  A.MEM_NO
				,SUM(A.SALES_QTY * B.PRICE) AS 구매금액
                ,COUNT(A.ORDER_NO) AS 구매횟수
		  FROM  SALES AS A
          LEFT
          JOIN  PRODUCT AS B
            ON  A.PRODUCT_CODE = B.PRODUCT_CODE
		 WHERE  YEAR(A.ORDER_DATE) = '2020'
         GROUP
            BY  A.MEM_NO
        ) AS B
    ON  A.MEM_NO = B.MEM_NO
  LEFT
  JOIN  (
		SELECT  MEM_NO
				,MIN(ORDER_DATE) AS 최초구매일자
                ,MAX(ORDER_DATE) AS 최근구매일자
                ,COUNT(ORDER_NO) AS 구매횟수
		  FROM  SALES
		 GROUP
            BY  MEM_NO 
        ) AS C
    ON A.MEM_NO = C.MEM_NO;
    
SELECT  *
  FROM  SQL_DATA_ANALYSIS;


/* 정합성 체크 */
SELECT  COUNT(DISTINCT MEM_NO)
		,COUNT(MEM_NO)
  FROM  SQL_DATA_ANALYSIS;

/* 1. RFM 세분화별 평균 나이 및 구매주기 */
SELECT  2020_회원세분화
		,AVG(2021 - YEAR(BIRTHDAY) + 1) AS 평균_나이
        ,AVG(CASE WHEN 구매주기 > 0 THEN 구매주기 END) AS 평균_구매주기
  FROM  SQL_DATA_ANALYSIS
 GROUP
    BY  2020_회원세분화;

/* 2. 연령대별 재구매 회원수 비중 (%) */
SELECT  연령대
		,COUNT(DISTINCT CASE WHEN 구매여부 = '구매' THEN MEM_NO END) AS 구매회원수
        ,COUNT(DISTINCT CASE WHEN 재구매여부 = 'Y' THEN MEM_NO END) AS 재구매회원수
  FROM  SQL_DATA_ANALYSIS
 GROUP
    BY  연령대;
