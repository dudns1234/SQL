-- "스토어드 프로그램"이란?
-- MySQL에서 제공하는 프로그래밍 언어 기능을 통틀어서 일컫는 말
-- 일반 쿼리를 묶는 역할을 할 뿐만 아니라 프로그래밍 기능도 제공함으로써 시스템의 성능이 향상
-- 종류에는 스토어드 프로시저, 스토어드 함수, 트리거, 커서 등이 있음

-- 간단하게 정리한 형식
DELIMITER $$ 
CREATE PROCEDURE 스토어드프로시저이름(IN 또는 OUT 매개변수) 
BEGIN
    이 부분에 SQL 프로그래밍 코딩
END $$ 
DELIMITER ;
CALL 스토어드프로시저이름();

-- 실습
## 
delimiter $$
create procedure userProc1 (in uname varchar(10))
begin
select addr from usertbl
where username=uname;
end $$
delimiter ;

call userProc1('강호동');

##
delimiter $$
create procedure userProc2 (in uname varchar(10),
 out uaddr varchar(10) )
begin
select addr into uaddr from usertbl
end $$
delimiter ;
call userProc2('남희석',@uaddr);
select @uaddr;

##
set@name='남희석';
call userProc2(@name, @uaddr);
select @uaddr;

##
drop procedure getTotal;
delimiter $$
create procedure getTotal (in uname varchar(10),out total float )
begin
 select sum(amount*price)into total from usertbl u, buytbl b
 where u.userid=b.userid and username=uname;
end $$
delimiter ;
call getTotal('강호동',@total);
select @total;