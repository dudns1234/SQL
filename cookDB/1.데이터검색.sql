-- 1. cookDB 생성하기

-- 1-1. cookDB 생성
DROP DATABASE IF EXISTS cookDB; -- 만약 cookDB가 존재하면 우선 삭제
CREATE DATABASE cookDB;

-- 1-2. 회원 테이블과 구매 테이블 생성
USE cookDB;
-- 회원테이블
CREATE TABLE userTBL ( 
    userID CHAR(8) NOT NULL PRIMARY KEY,
    userName VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3),
    mobile2 CHAR(8),
    height SMALLINT,
    mDate DATE
);   
-- 구매테이블
CREATE TABLE buyTBL ( 
    num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userID CHAR(8) NOT NULL,
    prodName CHAR(6) NOT NULL,
    groupName CHAR(4),
    price INT NOT NULL,
    amount SMALLINT NOT NULL,
    FOREIGN KEY (userID)
        REFERENCES userTBL (userID)
);

-- 1-3. 회원/구매 테이블에 데이터 삽입
INSERT INTO userTBL VALUES ('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-8-8');
INSERT INTO userTBL VALUES ('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-7-7'); 
INSERT INTO userTBL VALUES ('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-9-9'); 
INSERT INTO userTBL VALUES ('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-5-5'); 
INSERT INTO userTBL VALUES ('KJD', '김제동', 1974, '경남', NULL , NULL, 173, '2013-3-3');
INSERT INTO userTBL VALUES ('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-4-4'); 
INSERT INTO userTBL VALUES ('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, '2008-10-10'); 
INSERT INTO userTBL VALUES ('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-4-4'); 
INSERT INTO userTBL VALUES ('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'); 
INSERT INTO userTBL VALUES ('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-5-5');
  
INSERT INTO buyTBL VALUES (NULL, 'KHD', '운동화', NULL, 30, 2);
INSERT INTO buyTBL VALUES (NULL, 'KHD', '노트북', '전자', 1000, 1); 
INSERT INTO buyTBL VALUES (NULL, 'KYM', '모니터', '전자', 200, 1);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '모니터', '전자', 200, 5); 
INSERT INTO buyTBL VALUES (NULL, 'KHD', '청바지', '의류', 50, 3);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '메모리', '전자', 80, 10);
INSERT INTO buyTBL VALUES (NULL, 'KJD', '책', '서적', 15, 5); 
INSERT INTO buyTBL VALUES (NULL, 'LHJ', '책', '서적', 15, 2);
INSERT INTO buyTBL VALUES (NULL, 'LHJ', '청바지', '의류', 50, 1); 
INSERT INTO buyTBL VALUES (NULL, 'PSH', '운동화', NULL, 30, 2); 
INSERT INTO buyTBL VALUES (NULL, 'LHJ', '책', '서적', 15, 1);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '운동화', NULL, 30, 2);

-- 1-4. 두 테이블에 삽입된 데이터 확인
SELECT * FROM userTBL;
SELECT * FROM buyTBL;

-- 2. WHERE 절
--  원 테이블(userTBL)에서 강호동의 정보만 조회
SELECT * FROM userTBL WHERE userName = '강호동';

-- 3. 조건 연산자와 관계 연산자
-- 회원 테이블에서 1970년 이후에 출생했고 키가 182cm 이상인 사람의 아이디와 이름을 조회
SELECT userID, userName FROM userTBL WHERE birthYear >= 1970 AND height >= 182;
-- 1970년 이후에 출생했거나 키가 182cm 이상인 사람의 아이디와 이름 조회
SELECT userID, userName FROM userTBL WHERE birthYear >= 1970 OR height >= 182;

-- 4. BETWEEN, AND, IN(), LIKE 연산자
-- 회원 테이블에서 키가 180~182cm인 사람 조회
SELECT userName, height FROM userTBL WHERE height >= 180 AND height <= 182;
-- 위 쿼리문은 BETWEEN … AND 연산자를 사용하여 다음과 같이 작성
SELECT userName, height FROM userTBL WHERE height BETWEEN 180 AND 182;
-- 지역이 경남 또는 충남 또는 경북인 사람은 OR 연산자를 사용하여 조회
SELECT userName, addr FROM userTBL WHERE addr='경남' OR addr='충남' OR addr='경북';
-- 이산적인(discrete) 값을 조회할 때는 IN( ) 연산자 사용
SELECT userName, addr FROM userTBL WHERE addr IN ('경남', '충남', '경북');
-- 성이 김 씨인 회원의 이름과 키 조회
SELECT userName, height FROM userTBL WHERE userName LIKE '김%';
-- 맨 앞의 한 글자가 무엇이든 상관없고 그다음이 ‘경규’인 사람 조회
SELECT userName, height FROM userTBL WHERE userName LIKE '_경규';

-- 5. 서브쿼리와 ANY, ALL, SOME 연산자
-- 김용만보다 키가 크거나 같은 사람의 이름과 키 출력
SELECT userName, height FROM userTBL
WHERE height > (SELECT height FROM userTBL WHERE userName = '김용만');
-- 지역이 경기인 사람보다 키가 크거나 같은 사람 추출
SELECT userName, height FROM userTBL
WHERE height >= (SELECT height FROM userTBL WHERE addr = '경기');

-- 6. ORDER BY 절
-- 가입한 순서대로 회원 출력(기본적으로 오름차순(ascending)으로 정렬)
SELECT userName, mDate FROM userTBL ORDER BY mDate;
SELECT userName, mDate FROM userTBL ORDER BY mDate DESC; -- DESC : 내림차순
SELECT userName, height FROM userTBL ORDER BY height DESC, userName ASC; -- 정렬기준 2개

-- 7. DISTINCT 키워드
-- 회원 테이블에서 회원들의 거주 지역이 몇 곳인지 출력
SELECT addr FROM userTBL; -- 중복존재(서울:4개, 경남:2개 ..)
SELECT DISTINCT addr FROM userTBL; -- 중복제거

-- 8. LIMIT 절
--  상위의 N개만 출력하는 LIMIT 절 사용
SELECT emp_no, hire_date FROM employees
ORDER BY hire_date ASC
LIMIT 5;
-- 'LIMIT 시작, 개수' 형식으로 조회
SELECT emp_no, hire_date FROM employees
ORDER BY hire_date ASC
LIMIT 0, 5;

-- 9.  CREATE TABLE ... SELECT 문
-- buyTBL 테이블을 buyTBL2 테이블로 복사하는 구문
CREATE TABLE buyTBL2 (SELECT * FROM buyTBL);
SELECT * FROM buyTBL2;
-- 지정한 일부 열만 복사
CREATE TABLE buyTBL3 (SELECT userID, prodName FROM buyTBL);
SELECT * FROM buyTBL3;
-- <중요> 기본키와 외래키 등의 제약 조건은 복사되지 않음!!!!