use test;

SHOW TABLES;

SELECT * FROM user1;

SELECT * FROM user1 WHERE AGE >= 30;

--  GROUP BY
-- FROM절에 오는 TABEL에서 특정 컬럼의 값을 기준으로 데이터를 묶는다.

USE world;
SELECT * FROM city LIMIT 10;

SELECT CountryCode, avg(Population) as "avg_pop"
FROM city
GROUP BY CountryCode; 

SELECT COUNTRYCODE, DISTRICT, count(*)
FROM city
GROUP BY COUNTRYCODE, DISTRICT;

SELECT COUNTRYCODE,
		AVG(POPULATION) AS " AVG_POP",
        STDDEV(POPULATION) AS "STD_POP",
        MAX(POPULATION) AS "MAX_POP",
        MIN(POPULATION) AS "MIN_POP"
FROM city
GROUP BY COUNTRYCODE
ORDER BY STD_POP DESC;

-- 인구수가 500만 이상인 도시에 대해 집계
SELECT COUNTRYCODE,
		AVG(POPULATION) AS " AVG_POP",
        STDDEV(POPULATION) AS "STD_POP",
        MAX(POPULATION) AS "MAX_POP",
        MIN(POPULATION) AS "MIN_POP"
FROM city
WHERE POPULATION >= 5000000
GROUP BY COUNTRYCODE
HAVING STD_POP >= 300000
ORDER BY STD_POP DESC;

-- 나라코드에 K가 들어가는 나라들의 인구수의 총 합이 5백만 이상인 나라만 조회(CountryCode, 인구수 합)
SELECT COUNTRYCODE, SUM(POPULATION) 'SUM_POP'
FROM city
WHERE COUNTRYCODE LIKE '%K%'
GROUP BY COUNTRYCODE
HAVING SUM_POP >= 5000000;

SELECT * FROM country;

# 1. country 테이블에서 대륙별 인구수와 gnp 최대값을 조회
SELECT Continent, SUM(population), max(gnp)
FROM country
GROUP BY Continent;

# 2. country 테이블에서 대륙(continent)별 인구수와 GNP 평균 값을 조회. (단 GNP와 인구수가 0이 아닌 데이터 중에서)
SELECT Continent, SUM(population), avg(gnp)
FROM country
WHERE GNP != 0 AND POPULATION != 0 
GROUP BY Continent;

# 3. country 테이블에서 대륙별 평균 인구수와 평균 GNP 결과를 인구수로 내림차순 정렬( 단 GNP, Population 이 0이 아닌 나라)
SELECT Continent, avg(population) AVG_POP, avg(gnp)
FROM country
WHERE GNP != 0 AND POPULATION != 0 
GROUP BY Continent
ORDER BY AVG_POP DESC;

# 4 country 테이블에서 대륙별 평균 인구수, 평균 GNP, 1인당 GNP(평균 GNP / 평균 인구 * 1000)
# 결과를 1인당 GNP가 0.01 이상인 데이터를 조회하고 1인당 GNP를 내림차순으로 정렬( 단 gnp, population은 0이 아닌 나라)
SELECT Continent, avg(population) AVG_POP, avg(gnp) avg_gnp, avg(gnp)/avg(population)*1000 GNP_POP_AVG
FROM country
WHERE GNP != 0 AND POPULATION != 0 
GROUP BY Continent
HAVING GNP_POP_AVG >= 0.01
ORDER BY GNP_POP_AVG DESC;

-- SELECT절 문법
-- 1. CEIL, ROUND, TRUNCATE
-- 		CEIL : 실수 데이터에서 올림 할 때 사용
SELECT CEIL(12.345);
--		ROUND : 반올림 할 때 사용
SELECT ROUND(12.345,2), ROUND(12.343, 2);

-- 국가 별 언어 사용 비율을 소수 첫 번째 자리에서 반올림하여 정수로 표현
SELECT COUNTRYCODE, LANGUAGE, ISOFFICIAL, ROUND(PERCENTAGE,0) FROM countrylanguage;

-- truncate : 실수 데이터를 버림(내림)할 때 사용
SELECT truncate(12.345, 2);

-- 2. 조거눈(Conditional)
--		IF(조건, 참 expr, 거짓 expr)

SELECT IF(10>11, "참입니다", "거짓입니다");

# city 테이블에서 도시의 인구가 100만이 넘으면 big city, 그렇지 않으면 small city를 출력하는 city_scale으로 조회(alias)
SELECT Name, IF(POPULATION >= 1000000, "BIG CITY", "SMALL CITY") CITY_SCALE
FROM city;

# 100만이 넘어가면 Big City, 50만이 넘으면 Middle City 그외에는 small city
SELECT NAME, IF(POPULATION > 1000000, "Big City", IF(POPULATION > 500000, "Middle City", "Small City")) AS city_scale
FROM city;

# CASE WHEN : IF 의 상위 호환
# CASE
	# WHEN (조건1) THEN expr
	# WHEN (조건2) THEN expr
	# WHEN (조건3) THEN expr
    # ELSE expr
# END

SELECT Name, CASE
				WHEN POPULATION >= 1000000 THEN "Big City"
				WHEN POPULATION BETWEEN 500000 AND 999999 THEN "Middle City"
				ELSE "Small City"
            END CITY_SCALE
FROM city;

-- DATE_FORMAT : 날짜 데이터에 대한 포맷 변경
-- 날짜 형식으로 되어있는 데이터에서 필요한 부분만 추출하는 것이 가능
-- EX) 년도, 월, 일, 시간, 분, 초 식으로 추출이 가능
USE sakila;

SELECT * FROM payment;

SELECT payment_date, 
	   DATE_FORMAT(payment_date,"%Y") as "year",
       DATE_FORMAT(payment_date,"%m") as "month",
       DATE_FORMAT(payment_date,"%d") as "day",
       DATE_FORMAT(payment_date,"%Y년 %m월 %d일")
FROM payment;

# 년도 별 amount의 평균, 년도 오름차순 정렬
SELECT
	DATE_FORMAT(payment_date, "%Y") as yearly,
    AVG(amount) as avg_amount
FROM PAYMENT
group by yearly
order by yearly;

# JOIN
use test;

SELECT * FROM user;
SELECT * FROM addr;

# Cartesian Join. 클라이언트에게 서비스 할 때는 사용되지 않는다.
# 데이터 분석에서는 Cartesian Join을 굉장히 많이 사용한다. Code 부여(집계용 코드)를 위해
SELECT * FROM user, addr;

# inner join
SELECT *
FROM user -- FROM절에 오는 테이블이 기준 테이블
JOIN addr ON user.user_id = addr.user_id; -- 대상 테이블

# left join
# 모든 사용자의 이름과 주소를 출력
# 주소가 없는 사람은 "주소없음"으로 출력
SELECT user.name, IFNULL(addr.addr,"주소없음")
FROM user
LEFT JOIN addr ON user.user_id = addr.user_id;


-- 도시 이름에 k가 들어가는 도시의 개수, 나라 이름에 A가 들어가는 나라들의 gnp 평균
use world;

SELECT (SELECT COUNT(*)
		FROM city
		where name like '%K%') CNT, (SELECT AVG(gnp)
									FROM country
									where name like '%A%') AVG_GNP;

-- 1. 서브쿼리를 사용하지 않고 구하기
SELECT CountryCode, name, Population
FROM city
WHERE Population >= 8000000;

-- 2. 서브쿼리를 사용해서 구하기
SELECT city_sub.CountryCode,
	   city_sub.Name as "city_name",
       city_sub.Population as "city_pop",
       country.Name as "country_name"
FROM ( SELECT COUNTRYCODE, NAME, POPULATION
	   FROM city
       WHERE POPULATION >= 8000000
	 ) AS city_sub
JOIN country ON city_sub.CountryCode = country.Code;

-- 3. WHERE 절에 사용하기
SELECT *
FROM country
WHERE code IN ("KOR","JPN");

# 도시 인구수 800만 이상 도시의 국가코드, 국가 이름, 대통령 이름 출력alter
SELECT code, NAME, headofstate
FROM country
WHERE CODE IN ( SELECT distinct(CountryCode)
				FROM city
				WHERE POPULATION >= 8000000 );



