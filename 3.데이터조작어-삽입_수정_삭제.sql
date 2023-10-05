# 데이터 조작어1(INSERT문)
-- Book 테이블에 새로운 도서 '스포츠 의학'을 삽입하고 한솔의학서적에서 출간하였으며 가격은 90,000원
insert into book values (11, '스포츠 의학', '한솔의학서적',90000);
-- 결과확인
select * from book;

-- Book 테이블에 새로운 도서 '스포츠 의학'을 삽입하고 한솔의학서적에서 출간하였으며 가격은 미정
insert into book (bookid, bookname, publisher) values ( 14, '스포츠 의학', '한솔의학서적');
-- 결과확인
select * from book;

-- 수입도서 목록(imported_book)을 Book 테이블에 모두 삽입(여러개를 추가하는 법)
insert into book(bookid, bookname, price, publisher)
	select bookid, bookname, price, publisher
	from imported_book;
-- 결과 확인
select * from book;

# 데이터 조작어2(UPDATE문)
-- Customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경
update customer
set address = '대한민국 부산'
where custid=5;
-- 결과 확인
select * from customer where custid=5;

-- Book 테이블에서 14번 '스포츠 의학'의 출판사를 Imported_book 테이블의 21번 책의 출판사와 동일하게 변경
update book
set publisher = (select publisher 
				 from imported_book 
				 where bookid='21' )
where bookid='14';

# 데이터 조작어3(DELETE문)
-- Book 테이블에서 도서번호가 11인 도서 삭제
delete from book where bookid='11';
-- 결과 확인
select * from book;
-- 모든 고객 삭제
delete from customer;