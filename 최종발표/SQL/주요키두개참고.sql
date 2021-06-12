CREATE TABLE 결제
(
	식별문자             CHAR(7) NOT NULL ,
	예매_식별문자        CHAR(11) NULL ,
	결제방식_식별문자    CHAR(7) NULL 
);



CREATE UNIQUE INDEX XPK결제 ON 결제
(식별문자   ASC);



ALTER TABLE 결제
	ADD CONSTRAINT  XPK결제 PRIMARY KEY (식별문자);



CREATE TABLE 결제내역정보
(
	사용자_식별아이디    VARCHAR2(20) NOT NULL ,
	식별문자             CHAR(7) NOT NULL 
);



CREATE UNIQUE INDEX XPK결제내역정보 ON 결제내역정보
(사용자_식별아이디   ASC,식별문자   ASC);



ALTER TABLE 결제내역정보
	ADD CONSTRAINT  XPK결제내역정보 PRIMARY KEY (사용자_식별아이디,식별문자);



CREATE TABLE 결제방식
(
	식별문자             CHAR(7) NOT NULL 
);



CREATE UNIQUE INDEX XPK결제방식 ON 결제방식
(식별문자   ASC);



ALTER TABLE 결제방식
	ADD CONSTRAINT  XPK결제방식 PRIMARY KEY (식별문자);



CREATE TABLE 관객방식
(
	식별문자             CHAR(7) NOT NULL 
);



CREATE UNIQUE INDEX XPK관객방식 ON 관객방식
(식별문자   ASC);



ALTER TABLE 관객방식
	ADD CONSTRAINT  XPK관객방식 PRIMARY KEY (식별문자);



CREATE TABLE 관리자정보
(
	아이디               VARCHAR2(20) NOT NULL 
);



CREATE UNIQUE INDEX XPK관리자정보 ON 관리자정보
(아이디   ASC);



ALTER TABLE 관리자정보
	ADD CONSTRAINT  XPK관리자정보 PRIMARY KEY (아이디);



CREATE TABLE 무통장입금정보
(
	결제방식_식별문자    CHAR(7) NOT NULL 
);



CREATE UNIQUE INDEX XPK무통장입금정보 ON 무통장입금정보
(결제방식_식별문자   ASC);



ALTER TABLE 무통장입금정보
	ADD CONSTRAINT  XPK무통장입금정보 PRIMARY KEY (결제방식_식별문자);



CREATE TABLE 배우정보
(
	영화_식별문자        CHAR(7) NOT NULL 
);



CREATE UNIQUE INDEX XPK배우정보 ON 배우정보
(영화_식별문자   ASC);



ALTER TABLE 배우정보
	ADD CONSTRAINT  XPK배우정보 PRIMARY KEY (영화_식별문자);



CREATE TABLE 비회원정보
(
	임시아이디           VARCHAR2(20) NOT NULL 
);



CREATE UNIQUE INDEX XPK비회원정보 ON 비회원정보
(임시아이디   ASC);



ALTER TABLE 비회원정보
	ADD CONSTRAINT  XPK비회원정보 PRIMARY KEY (임시아이디);



CREATE TABLE 사용자
(
	식별아이디           VARCHAR2(20) NOT NULL 
);



CREATE UNIQUE INDEX XPK사용자 ON 사용자
(식별아이디   ASC);



ALTER TABLE 사용자
	ADD CONSTRAINT  XPK사용자 PRIMARY KEY (식별아이디);



CREATE TABLE 상영관
(
	영화관_식별문자      CHAR(8) NOT NULL ,
	상영방식_식별문자    CHAR(8) NULL ,
	식별문자             CHAR(9) NOT NULL 
);



CREATE UNIQUE INDEX XPK상영관 ON 상영관
(영화관_식별문자   ASC,식별문자   ASC);



ALTER TABLE 상영관
	ADD CONSTRAINT  XPK상영관 PRIMARY KEY (영화관_식별문자,식별문자);



CREATE TABLE 상영방식
(
	식별문자             CHAR(8) NOT NULL 
);



CREATE UNIQUE INDEX XPK상영방식 ON 상영방식
(식별문자   ASC);



ALTER TABLE 상영방식
	ADD CONSTRAINT  XPK상영방식 PRIMARY KEY (식별문자);



CREATE TABLE 상영일정
(
	영화_식별문자        CHAR(7) NULL ,
	상영관_식별문자      CHAR(9) NULL ,
	영화관_식별문자      CHAR(8) NULL ,
	식별문자             CHAR(10) NOT NULL 
);



CREATE UNIQUE INDEX XPK상영일정 ON 상영일정
(식별문자   ASC);



ALTER TABLE 상영일정
	ADD CONSTRAINT  XPK상영일정 PRIMARY KEY (식별문자);



CREATE TABLE 신용카드정보
(
	결제방식_식별문자    CHAR(7) NOT NULL 
);



CREATE UNIQUE INDEX XPK신용카드정보 ON 신용카드정보
(결제방식_식별문자   ASC);



ALTER TABLE 신용카드정보
	ADD CONSTRAINT  XPK신용카드정보 PRIMARY KEY (결제방식_식별문자);



CREATE TABLE 영화
(
	식별문자             CHAR(7) NOT NULL 
);



CREATE UNIQUE INDEX XPK영화 ON 영화
(식별문자   ASC);



ALTER TABLE 영화
	ADD CONSTRAINT  XPK영화 PRIMARY KEY (식별문자);



CREATE TABLE 영화관
(
	지역_식별문자        CHAR(7) NULL ,
	식별문자             CHAR(8) NOT NULL 
);



CREATE UNIQUE INDEX XPK영화관 ON 영화관
(식별문자   ASC);



ALTER TABLE 영화관
	ADD CONSTRAINT  XPK영화관 PRIMARY KEY (식별문자);



CREATE TABLE 영화인기정보
(
	영화_식별문자        CHAR(7) NOT NULL 
);



CREATE UNIQUE INDEX XPK영화인기정보 ON 영화인기정보
(영화_식별문자   ASC);



ALTER TABLE 영화인기정보
	ADD CONSTRAINT  XPK영화인기정보 PRIMARY KEY (영화_식별문자);



CREATE TABLE 영화일정정보
(
	영화_식별문자        CHAR(7) NOT NULL 
);



CREATE UNIQUE INDEX XPK영화일정정보 ON 영화일정정보
(영화_식별문자   ASC);



ALTER TABLE 영화일정정보
	ADD CONSTRAINT  XPK영화일정정보 PRIMARY KEY (영화_식별문자);



CREATE TABLE 예매
(
	식별문자             CHAR(11) NOT NULL 
);



CREATE UNIQUE INDEX XPK예매 ON 예매
(식별문자   ASC);



ALTER TABLE 예매
	ADD CONSTRAINT  XPK예매 PRIMARY KEY (식별문자);



CREATE TABLE 예매좌석정보
(
	영화관_식별문자      CHAR(8) NOT NULL ,
	상영관_식별문자      CHAR(9) NOT NULL ,
	좌석문자             CHAR(3) NOT NULL ,
	상영일정_식별문자    CHAR(10) NOT NULL ,
	관객방식_식별문자    CHAR(7) NULL ,
	예매_식별문자        CHAR(11) NOT NULL 
);



CREATE UNIQUE INDEX XPK예매좌석정보 ON 예매좌석정보
(예매_식별문자   ASC,영화관_식별문자   ASC,상영관_식별문자   ASC,좌석문자   ASC,상영일정_식별문자   ASC);



ALTER TABLE 예매좌석정보
	ADD CONSTRAINT  XPK예매좌석정보 PRIMARY KEY (예매_식별문자,영화관_식별문자,상영관_식별문자,좌석문자,상영일정_식별문자);



CREATE TABLE 인터넷결제정보
(
	결제방식_식별문자    CHAR(7) NOT NULL 
);



CREATE UNIQUE INDEX XPK인터넷결제정보 ON 인터넷결제정보
(결제방식_식별문자   ASC);



ALTER TABLE 인터넷결제정보
	ADD CONSTRAINT  XPK인터넷결제정보 PRIMARY KEY (결제방식_식별문자);



CREATE TABLE 좌석
(
	영화관_식별문자      CHAR(8) NOT NULL ,
	상영관_식별문자      CHAR(9) NOT NULL ,
	좌석문자             CHAR(3) NOT NULL ,
	상영일정_식별문자    CHAR(10) NOT NULL 
);



CREATE UNIQUE INDEX XPK좌석 ON 좌석
(좌석문자   ASC,영화관_식별문자   ASC,상영관_식별문자   ASC,상영일정_식별문자   ASC);



ALTER TABLE 좌석
	ADD CONSTRAINT  XPK좌석 PRIMARY KEY (좌석문자,영화관_식별문자,상영관_식별문자,상영일정_식별문자);



CREATE TABLE 지역
(
	식별문자             CHAR(7) NOT NULL 
);



CREATE UNIQUE INDEX XPK지역 ON 지역
(식별문자   ASC);



ALTER TABLE 지역
	ADD CONSTRAINT  XPK지역 PRIMARY KEY (식별문자);



CREATE TABLE 최애장르정보
(
	회원정보_아이디      VARCHAR2(20) NOT NULL 
);



CREATE UNIQUE INDEX XPK최애장르정보 ON 최애장르정보
(회원정보_아이디   ASC);



ALTER TABLE 최애장르정보
	ADD CONSTRAINT  XPK최애장르정보 PRIMARY KEY (회원정보_아이디);



CREATE TABLE 포인트
(
	회원정보_아이디      VARCHAR2(20) NULL ,
	결제_식별문자        CHAR(7) NULL ,
	식별문자             CHAR(9) NOT NULL 
);



CREATE UNIQUE INDEX XPK포인트 ON 포인트
(식별문자   ASC);



ALTER TABLE 포인트
	ADD CONSTRAINT  XPK포인트 PRIMARY KEY (식별문자);



CREATE TABLE 포인트내역정보
(
	회원정보_아이디      VARCHAR2(20) NOT NULL ,
	포인트_식별문자      CHAR(9) NOT NULL 
);



CREATE UNIQUE INDEX XPK포인트내역정보 ON 포인트내역정보
(포인트_식별문자   ASC,회원정보_아이디   ASC);



ALTER TABLE 포인트내역정보
	ADD CONSTRAINT  XPK포인트내역정보 PRIMARY KEY (포인트_식별문자,회원정보_아이디);



CREATE TABLE 회원정보
(
	아이디               VARCHAR2(20) NOT NULL 
);



CREATE UNIQUE INDEX XPK회원정보 ON 회원정보
(아이디   ASC);



ALTER TABLE 회원정보
	ADD CONSTRAINT  XPK회원정보 PRIMARY KEY (아이디);



ALTER TABLE 결제
	ADD (CONSTRAINT R_34 FOREIGN KEY (예매_식별문자) REFERENCES 예매 (식별문자) ON DELETE SET NULL);



ALTER TABLE 결제
	ADD (CONSTRAINT R_35 FOREIGN KEY (결제방식_식별문자) REFERENCES 결제방식 (식별문자) ON DELETE SET NULL);



ALTER TABLE 결제내역정보
	ADD (CONSTRAINT R_22 FOREIGN KEY (사용자_식별아이디) REFERENCES 사용자 (식별아이디));



ALTER TABLE 결제내역정보
	ADD (CONSTRAINT R_37 FOREIGN KEY (식별문자) REFERENCES 결제 (식별문자));



ALTER TABLE 관리자정보
	ADD (CONSTRAINT R_3 FOREIGN KEY (아이디) REFERENCES 사용자 (식별아이디));



ALTER TABLE 무통장입금정보
	ADD (CONSTRAINT R_29 FOREIGN KEY (결제방식_식별문자) REFERENCES 결제방식 (식별문자));



ALTER TABLE 배우정보
	ADD (CONSTRAINT R_6 FOREIGN KEY (영화_식별문자) REFERENCES 영화 (식별문자));



ALTER TABLE 비회원정보
	ADD (CONSTRAINT R_2 FOREIGN KEY (임시아이디) REFERENCES 사용자 (식별아이디));



ALTER TABLE 상영관
	ADD (CONSTRAINT R_12 FOREIGN KEY (영화관_식별문자) REFERENCES 영화관 (식별문자));



ALTER TABLE 상영관
	ADD (CONSTRAINT R_32 FOREIGN KEY (상영방식_식별문자) REFERENCES 상영방식 (식별문자) ON DELETE SET NULL);



ALTER TABLE 상영일정
	ADD (CONSTRAINT R_14 FOREIGN KEY (영화관_식별문자, 상영관_식별문자) REFERENCES 상영관 (영화관_식별문자, 식별문자) ON DELETE SET NULL);



ALTER TABLE 상영일정
	ADD (CONSTRAINT R_9 FOREIGN KEY (영화_식별문자) REFERENCES 영화 (식별문자) ON DELETE SET NULL);



ALTER TABLE 신용카드정보
	ADD (CONSTRAINT R_28 FOREIGN KEY (결제방식_식별문자) REFERENCES 결제방식 (식별문자));



ALTER TABLE 영화관
	ADD (CONSTRAINT R_10 FOREIGN KEY (지역_식별문자) REFERENCES 지역 (식별문자) ON DELETE SET NULL);



ALTER TABLE 영화인기정보
	ADD (CONSTRAINT R_7 FOREIGN KEY (영화_식별문자) REFERENCES 영화 (식별문자));



ALTER TABLE 영화일정정보
	ADD (CONSTRAINT R_8 FOREIGN KEY (영화_식별문자) REFERENCES 영화 (식별문자));



ALTER TABLE 예매좌석정보
	ADD (CONSTRAINT R_18 FOREIGN KEY (좌석문자, 영화관_식별문자, 상영관_식별문자, 상영일정_식별문자) REFERENCES 좌석 (좌석문자, 영화관_식별문자, 상영관_식별문자, 상영일정_식별문자));



ALTER TABLE 예매좌석정보
	ADD (CONSTRAINT R_19 FOREIGN KEY (관객방식_식별문자) REFERENCES 관객방식 (식별문자) ON DELETE SET NULL);



ALTER TABLE 예매좌석정보
	ADD (CONSTRAINT R_20 FOREIGN KEY (예매_식별문자) REFERENCES 예매 (식별문자));



ALTER TABLE 인터넷결제정보
	ADD (CONSTRAINT R_30 FOREIGN KEY (결제방식_식별문자) REFERENCES 결제방식 (식별문자));



ALTER TABLE 좌석
	ADD (CONSTRAINT R_15 FOREIGN KEY (영화관_식별문자, 상영관_식별문자) REFERENCES 상영관 (영화관_식별문자, 식별문자));



ALTER TABLE 좌석
	ADD (CONSTRAINT R_33 FOREIGN KEY (상영일정_식별문자) REFERENCES 상영일정 (식별문자));



ALTER TABLE 최애장르정보
	ADD (CONSTRAINT R_4 FOREIGN KEY (회원정보_아이디) REFERENCES 회원정보 (아이디));



ALTER TABLE 포인트
	ADD (CONSTRAINT R_5 FOREIGN KEY (회원정보_아이디) REFERENCES 회원정보 (아이디) ON DELETE SET NULL);



ALTER TABLE 포인트
	ADD (CONSTRAINT R_27 FOREIGN KEY (결제_식별문자) REFERENCES 결제 (식별문자) ON DELETE SET NULL);



ALTER TABLE 포인트내역정보
	ADD (CONSTRAINT R_21 FOREIGN KEY (회원정보_아이디) REFERENCES 회원정보 (아이디));



ALTER TABLE 포인트내역정보
	ADD (CONSTRAINT R_38 FOREIGN KEY (포인트_식별문자) REFERENCES 포인트 (식별문자));



ALTER TABLE 회원정보
	ADD (CONSTRAINT R_1 FOREIGN KEY (아이디) REFERENCES 사용자 (식별아이디));


