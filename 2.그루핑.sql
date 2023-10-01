-- 10. GROUP BY 절
-- 형식!
SELECT select_expr
[FROM table_references]
[WHERE where_condition]
[GROUP BY {col_name | expr | position}]
[HAVING where_condition]
[ORDER BY {col_name | expr | position}]

-- 구매 테이블 (buyTBL)에서 아이디(userID)마다 구매한 물건의 개수(amount)를 조
SELECT userID AS '사용자 아이디', SUM(amount) AS '총 구매 개수'
FROM buyTBL GROUP BY userID;

-- 구매액의 총합
SELECT userID AS '사용자 아이디', SUM(price * amount) AS '총구매액'
FROM buyTBL GROUP BY userID;

-- 11. 집계함수
-- 회원별로 한 번 구매할 때마다 평균적으로 몇 개를 구매했는지 조회(GROUP BY 절 사용)
SELECT userID, AVG(amount) AS '평균 구매 개수'
FROM buyTBL GROUP BY userID;

-- 가장 키가 큰 회원과 가장 키가 작은 회원의 이름과 키 출력
SELECT userName, height
FROM userTBL
WHERE height = (SELECT MAX(height) FROM userTBL)
OR height = (SELECT MIN(height) FROM userTBL);
-- 휴대폰이 있는 회원의 수(의도와 다르게 전체 회원이 조회됨)
SELECT COUNT( * ) FROM userTBL;
-- 휴대폰이 있는 회원만 세려면 휴대폰 열이름(mobile1)을 지정해야 함
SELECT COUNT(mobile1) AS '휴대폰이 있는 사용자' FROM userTBL;

-- 12. HAVING 절
-- 총 구매액이 1000 이상인 회원에게만 사은품을 증정하고 싶다면? (총 구매액이 적은 회원 순으로 정렬)
SELECT userID AS '사용자', SUM(price * amount) AS '총구매액'
FROM buyTBL
GROUP BY userID
HAVING SUM(price * amount) > 1000
ORDER BY SUM(price * amount);

SELECT userid, price*amount FROM buytbl
order by userid;

# KHD 60+1000+150 KHD가 구입한 가격양
# KJD 75
# KYM 150
# LHK 30+50+15

SELECT sum(price*amount) FROM buytbl; -- 전체 합함

SELECT userid, sum(price*amount) FROM buytbl
group by userid; -- userid별 총합

select userid as 아이디, sum(amount) sum_amount from buytbl  -- as 생략가능
group by userid
order by sum_amount;

select sum(price*amount),
    avg(amount) from buytbl;

select count(mobile1) from usertbl; -- 현재 회원수 작성(mobile1은 8명인 이유:buytbl에 가서 보면 2명이 NULL이기때문에 count에서 제거)

#지역별 회원수 출력

select addr, count(*) from usertbl -- count, sum 차이는 
group by addr;

#제품별 판매 수량 ( 판매 수량별대로 정리)

select prodname, sum(amount)as hhh from buytbl -- as 생략가능, hhh는 그냥 이름 아무렇게 지은거임
group by prodname
order by hhh;

#회원이 몇개의 지역에 살고있는지
select count(distinct addr) from usertbl-- distinct 중복제거
order by addr; 

# 사용자 별대로 총 얼마를 구입했는지

select userid as '사용자',
	sum(price*amount) AS total -- '총구매액'말고 되도록이면 total 영어로 쓰기
    from buytbl
    group by userid
    having total > 1000;
    
#이휘재가 구매한 물건의 총합
select userid, sum(price*amount) from buytbl where userid='LHJ' group by userid;

select userid, sum(price*amount) from buytbl 
   where userid in
(  select userid from usertbl 
     where username in ('강호동','이휘재') ) 
group by userid;

#5개이상 팔린 물건의 이름
select prodname, sum(amount) S from buytbl
group by prodname
having s > 5;