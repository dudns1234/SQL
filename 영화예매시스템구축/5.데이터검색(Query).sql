-- 강호동 구매 내역
select  ticketidx, username, title, showDate, screenno,timeno,buydate, if ( task = 1,'예약','취소') as task
from ticket t, showing s,movie m,usertbl u where t.showingidx = s.showingidx
and s.movieid = m.movieid
and u.userid=t.userid
and t.userid = "KHD";

-- 유저별 월별 구매내역
select userid, month(buydate) as mon, count(*) from ticket
group by userid, mon;

-- 모든 사용자에 대한 티켓 구매 건수
select  userName, count(t.showingIdx)  from  usertbl u
left outer join ticket t
	on u.userid = t.userid 
group by userName;

-- 모든 지역별 티켓 구매 건수
select  addr, count(t.showingIdx)  from  usertbl u
left outer join ticket t
	on u.userid = t.userid 
group by addr;

-- 열령별 구매 건수
select  floor((year(now()) - birthyear)/10)*10  as age, count(t.showingIdx)  from  usertbl u
left outer join ticket t
	on u.userid = t.userid 
group by age;

-- 열령별 구매 건수(모든 연령)
select g.gen, ifnull(cnt,0) from generation g 
left outer join countByAgeView v
on v.gen=g.gen;

-- 열령별 구매 건수(모든 열령)
drop view countByAgeView;
create view countByAgeView  as
select  floor((year(now()) - birthyear)/10)*10  as gen, count(t.showingIdx) as cnt  from  usertbl u,
ticket t 
where u.userid = t.userid 
group by gen;

select g.gen, ifnull(cnt, 0)  from generation g
left outer join countByAgeView  v 
on v.gen = g.gen;

------- 위, 아래 같은점, 다른점 확인 필요

-- 강호동  구매 내역
select  ticketIdx,  username, title,  showDate, screenNo, timeNo, buyDate, 
  if ( task = 1, '예약', '취소' ) as task
from ticket t, showing s, movie m, usertbl u
where  t.showingIdx = s.showingIdx and s.movieId = m.movieId and u.userId = t.userId and 
  t.userid  = "KHD"
order by ticketIdx desc;

-- CGV-강남대 상영중인 영화
SELECT showingIdx, businessId, screenNo, timeNo, title, timeInfo
FROM showing s, movie m
where s.movieId = m.movieId and businessId = "CGV-강남대";

-- CGV-강남대 상영중인 예약 상황
select t.showingIdx, screenNo, timeNo, seatNo, title, timeInfo, grade, maxSeat
from ticket t, showing s, movie m
where  t.showingIdx = s.showingIdx and s.movieId = m.movieId and  businessId = "CGV-강남대"
order by screenNo, timeNo;

-- 예약률
drop view reservationview;
create view reservationview as 
select businessId, screenNo, timeNo, title, timeInfo, maxSeat, count(*) cnt ,  count(*) / maxSeat rate
from ticket t, showing s, movie m
where  t.showingIdx = s.showingIdx and s.movieId = m.movieId
group by  businessId, screenNo, timeNo, title, timeInfo, maxSeat;

-- 시간별 예약률
select  *  from reservationview;

-- 관별 예약률
select businessId, screenNo, title, sum(maxSeat), sum(cnt), sum(cnt) / sum(maxSeat) from reservationview
group by businessId, screenNo, title;