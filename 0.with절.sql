# with 절
SQL에서 쿼리를 작성할 때 하나의 서브쿼리 또는 임시 테이블처럼 활용할 수 있는 기능

-- 사용 구문
WITH {테이블 명} AS (
                      SQL 쿼리문
                    )

SELECT * FROM {WITH절로 저장한 테이블명}


# Common Tabel Expression (CTE)
WITH 구문은 메모리 상에 가상의 테이블을 저장할 때 사용됨.
RECURSIVE의 여부에 따라 재귀, 비재귀 두 가지 방법으로 사용 가능함.

WITH [RECURSIVE] TABLE명 AS (
    SELECT - # 비반복문. 무조건 필수
    [UNION ALL] # RECURSIVE 사용 시 필수. 다음에 이어붙어야 할 때 사용
    SELECT - 
    [WHERE -] # RECURSIVE 사용 시 필수. 정지 조건 필요할 때 사용
)

## WITH 구문
WITH 구문 이후에 오는 쿼리에서 임시 테이블의 테이블명을 사용하여 값을 참조

WITH CTE AS (
    SELECT 0 AS NUM
    UNION ALL
    SELECT 0 FROM SOME_TABLE -- SOME_TABLE의 행 수만큼 반복
)

## WITH RECURSIVE 구문 (재귀 쿼리)
WITH RECURSIVE 구문의 가상 테이블을 생성하면서 가상 테이블 자신의 값을 참조하여 값을 결정할 때 사용

-- 0~10의 값을 갖는 임시 테이블 생성
WITH RECURSIVE CTE AS(
    SELECT 0 AS NUM -- 초기값 설정
    UNION ALL
    SELECT NUM+1 FROM CREATE
    WHERE NUM < 10 -- 반복을 멈추는 조건
)

SELECT * FROM CTE

--결과값
0
1
2
3
4
5
6
7
8
9

