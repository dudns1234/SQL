# 숫자함수(ABS함수 - 절댓값)
-- +50과 -50의 절댓값을 구하시오
select abs(50), abs(-50);

# 숫자함수(ROUND함수 - 반올림)
-- 4.875를 소수 첫째 자리까지 반올림한 값을 구하시오
select round(4.875,1);
select round(4.875,0);
select round(4.875,-1);

-- 고객별 평균 주문금액을 100원단위로 반올림한 값을 구하시오
select custid, round(avg(saleprice),-2) #100원단위니깐 -2임
from orders
group by custid;

# 문자함수(REPLACE함수)
-- 문자함수, 도서제목에 야구가 포함된 도서를 농구로 변경한 후 도서목록을 보이라
select bookid, replace(bookname,'야구','농구') bookname, publisher, price
from book;

# 문자함수(CHAR_LENGTH, LENGTH 함수)
-- Byte수, 굿스포츠에서 출판한 도서의 제목과 제목의 문자수 바이트수를 보이시오
select bookname, char_length(bookname), length(bookname)
from book;

# 문자함수(SUBSTR함수)
-- substr, 마당서점의 고객중에서 같은 성을 가진 사람이 몇명이되는지 성별인원수를 구해라
select substr(name, 1,1), count(*)
from customer
group by substr(name,1,1);

# 날짜 / 시간함수(ADDDATE)
-- 날짜관련, 마당서점은 주문일로부터 10일후에 확정날짜를 구하시오
select orderid, orderdate, adddate(orderdate, interval 10 day)
from orders;

# 날짜 / 시간함수(STR_TO_DATE 함수, DATE_FORMAT 함수)
-- 마당서점이 2014년 7월 7일에 주문받은 도서의 주문번호,주문일~ 모두 보이시오. 단, 주문일은 '%Y-%m-%d' 형태로 표시
select orderid, str_to_date(orderdate,'%Y-%m-%d'), custid, bookid
from orders
where orderdate=date_format('20140707','%Y-%m-%d');  #날짜형을 문자형으로 바꿔줄때

# 날짜 / 시간함수(SYSDATE 함수)
-- DBMS 서버에 설정된 현재 날짜와 시간, 요일 확인
select sysdate(), date_format(sysdate(),'%Y/%m/%d %M %h:%s') 'SYSDATE_1';

# NULL 값 처리
## NULL 값에 대한 연산과 집계함수
create table mybook(
bookid int,
price int);

insert into mybook values(1,10000);
insert into mybook values(2,20000);
insert into mybook values(3,null);

select * from mybook;

select price +100
from mybook
where bookid=3; 
-- 출력값 => null
-- null은 비교나 연산 불가능 => null+1=null, null*1=null, null == null (False) 

select sum(price), avg(price),count(*), count(price)
from mybook;
-- 출력값 => sum(price) : 30000 / avg(price) : 15000.000 / count(*) : 3 / count(price) : 2 
-- sum, avg는 null 값 무시

## NULL 값 확인 - IS NULL, IS NOT NULL
select *
from mybook
where price is null;  -> bookid:3, price:null
-- 위 코드와 아래 코드는 서로 다른 결과를 불러옴
select *
from mybook
where price='';  -> bookid:공백 , price:공백

select *
from mybook
where price is not null;

## IFNULL 함수
-- 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시
select name '이름', ifnull(phone,'연락처없음')'전화번호'
from Customer;

# 행번호 출력
-- 고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.
set @seq:=0; -- 변수 seq에 0을 넣어라
select (@seq:=@seq+1) '순번', custid, name, phone
from customer
where @seq<2;