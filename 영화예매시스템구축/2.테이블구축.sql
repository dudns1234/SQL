CREATE TABLE franchise (
  idx int(11) NOT NULL AUTO_INCREMENT,
  franchiseId varchar(10) DEFAULT NULL,
  businessId varchar(10) DEFAULT NULL,
  address varchar(45) DEFAULT NULL,
  PRIMARY KEY (idx),
  UNIQUE KEY businessId_UNIQUE (businessId)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE movie (
  movieId varchar(10) NOT NULL,
  title varchar(45) NOT NULL,
  grade int(11) NOT NULL,
  genre varchar(45) DEFAULT NULL,
  actors varchar(45) DEFAULT NULL,
  director varchar(45) DEFAULT NULL,
  PRIMARY KEY (movieId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE showing (
  showingIdx int(11) NOT NULL AUTO_INCREMENT,
  franchiseId varchar(45) NOT NULL,
  businessId varchar(45) NOT NULL,
  screenNo int(11) NOT NULL,
  timeNo int(11) NOT NULL,
  timeInfo varchar(45) DEFAULT NULL,
  movieId varchar(45) NOT NULL,
  maxSeat int(11) NOT NULL DEFAULT '10',
  PRIMARY KEY (showingIdx)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

CREATE TABLE usertbl (
  userID char(8) NOT NULL,
  userName varchar(10) NOT NULL,
  birthYear int(11) NOT NULL,
  addr char(2) NOT NULL,
  mobile1 char(3) DEFAULT NULL,
  mobile2 char(8) DEFAULT NULL,
  height smallint(6) DEFAULT NULL,
  mDate date DEFAULT NULL,
  grade varchar(5) DEFAULT NULL,
  PRIMARY KEY (userID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ticket (
  ticketIdx int(11) NOT NULL AUTO_INCREMENT,
  showingIdx int(11) NOT NULL,
  seatNo int(11) NOT NULL,
  userid varchar(45) NOT NULL,
  buyDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  showDate date NOT NULL,
  task int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (ticketIdx)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

CREATE TABLE generation (
  gen int(11) NOT NULL,
  PRIMARY KEY (gen)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



