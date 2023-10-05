DROP DATABASE IF EXISTS  madang;

create database madang;

 
USE madang;

create table Book(
    bookid integer primary key,
    bookname varchar(40),
    publisher varchar(40),
    price integer
);

create table Customer(
    custid integer primary key,
    name varchar(40),
    address varchar(50),
    phone varchar(20)
);

create table Orders(
    orderid integer primary key,
    custid integer,
    bookid integer,
    saleprice integer,
    orderdate date,
    foreign key(custid) references Customer(custid),  -- custid를 외래키로 할건데 어디서 가져왔냐면 Customer에서 가져옴
    foreign key(bookid) references Book(bookid)
);

insert into book values(1,'축구의 역사','굿스포츠',7000);
insert into book values(2,'축구아는 여자','나무수',13000);
insert into book values(3,'축구의 이해','대한미디어',22000);
insert into book values(4,'골프 바이블','대한미디어',35000);
insert into book values(5,'피겨 교본','굿스포츠',8000);
insert into book values(6,'역도 단계별기술','굿스포츠',6000);
insert into book values(7,'야구의 추억','이상미디어',20000);
insert into book values(8,'야구를 부탁해','이상미디어',13000);
insert into book values(9,'올림픽 이야기','삼성당',7500);
insert into book values(10,'Olympic Champions','Pearson',13000);

insert into customer values(1,'박지성','영국 맨체스타','000-5000-0001');
insert into customer values(2,'김연아','대한민국 서울','000-6000-0001');
insert into customer values(3,'장미란','대한민국 강원도','000-7000-0001');
insert into customer values(4,'추신수','미국 클리블랜드','000-8000-0001');
insert into customer values(5,'박세리','대한민국 부산',null);

insert into orders values(1,1,1,6000,str_to_date('2014-07-01','%Y-%m-%d'));
insert into orders values(2,1,3,21000,str_to_date('2014-07-03','%Y-%m-%d'));
insert into orders values(3,2,5,8000,str_to_date('2014-07-03','%Y-%m-%d'));
insert into orders values(4,3,6,6000,str_to_date('2014-07-04','%Y-%m-%d'));
insert into orders values(5,4,7,20000,str_to_date('2014-07-05','%Y-%m-%d'));
insert into orders values(6,1,2,12000,str_to_date('2014-07-07','%Y-%m-%d'));
insert into orders values(7,4,8,13000,str_to_date('2014-07-07','%Y-%m-%d'));
insert into orders values(8,3,10,12000,str_to_date('2014-07-08','%Y-%m-%d'));
insert into orders values(9,2,10,7000,str_to_date('2014-07-09','%Y-%m-%d'));
insert into orders values(10,3,8,13000,str_to_date('2014-07-10','%Y-%m-%d'));

create table Imported_Book(
    bookid integer,
    bookname varchar(40),
    publisher varchar(40),
    price integer
);

insert into Imported_Book values(21,'Zen Golf','Pearson',12000);
insert into Imported_Book values(5,'Soccer Skills','Human Kinetics',15000);