# 저장 프로그램
## 프로시저
-- 간단하게 정리한 형식----------------------------
DELIMITER $$ 
CREATE PROCEDURE 스토어드프로시저이름(IN 또는 OUT 매개변수) 
BEGIN
    이 부분에 SQL 프로그래밍 코딩
END $$ 
DELIMITER ;
CALL 스토어드프로시저이름();
--------------------------------------------------

-- book 테이블에 한 개의 투플을 삽입하는 프로시저
use madang;
-- 프로시저 정의
delimiter // -- 이 문장이 끝났음을 알려주는 부호
create procedure InsertBook(
 in mybookid integer, -- 변
 in mybookname varchar(40), -- 수
 in mypublisher varchar(40), -- 인
 in myprice integer) -- 자
begin -- 본격 시작
 insert into book(bookid,bookname,publisher, price)
 values (mybookid, mybookname, mypublisher, myprice);
end; -- 끝
//
delimiter ;
-- 프로시저 실행 (프로시저 InsertBook 테스트)
call insertbook(13, '스포츠 과학','마당과학서점',25000);
-- 결과 확인
select * from book;
-- 프로시저 삭제
DROP procedure InsertBook;

-- 동일한 도서가 있는지 점검한 후 삽입
delimiter //
create procedure bookinsertorupdate(
 mybookid integer,
 mybookname varchar(40),
 mypublisher varchar(40),
 myprice integer)
begin
 declare mycount integer;
 select count(*) into mycount from book
  where bookname like mybookname;
 if mycount !=0 then
  update book set price=myprice
  where bookname like mybookname;
 else
  insert into book(bookid, bookname, publisher, price)
  values(mybookid,mybookname,mypublisher,myprice);
 end if;
end;
//
delimiter ;

drop procedure bookinsertorupdate;
-- bookinsertorupdate 프로시저를 실행하여 테스트
call bookinsertorupdate(15,'스포츠','마당과학서점',25000);
-- 삽입 결과 확인
select * from book;
-- bookinsertorupdate 프로시저를 실행하여 테스트
call bookinsertorupdate(15,'스포츠','마당과학서점',20000);
-- 가격 변경 확인

-- book 테이블에 저장된 도서의 평균가격을 반환하는 프로시저
delimiter //
create procedure avgprice(
	out avgval integer)
begin
	select avg(price) into avgval from book where price is not null; -- into문은 변수에 값을 저장할 때 사용
end;
//
delimiter ;
-- 프로시저 averageprice를 테스트
call avgprice(@myvalue);
select @myvalue;

-- orders 테이블의 판매 도서에 대한 이익을 계산하는 프로시저 (커서이용)
delimiter //
create procedure interest() -- input도 output도 없는 프로시저
begin  
	declare myinterest integer default 0.0;
    declare price integer;
    declare endofrow boolean default false;
    declare interestcursor cursor for -- saleprice를 왔다갔다하는 커서 
        select saleprice from orders;
    declare continue handler -- error 찾는데 사용
        for not found set endofrow=true; -- not found 조건이 되었을 때 handler   
    open interestcursor; -- 커서 시작
    cursor_loop: Loop -- while문
		fetch interestcursor into price;
        if endofrow then leave cursor_loop; -- leave : 커서 루프를 떠나줘
        end if; 
        if price>=30000 then
			set myinterest = myinterest + price + 0.1;
        else
			set myinterest = myinterest + price + 0.05;
        end if;
	end loop cursor_loop;
    close interestcursor; -- 커서 닫기
    select concat('전체 이익 금액=',interest);
end;
//
delimiter ;
-- interset 프로시저를 실행하여 판매된 도서에 대한 이익금을 계산
call interest();


## 트리거
-- 신규 도서를 삽입한 후 자동으로 book_log 테이블에 삽입한 내용을 기록
SET global log_bin_trust_function_creators=ON; -- 보안을 위해서 root 계정 안쓰면 이문장을 써줘야함!
-- book_log 테이블 생성
create table book_log(
bookid_1 integer,
bookname_1 varchar(40),
publisher_1 varchar(40),
price_1 integer);
select * from book_log;

delimiter //
create trigger afterinsertbook
	after insert on book for each row -- for each row : 각 행에 대해서
begin
	insert into book_log
    values (new.bookid, new.bookname, new.publisher, new.price); -- new. : 새로운 값
end;
//
delimiter ;
-- 삽입한 내용을 기록하는 트리거 확인
insert into book values (16, '스포츠','이상미디어',25000);
select * from book where bookid=14;
select * from book_log where bookid_1='14'; -- 결과확인


## 사용자 정의 함수
-- 판매된 도서에 대한 이익을 계산하는 방법 (fnc_interest 함수 정의)
delimiter //
create function fnc_interest(price integer) returns integer -- price를 int로 받고 뱉어내는 것도 int로 하겠다

begin
	declare myinterest integer;
    -- 가격이 30,000원 이상이먄 10%, 30,000원 미만이면 5%ㅡㅡㅡ
    if price>=30000 then set myinterest = price*0.1;
    else set myinterest=price*0.05;
    end if;
    return myinterest;
end;
//
delimiter ;
-- orders 테이블에서 각 주문에 대한 이익을 출력 (fnc_interest 함수 테스트)
select custid, orderid, saleprice, fnc_interest(saleprice) interest from orders;

-- 개인과제 ( bookname에 축구라는 단어가 포함되어 있으면 foot_ball 컬럼에 "축구" 포함되어 있지 않으면 "축구 아님" 기입
use madang;
set global log_bin_trust_function_creators=on;
delimiter //
create function football_book(bookname varchar(40)) returns varchar(10)
begin
	declare football varchar(10);
    if bookname = '%축구%' then
		set football='축구';
	else
		set football='축구 아님';
	end if;
    return football;
end;
//
delimiter ;
select bookid, bookname, football_book(bookname) from book;      