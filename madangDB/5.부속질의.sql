# 부속질의
-- 형태
select sum(saleprice)
from orders
where custid= (select custid from customer where name='박지성');

## 스칼라 부속질의 - SELECT 부속질의
-- 형태
select custid, (select name from customer cs where cs.custid=od.custid),sum(saleprice)
from orders od
group by custid;

-- 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력)
select (select name from customer cs where cs.custid = od.custid) 'name',sum(saleprice) 'total'
from orders od
group by od.custid;
-- 결과 확인
select * from orders;

-- Orders 테이블에 각 주문에 맞는 도서이름을 입력
alter table orders add bname varchar(40);
update orders
set bname= (select bookname from book where book.bookid=orders.bookid);
-- 결과 확인
select * from orders;

## 인라인 뷰 - FROM 부속질의
-- 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력)
select cs.name, sum(od.saleprice)'total'
from (select custid, name from customer where custid<=2)cs, orders od
where cs.custid=od.custid
group by cs.name;

## 중첩질의 - WHERE 부속질의 (비교연산자, IN/NOT IN, ALL/SOME(ANY), EXISTS/NOT EXISTS)
-- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오(비교연산자)
select orderid, saleprice
from orders
where saleprice <= (select AVG(saleprice) from orders);
-- 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오(비교연산자)
select orderid, custid, saleprice
from orders md
where saleprice > (select AVG(saleprice) from orders so where md.custid=so.custid);
-- 대한민국에 거주하는 고객에세 판매한 도서의 총 판매액을 구하시오(IN, NOT IN)
select sum(saleprice)'total'
from orders
where custid in (select custid from customer where address like '%대한민국%');
-- 3번 구객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 판매금액을 보이시오(ALL.SOME(ANY))
select orderid, saleprice
from orders 
where saleprice > ALL(select saleprice from orders where custid='3');
-- 아래도 가능한가??
select orderid, saleprice
from orders 
where saleprice > (select max(saleprice) from orders where custid='3');

-- EXISTS 연산자를 사용하여 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.(EXISTS, NOT EXISTS)
select sum(saleprice) 'total'
from orders 
where exists (select * from customer where address like '%대한민국%' and customer.custid=orders.custid);

