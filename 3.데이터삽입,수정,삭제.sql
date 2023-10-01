-- insert 문
-- auto_increment : 자동으로 1부터 증가하는 값을 입력하는 키워드
create table testtbl2
(id int auto_increment primary key,
username char(3),
age int
);
Insert into testtbl2 values (null,'에디',15);
Insert into testtbl2 values (null,'포비',12);
Insert into testtbl2 values (null,'통통이',11);
select*from testtbl2; -- 확인

-- AUTO_INCREMENT 입력 값을 100부터 시작하도록 변경
ALTER TABLE testTBL2 AUTO_INCREMENT=100;
INSERT INTO testTBL2 VALUES (NULL, '패티', 13);
SELECT * FROM testTBL2 -- 확인 (id 1,2,3,100)

-- 초깃값을 1000으로 하고 증가 값을 3으로 변경
ALTER TABLE testTBL3 AUTO_INCREMENT=1000;
SET @@auto_increment_increment=3; -- 서버 변수인 @@auto_increment_ increment 변수 변경
INSERT INTO testTBL3 VALUES (NULL, '우디', 20);
INSERT INTO testTBL3 VALUES (NULL, '버즈', 18);
INSERT INTO testTBL3 VALUES (NULL, '제시', 19);
SELECT * FROM testTBL3; -- 확인 (id 1000, 1003, 1006)

-- 데이터 삽입 코드 줄이기!!
INSERT INTO testTBL3 VALUES 
(NULL, '토이', 17), 
(NULL, '스토리', 18),
(NULL, '무비', 19);


-- update 문
-- 'Kyoichi'의 Lname을 '없음'으로 수정
UPDATE testTBL4
SET Lname = '없음'
WHERE Fname = 'Kyoichi';
-- 전체 테이블의 내용을 수정하고 싶을 때는 WHERE 절 생략
UPDATE buyTBL
SET price = price * 1.5

-- Delete 문
-- DELETE 문에서 WHERE 절을 생략하면 테이블에 저장된 전체 데이터가 삭제
DELETE FROM testTBL4 WHERE Fname = 'Aamer';
-- Aamer 중에서 상위 몇 건만 삭제하고자 할 때는 추가로 LIMIT 절 사용
DELETE FROM testTBL4 WHERE Fname = 'Aamer' LIMIT 5;


-- 오류가 발생해도 계속 삽입되도록 설정
-- 1. 새 테이블 생성하기
-- 1-1. 멤버 테이블(memberTBL) 새로 만들고 데이터 삽입
CREATE TABLE memberTBL (SELECT userID, userName, addr FROM userTBL LIMIT 3); -- 3건만 가져옴
ALTER TABLE memberTBL
    ADD CONSTRAINT pk_memberTBL PRIMARY KEY (userID); -- 기본키 지정
SELECT * FROM memberTBL;

-- 2. 오류가 발생해도 계속 삽입되도록 설정
-- 2-1. 첫번째 데이터에서 기본키를 중복 입력하는 실수 범하기
INSERT INTO memberTBL VALUES ('KHD', '강후덜', '미국'); -- 기본키 중복 입력
INSERT INTO memberTBL VALUES ('LSM', '이상민', '서울');
INSERT INTO memberTBL VALUES ('KSJ', '김성주', '경기');
-- 2-2 SELECT * FROM memberTBL ; 문으로 조회
-- 2-3 기존의 INSERT INTO 문을 INSERT IGNORE INTO 문으로 수정한 후 다시 실행
INSERT IGNORE INTO memberTBL VALUES ('KHD', '강후덜', '미국');
INSERT IGNORE INTO memberTBL VALUES ('LSM', '이상민', '서울');
INSERT IGNORE INTO memberTBL VALUES ('KSJ', '김성주', '경기');
SELECT * FROM memberTBL;
-- 3 기본키가 중복되면 새로 삽입한 내용으로 수정하기
-- 3-1 데이터를 삽입할 때 기본키가 중복되면 새로 삽입한 데이터로 내용이 변경되게 하기
INSERT INTO memberTBL VALUES ('KHD', '강후덜', '미국')
ON DUPLICATE KEY UPDATE userName='강후덜', addr='미국';
INSERT INTO memberTBL VALUES ('DJM', '동짜몽', '일본')
ON DUPLICATE KEY UPDATE userName='동짜몽', addr='일본';
SELECT * FROM memberTBL

-- 실습
CREATE TABLE testtbl4 (
    username CHAR(10),
    age INT
);
insert into testtbl4 select username, age from testtbl2; -- 28,29번과의 차이점
select * from testtbl4;

CREATE TABLE testTBL5 
    (SELECT username, age FROM testtbl2);-- 28,29하나의 SQL문장
SELECT * FROM testtbl5;

-- 서울에  사는 사람들의(usertbl) 구매목록(buytbl)--  두개의 select로 써야했는데 이번에는 위처럼 사용해볼꺼임
CREATE TABLE temp (SELECT userid FROM usertbl WHERE addr = '경기');
select*from temp;

select sum(price*amount) from buytbl where userid in (select userid from temp);

-- 경기에 사는 사람 (userid, username, age) --age가 없음. 어떻게 해야할까?->2019-birthyear+1을 해주자
CREATE TABLE temp2 (SELECT userid,username,2019-birthyear+1 as age FROM usertbl WHERE addr = '경기'); -- userid,username를 temp2로 했다가 age를 추가하려면 temp3로 해야됨 아니면 drop table temp2하고 넣어줘야함
select*from temp2;

drop table temp3; -- temp3 지우기

update buytbl 
set price= price*1.5 
where amount =1;

delete from usertbl where userid='KHD';-- error남
delete from buytbl where userid='KHD';-- error안남
-- 
delete from buytbl where userid='KHD';-- buytbl, usertbl 순서 바꾸면 위에 error 안남
delete from usertbl where userid='KHD';

-- 경기도에 사는 사람 제거
delete from buytbl where userid in('LHJ','SDY');
delete from usertbl where userid in('LHJ','SDY');
select*from buytbl;

-- 1) 경기도에 사는 사람 검색
-- 2)-> temp4 테이블 제작
-- 3)delete buytbl<- temp
-- 4)delete usertbl<- temp

CREATE TABLE temp4 (SELECT userid FROM usertbl WHERE addr = '경기');

delete from buytbl where userid in(SELECT userid FROM temp4);
delete from usertbl where userid in(SELECT userid FROM temp4);
-- ㅣㅣ (같음)
delete from usertbl where userid in(SELECT userid FROM usertbl WHERE addr = '경기');
delete from usertbl where userid in(SELECT userid FROM usertbl WHERE addr = '경기');

INSERT INTO testtbl2 VALUES (40, '강후덜', 13) -- 에러남 그래서 73번 문장을 해주면 에러안남
on duplicate key update username='강후덜' , age=13;
