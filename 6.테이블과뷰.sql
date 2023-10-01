-- 테이블
DROP TABLE IF EXISTS buyTBL; -- 기존 테이블 삭제
CREATE TABLE buyTBL
( num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 기본키설정, AUTO_INCREMENT 설정
userID CHAR(8) NOT NULL, 
prodName CHAR(6) NOT NULL, 
groupName CHAR(4) NULL, 
price INT NOT NULL, 
amount SMALLINT NOT NULL, 
FOREIGN KEY(userID) REFERENCES userTBL(userID) -- 외래키로 설정
)

-- 임시테이블(일시적인것)
create temporary table temp_user_sum
as
select u.userid, username,avg(price*amount)
as user_avg
from usertbl u, buytbl b
where u.userid=b.userid
group by userid, username;

-- 뷰
CREATE VIEW v_userTBL
AS
    SELECT userID, userName, addr FROM userTBL;
SELECT * FROM v_userTBL; -- 뷰를 테이블이라고 생각해도 무방함!!

 ## view(view랑 table 구분함)
 -- CREATE OR REPLACE VIEW 문을 사용하여 기존의 뷰를 덮어써 새 뷰 만들기
 create or replace view v_user_sum as
 select u.userid, username,avg(price*amount)
 as user_avg
 from usertbl u, buytbl b
 where u.userid=b.userid
 group by userid, username;
 
select username, user_avg from user_sum  -- (만들어진 조건으로부터 where절 실행그래서 join은 한번만 실행하는거임)
where user_avg>100;

select username, user_avg from v_user_sum
where user_avg>200; -- 복잡한 쿼리를 단순하게 만듬

-- A:100 record
#table
-- 1.create table B as select*from A    100개  (B는 이미 실제 존재하는 값으로 만든것임(table))
-- insert into A:10           A에다가 인설트한다는건 A는 110 개
-- select count(*) from B          100개 (B는 100개 였을떄 만들어진거여서 100개임)
#view
-- 2.create view B as select*from A    100개  (view라는 테이블이 있는게 아니라 걍 정의만 해주는거임 실존X(view))
-- insert into A:10           A에다가 인설트한다는건 A는 110 개
-- select count(*) from B         110개 (view로 그냥 B로 만들어준거지 정의하지 않았으므로 110개임)
 
--                       영속성    sql실행하는 시점       물리적   u/d/i       원본데이터를 건들이냐마냐
-- create table            O          실행               O       O                  X
-- create temporary        X          실행               O       O                  X
-- create view             O       실제로 실행X,정의        X       ?                  O 

-- create view v_usertbl as        (v_usertbl 싷제 존재하는 테이블아님 가상의 테이블임)
-- select userid, username from usertbl;
-- insert into a_usertbl ... (잘못 실핼하면 원본데이터에 영향감)

