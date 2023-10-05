## Study 내용
- 모든 실습은 **MySQL**로 진행
### 0. [Madang DB](https://github.com/dudns1234/SQL/blob/master/1.madangDB.sql)
- 테이블 생성
- 데이터 입력

### 1. [데이터 조작어 - 검색](https://github.com/dudns1234/SQL/blob/master/2.%EB%8D%B0%EC%9D%B4%ED%84%B0%EC%A1%B0%EC%9E%91%EC%96%B4-%EA%B2%80%EC%83%89.sql)
- SELECT 문
- 집계함수와 GROUP BY
- 두 개 이상 테이블에서 SQL 질의

### 2. [데이터 정의어](https://github.com/dudns1234/SQL/blob/master/3.%EB%8D%B0%EC%9D%B4%ED%84%B0%EC%A0%95%EC%9D%98%EC%96%B4.sql)
- CREATE 문
- ALTER 문
- DROP 문

### 3. [데이터 조작어 - 삽입, 수정, 삭제](https://github.com/dudns1234/SQL/blob/master/4.%EB%8D%B0%EC%9D%B4%ED%84%B0%EC%A1%B0%EC%9E%91%EC%96%B4-%EC%82%BD%EC%9E%85_%EC%88%98%EC%A0%95_%EC%82%AD%EC%A0%9C.sql)
- INSERT 문
- UPDATE 문
- DELETE 문

### 4. [내장함수](https://github.com/dudns1234/SQL/blob/master/5.%EB%82%B4%EC%9E%A5%ED%95%A8%EC%88%98.sql)
- 숫자함수
- 문자함수
- 날짜/시간함수
- NULL 값 처리
    - null 값에 대한 연산과 집계함수
    - null 값 확인 (IS NULL, IS NOT NULL)
    - IFNULL 함수
- 행번호 출력

### 5. [부속질의](https://github.com/dudns1234/SQL/blob/master/6.%EB%B6%80%EC%86%8D%EC%A7%88%EC%9D%98.sql)
- 스칼라 부속질의 : SELECT 부속질의
- 인라인 뷰 : FROM 부속질의
- 중첩질의 : WHERE 부속질의
    - 비교연산자
    - IN, NOT IN
    - ALL, SOME(ANY)
    - EXISTS, NOT EXISTS

### 6. [뷰와 인덱스](https://github.com/dudns1234/SQL/blob/master/7.%ED%85%8C%EC%9D%B4%EB%B8%94%EA%B3%BC%EB%B7%B0_%EC%9D%B8%EB%8D%B1%EC%8A%A4.sql)
- 뷰
    - 뷰의 생성
    - 뷰의 수정
    - 뷰의 삭제

- 인덱스
    - 인덱스 생성
    - 인덱스의 재구성과 삭제

### 7. [프로시저, 트리거, 사용자 정의 함수](https://github.com/dudns1234/SQL/blob/master/8.%ED%94%84%EB%A1%9C%EC%8B%9C%EC%A0%80_%ED%8A%B8%EB%A6%AC%EA%B1%B0_%EC%82%AC%EC%9A%A9%EC%9E%90%EC%A0%95%EC%9D%98%ED%95%A8%EC%88%98.sql)
- 프로시저
    - 삽입 작업을 하는 프로시저
    - 제어문을 사용하는 프로시저
    - 결과를 반환하는 프로시저
    - 커서를 사용하는 프로시저
- 트리거
- 사용자 정의 함수

### 8. [NoSQL](https://github.com/dudns1234/SQL/blob/master/9.NoSQL.md)
- NoSQL 데이터베이스의 출현 배경
- ACID와 BASE
- NoSQL 데이터베이스의 네 가지 유형
 
### 9. [MongoDB](https://github.com/dudns1234/SQL/blob/master/10.MongoDB.md)
- 특징, 문서, Dot Notation (.), 컬렉션
- mongoDB vs RDBMS
- 기본 명령어
    - insert
    - find
    - sort / limit / skip
    - update
    - remove
    - drop
    - function
    - aggregate


## Mini Project
### 영화 예매 시스템 구축
1. ER 다이어그램 구축 -> PASS
2. [테이블 구축](https://github.com/dudns1234/SQL/blob/master/%EC%98%81%ED%99%94%EC%98%88%EB%A7%A4%EC%8B%9C%EC%8A%A4%ED%85%9C%EA%B5%AC%EC%B6%95/2.%ED%85%8C%EC%9D%B4%EB%B8%94%EA%B5%AC%EC%B6%95.sql)
3. [데이터 입력](https://github.com/dudns1234/SQL/blob/master/%EC%98%81%ED%99%94%EC%98%88%EB%A7%A4%EC%8B%9C%EC%8A%A4%ED%85%9C%EA%B5%AC%EC%B6%95/3.%EB%8D%B0%EC%9D%B4%ED%84%B0%EC%9E%85%EB%A0%A5(Insert).sql)
4. 데이터 변경 및 삭제 -> PASS
5. [데이터 검색](https://github.com/dudns1234/SQL/blob/master/%EC%98%81%ED%99%94%EC%98%88%EB%A7%A4%EC%8B%9C%EC%8A%A4%ED%85%9C%EA%B5%AC%EC%B6%95/5.%EB%8D%B0%EC%9D%B4%ED%84%B0%EA%B2%80%EC%83%89(Query).sql)

