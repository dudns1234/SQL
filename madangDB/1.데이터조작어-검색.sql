# 데이터 조작어 - 검색
## SELECT 문
use madang;

-- book 테이블에서 모든 도서이름과 출판사를 검색
select bookname, publisher
from book;

### where 조건
-- 비교 : =,<,>,<>
-- 범위 : between 10 and 15
-- 집합 : in, not in
-- 패턴 : like'_축구%'
-- 복합조건 : and, or, not

-- 비교
	-- 가격이 10,000원 이상인 도서이름, 출판사를 검색
	select bookname, publisher
	from book
	where price >= 10000;

	-- 도서 테이블에 있는 모든 출판사를 검색
	select publisher from book;

	select distinct publisher from book; -- 중복값 제거

-- 범위
	-- 가격이 10,000원 이상 20,000원 이하인 도서 검색
	select *
	from book
	where price >= 10000 and price <= 20000;

	select *
	from book
	where price between 10000 and 20000; -- BETWEEN __ AND __ 연산자 사용

-- 집합
	select * from book where publisher in ('굿스포츠','대한미디어'); -- IN 연산자 사용

-- 패턴 : 패턴에 대해서 like 안에 사용 +연결, _ 특정문자, %0개이상의 문자, []안에 들어가는 문자, [^]안에 들어가지 않은 문자
	-- '축구의 역사'를 출간한 출판사를 검색
	select bookname, publisher
	from book
	where bookname like '축구의 역사';

	-- 도서이름에 '축구'가 포함된 출판사 검색
	select bookname, publisher
	from book
	where bookname like '%축구%';

	-- 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서 검색
	select bookname, publisher
	from book
	where bookname like '_구%';  -- %안써주면 에러남

-- 복합조건
	-- 축구에 관한 도서 중 가격이 20,000원 이상인 도서 검색
	select *
	from book
	where bookname like '%축구%' and price>=20000;

	-- 출판사가 '대한미디어' 혹은 '굿스포츠'인 도서를 검색
	select *
	from book
	where publisher = '대한미디어' or publisher= '굿스포츠';

### 정렬 (ASC DESC)
-- 도서를 이름순으로 검색 (오름차순)
select *
from book
order by bookname;

-- 도서를 이름순으로 검색 (내림차순)
select *
from book
order by bookname desc;

-- 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색
select *
from book
order by price, bookname;

-- 도서를 가격의 내림차순으로 검색하고, 가격이 같다면 출판사의 오름차순으로 출력
select *
from book
order by price desc, publisher asc;

## 집계함수 (dum, avg, min, max, count) & GROUP BY
-- 고객이 주문한 도서의 총 판매액
select sum(saleprice)
from orders;

-- 2번 김연아 고객이 주문한 도서의 총 판매액
select sum(saleprice) as '김연아 고갬님의 주문 총액'
from orders
where custid=2; 

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가
select sum(saleprice) as total,
	avg(saleprice) as average,
	min(saleprice) as minimum,
	max(saleprice) as maximum
from orders; 

-- 마당서점의 도서 판매 건수
select count(*)
from orders;

-- 고객별로 주문한 도서의 총 판매액
select custid, count(*) as '도서수량', sum(saleprice) as 총액
from orders
group by custid;

-- 가격이 8,000언 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하는데 두권 이상 구매한 고객만 출력
select custid, count(*) as 도서수량
from orders
where saleprice>=8000
group by custid
having count(*)>=2;

## 두 개 이상 테이블에서 SQL 질의
### 조인
-- 고객과 고객의 주문에 관한 데이터를 고객별로 정렬
select *
from customer, orders
where customer. custid = orders.custid
order by customer.custid;
=
select *
from customer inner join orders on customer.custid=orders.custid;

-- 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬
select name, sum(saleprice)
from customer, orders
where customer.custid= orders.custid
group by customer.name
order by customer.name;

-- 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름
select customer.name, book.bookname
from customer, book, orders
where customer.custid = orders.custid and book.bookid= orders.bookid
and book.price=20000;

### 외부조인
-- 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격
select customer.name, saleprice
from customer left outer join orders
on customer.custid=orders.custid;


### 부속 질의
-- 가장 비싼 도서의 이름
select bookname
from book where price = (select max(price) from book); -- max(price)로만 할 수 없음

-- 도서를 구매한 적이 있는 고객의 이름
select name
 from customer
 where custid in (select custid from orders);

-- 대한미디어에서 출판한 도서를 구매한 고객의 이름
select name
from customer
where custid in (select custid from orders
where bookid in (select bookid from book
where publisher = '대한미디어'));

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서
select b1.bookname
from book b1
where b1.price > (select avg(b2.price)from book b2
where b1.publisher=b2.publisher);

### 집합 연산
-- 대한민국 거주 도서주문 고객 이름 (합집합)
select name
from customer
where address like '대한민국%'
union -- 만약 union 대신 union all로 사용하면 중복되는값 포함 
select name
from customer
where custid in (select custid from orders);
--> union시 결과 : 김연아 장미란 박세리 박지성 추신수 
--> union all시 결과 : 김연아 장미란 김연아 박세리 박지성 장미란 ...

-- MYSQL에는 MINUS, INTERSECT 연산자 없어 NOT IN, IN 연산자를 사용
-- 책을 구매하지 않은 사람중에 대한민국에 사는사람(차집합)
select name
from customer
where address like '대한민국%' and
name NOT IN (select name
from customer
where custid in (select custid from orders));

-- 대한민국에 거주하면서 책을 산사람(교집합)
select name
from customer
where address like '대한민국%' and
name IN (select name
from customer
where custid in (select custid from orders));

### EXISTS (존재여부)
-- 주문이 있는 고객의 이름과 주소
select name, address
from customer cs
where exists (select * from orders where orders.custid=cs.custid);