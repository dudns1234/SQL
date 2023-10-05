## 데이터정의어1(CREATE문)
-- newbook 테이블 정의
-- # 기본키 지정 방법1. newbook 테이블에 기본키(bookid) 지정 
drop table newbook;
create table newbook(
bookid integer,
bookname varchar(20),
publisher varchar(20),
price integer,
primary key (bookid));

-- # 기본키 지정 방법2. newbook 테이블에 기본키(bookid) 지정 
drop table newbook;
create table newbook(
bookid integer primary key,
bookname varchar(20),
publisher varchar(20),
price integer);

-- # 복잡한 제약사항 설정
-- bookname은 NULL값 허용X, publisher는 같은 값X 
-- price에 값이 입력되지 않으면 기본값 10000 저장하며 최소 1000원 이상으로 함.
create table newbook(
bookid integer primary key not null,
bookname varchar(20) unique,
publisher varchar(20),
price integer default 10000 check (price>=1000));

-- # newcustomer 테이블 정의
-- 제약사항 : custid(기본키)
create table newcustomer(
custid integer primary key,
name varchar(40),
address varchar(40),
phone varchar(40));

-- # neworders 테이블 정의
-- 제약사항 : orderid(기본키), custid(외래키-newcustomer의 custid 참조)
create table neworders(
orderid integer,
custid integer not null,
bookid integer not null,
saleprice integer,
orderdate date,
primary key(orderid),
foreign key(custid) references newcustomer(custid) on delete cascade); -- on delete cascade는 foreign key에 대해서 삭제가 일어나게 되면 원래 있던 newcustomer에서도 삭제반영해라

# 데이터정의어2(ALTER문)
-- NewBook 테이블에 VARCHAR(13)의 자료형을 가진 isbn 속성을 추가
alter table newbook add isbn varchar(13);
-- NewBook 테이블의 isbn 속성의 데이터 타입을 INTEGER 형으로 변경
alter table newbook modify isbn integer;
-- NewBook 테이블의 isbn 속성을 삭제
alter table newbook drop column isbn;
-- NewBook 테이블의 bookid 속성에 NOT NULL 제약조건 적용
alter table newbook modify bookid integer not null;
-- NewBook 테이블의 bookid 속성을 기본키로 변경
alter table newbook add primary key(bookid);

# 데이터정의어3(DROP문)
-- NewBook 테이블 삭제
drop table newbook;

-- if NewCustomer 테이블을 먼저 삭제한다면? 외래키가 연결되어 있기때문에 에러남 그러니깐 neworders먼저 지워줘야함
drop table newcustomer;  (X)

drop table neworders; (O)
drop table newcustomer;