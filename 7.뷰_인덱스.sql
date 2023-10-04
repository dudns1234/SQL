# 뷰
## 뷰의 생성
-- Book 테이블에서 '축구'라는 문구가 포함된 자료만 보여주는 뷰 생성
-- 1. 뷰에 사용할 select문
select * 
from book
where bookname like '%축구%';

-- 2. 위 select문을 이용해 뷰 정의문 작성
create view football_view
as select * 
    from book
    where bookname like '%축구%';

-- 3. football_view 확인
select * from football_view;

-- 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하라. 뷰의 이름은 vw_Customer로 설정
create view vw_Customer
as select *
from customer
where address like '%대한민국%';

select *
from vw_customer;

-- Orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, '김연아' 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.
create view vw_orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
as select od.orderid, od.custid, cs.name, od.bookid, bk.bookname, od.saleprice, od.orderdate
   from orders od, customer cs, book bk
   where od.custid=cs.custid and od.bookid=bk.bookid; -- 이중 조인

select orderid, bookname, saleprice
from vw_orders
where name='김연아';


## 뷰의 수정
-- CREATE OR REPLACE VIEW 문을 사용하여 기존의 뷰를 덮어써 새 뷰 만들기
-- vw_Customer는 주소가 대한민국인 고객을 보여줌. 이 뷰를 영국을 주소로 가진 고객으로 변경하고 phone 속성은 필요 없으므로 포함X
create or replace view vw_Customr(custid, name, address)
as select custid, name, address
   from customer
   where address LIKE '%영국%';
-- 결과 확인
select * from vw_customer;

## 뷰의 삭제
drop view vw_customer;

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


#인덱스
## 인덱스 생성
-- book 테이블의 bookname 열을 대상으로 인덱스 ix_book을 생성
create index ix_book on book(bookname);

-- book 테이블의 publisher, price 열을 대상으로 인덱스 ix_book2 생성
create index ix_book2 on book(publisher, price);

-- 생성된 인덱스는 SHOW INDEX 명령어로 확인
show index from book;

-- 실행 계획은 통한 인덱스 사용 확인
select *
from book
where publisher='대한미디어' and price >=30000;

## 인덱스의 재구성과 삭재
-- 인덱스 다시 생성
analyze table book;
-- 인덱스 삭제
drop index ix_book2 on book;
