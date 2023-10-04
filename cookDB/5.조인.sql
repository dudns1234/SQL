-- 내부조인
-- 형식
SELECT <열 목록>
FROM <첫 번째 테이블>
INNER JOIN <두 번째 테이블>
ON <조인될 조건>
[WHERE 검색조건];

-- KYM이라는 아이디를 가진 회원이 구매한 물건을 발송하려면?
SELECT *
FROM buyTBL
INNER JOIN userTBL
ON buyTBL.userID = userTBL.userID
WHERE buyTBL.userID = 'KYM';

-- 아이디, 이름, 구매 물품, 주소, 연락처만 추출
SELECT B.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM buyTBL B
INNER JOIN userTBL U
ON B.userID = U.userID;

-- 3개 테이블 내부 조인
SELECT S.stdName, S.addr, C.clubName, C.roomNo
    FROM stdTBL S 
        INNER JOIN stdclubTBL SC
            ON S.stdName = SC.stdName
        INNER JOIN clubTBL C
            ON SC.clubName = C.clubName
    ORDER BY S.stdName;

-- 외부 조인
-- 형식
SELECT <열 목록> 
FROM <첫 번째 테이블(LEFT 테이블)> 
    <LEFT | RIGHT> OUTER JOIN <두 번째 테이블(RIGHT 테이블)> 
        ON <조인될 조건> 
[WHERE 검색조건];

-- 물건을 한 번도 구매한 적이 없는 회원의 목록 출력
SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
    FROM userTBL U 
        LEFT OUTER JOIN buyTBL B 
            ON U.userID = B.userID
    WHERE B.prodName IS NULL 
    ORDER BY U.userID;

-- 동아리에 가입하지 않은 학생도 출력하고 학생이 한 명도 없는 동아리도 출력
SELECT S.stdName, S.addr, C.clubName, C.roomNo
FROM stdTBL S 
LEFT OUTER JOIN stdclubTBL SC 
ON S.stdName = SC.stdName
LEFT OUTER JOIN clubTBL C 
ON SC.clubName = C.clubName
UNION 
SELECT S.stdName, S.addr, C.clubName, C.roomNo
FROM stdTBL S 
LEFT OUTER JOIN stdclubTBL SC 
ON SC.stdName = S.stdName
RIGHT OUTER JOIN clubTBL C 
ON SC.clubName = C.clubName;

-- 상호조인
pass

-- 자체조인
pass


-- 거래내역이 없는 사용자 이름
###right outer
select username, prodname 
from buytbl b
right outer join usertbl u
on u.userid=b.userid
where prodname is null;

###left outer
select username, prodname
from usertbl u
left outer join buytbl b
on u.userid=b.userid
where prodname is null;

##inner
select username, sum(price*amount)
from usertbl u
inner join buytbl b
on u.userid=b.userid
where prodname is null;
