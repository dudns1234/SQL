-- 변수 사용 방식
SET @변수이름 = 변수값; -- 변수 선언 및 값 대입
SELECT @변수이름; -- 변수 값 출력

-- 변수 사용하기 (선언, 값대입, 출력)
set @p1 = 5;
set @p2 = 3;
select @p1;
SELECT @p1 + @p2;
select @p1, "이름", username from usertbl;

-- PREPARE 문과 EXECUTE 문에서 변수 활용
    -- PREPARE : 변수의 선언 및 출력준비, 'sql;문을 전달받아 변수의 출력 준비만 한다.
    -- ? : 변수의 값을 모름으로 표시한다.
    -- EXCUTE : 변수의 출력, PREPARE 준비해둔 sql문에 USEING 뒤에 있는 @변수명을 ?에 대입하여 출력한다.
SET @myVar1 = 3;
PREPARE myQuery
    FROM 'SELECT userName, height FROM userTBL ORDER BY height LIMIT ?';
EXECUTE myQuery USING @myVar1;
=> ?에 3대입하여 출력'

-- 키가 179이상이고 경기에 거주하는사람
prepare myquary2
from 'select username,height from usertbl where height >? and addr=?';

set@p1=179;
set@p2='경기';
execute myquary2 using @p1,@p2;


-- 데이터 형식 변환 함수
    -- 일반적으로 사용되는 데이터 형식 변환 함수는 CAST( )와 CONVERT( ) 
    -- CAST(expression AS 데이터형식 [(길이)]) / CONVERT(expression, 데이터형식 [(길이)]
SELECT AVG(amount) as '평균구매개수' FROM buyTBL; --> 2.9167
SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균구매개수' FROM buyTBL; --> 3
SELECT CONVERT(AVG(amount) AS SIGNED INTEGER) AS '평균구매개수' FROM buyTBL; --> 3
-- 날짜 형식(-)으로도 변경
SELECT CAST('2020$12$12' AS DATE);
SELECT CAST('2020/12/12' AS DATE);
SELECT CAST('2020%12%12' AS DATE);
SELECT CAST('2020@12@12' AS DATE);

select 'abc' = 'test';  -- 0
select '123'+'456';     -- 579
select '123'+'abc';     -- 123
select '123'+'7abc';    -- 130
select '123'+'abc7';    -- 123

-- 이름: [강호동]

select "이름:" + username from usertbl;

select concat(concat("이름:[",username), ']') from usertbl;
select concat("이름:[",username, ']') from usertbl;

select count(mobile1) from usertbl;

-- 내장 함수
-- 제어 흐름 함수
SELECT IF(100>200, '참이다', '거짓이다')
SELECT IFNULL(NULL, '널이군요'), IFNULL(100, '널이군요')
SELECT NULLIF(100, 100), IFNULL(200, 100);
SELECT CASE 10
    WHEN 1 THEN '일'
    WHEN 5 THEN '오'
    WHEN 10 THEN '십'
    ELSE '모름'
    END;
-- 문자열 함수
너무 많아서 생략...



    
