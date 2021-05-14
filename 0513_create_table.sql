-- 지역
/* 정문통학마을, 학식러버마을, 후문자취마을, 하늘연못마을, 쪽운동장마을 */
CREATE TABLE LOCAL (
    LOCALNO NUMBER,         -- 식별번호
    LOCALNAME VARCHAR2,     -- 이름
    PRIMARY KEY(LOCALNO)
);

-- 영화관
/*
    정문통학마을 : 전농관, 자작마루, 건설공학관(건공관)
    학식러버마을 : 학생회관(학관), 21세기관(21관), 자연과학관(자과관)
    후문자취마을 : 창공관, 중앙도서관(중도), 배봉관
    하늘연못마을 : 정보기술관(정기관), 인문학관, 음악관
    쪽운동장마을 : 과학기술관(과기관), 미래관, 100주년기념관(100기관)

*/
CREATE TABLE CINEMA (
    CINEMANO NUMBER,        -- 식별번호
    CINEMANAME VARCHAR2,    -- 이름
    PRIMARY KEY(CINEMANO),
    FOREIGN KEY(LOCALNO) REFERENCES LOCAL(LOCALNO)  -- 지역_식별번호
);

-- 상영방식
/* 2D 3D 4DX SOUNDX */
CREATE TABLE SCREENWAY(
    SCRWAYNO NUMBER,    -- 식별번호
    SCRWAY VARCHAR2,     -- 상영방식
    PRIMARY KEY(SCRWAYNO)
);

-- 영화
CREATE TABLE MOVIE(
    MVNO NUMBER,            -- 식별번호           
    MVNAME VARCHAR2,        -- 이름
    MVRELEASEDATE DATE,     -- 개봉일
    MVDIRECTOR VARCHAR2,    -- 감독
    MVCLASS VARCHAR2,       -- 시청등급
    MVRUNTIME NUMBER,       -- 상영시간
    MVGENRE VARCHAR2,       -- 장르
    MVSTORY VARCHAR2,       -- 줄거리
    MVPREVIEW VARCHAR2,     -- 예고편
    MVPOST VARCHAR2,        -- 포스터
    MVBOOKRANK NUMBER,      -- 예매순위 
    MVBOOKINGRATE NUMBER,   -- 예매율
    PRIMARY KEY(MVNO)
);

-- 배우정보
CREATE TABLE ACTOR (
    ACTORNAME VARCHAR2,    -- 이름
    FOREIGN KEY(MVNO) REFERENCES MOVIE(MVNO),  -- 영화_식별번호
    PRIMARY KEY(MVNO)
);

-- 상영관
CREATE TABLE THEATER (
    THEATERNO NUMBER,       -- 식별번호
    THEATERNAME VARCHAR2,   -- 이름
    SEATCNT NUMBER,         -- 좌석수
    ONSCREEN BOOLEAN,       -- 상영중
    PRIMARY KEY(THEATERNO),
    FOREIGN KEY(SCRWAYNO) REFERENCES SCREENWAY(SCRWAYNO),   -- 상영방식_식별번호
    FOREIGN KEY(CINEMANO) REFERENCES CINEMA(CINEMANO),      -- 영화관_식별번호
    FOREIGN KEY(MVNO) REFERENCES MOVIE(MVNO)                -- 영화_식별번호
);

-- 상영일정
CREATE TABLE SCHEDULE (
    SCHNO NUMBER,   -- 식별번호
    SCHDAY DATE,    -- 상영날짜
    SCHTIME DATE,   -- 상영시각
    PRIMARY KEY(SCHNO),
    FOREIGN KEY(THEATERNO) REFERENCES THEATER(THEATERNO)  -- 상영관_식별번호
);

-- 좌석
CREATE TABLE SEAT (
    SEATNO NUMBER,    -- 좌석번호
    PRIMARY KEY(SEATNO),
    FOREIGN KEY(SCHNO) REFERENCES SCHEDULE(SCHNO)   -- 상영관_식별번호
);

-- 관객종류
/* 일반 청소년 경로 우대 */
CREATE TABLE MOVIEGOERS (
    GOERSNO NUMBER,     -- 식별번호
    GOERSTYPE VARCHAR2, -- 관객종류
    PRIMARY KEY(GOERSNO)
);

-- 예매정보
CREATE TABLE BOOKING_INFO (
    BOOKINGNO NUMBER,   -- 식별번호
    GOERSCNT NUMBER,    -- 관객수
    BOOKINGDATE DATE,   -- 예매시각
    FOREIGN KEY(SEATNO) REFERENCES SEAT(SEATNO),        -- 좌석_좌석번호
    PRIMARY KEY(SEATNO),  
    FOREIGN KEY(GOERSNO) REFERENCES MOVIEGOERS(GOERSNO),-- 관객종류_식별번호
    PRIMARY KEY(GOERSNO)
);
-- 사용자
CREATE TABLE USER(
    USERID VARCHAR2,        -- 식별아이디
    MEMBERCHECK BOOLEAN,    -- 회원체크
    PRIMARY KEY(USERID)
);

-- 비회원
CREATE TABLE NONMEMBER(
    NONMEMNAME VARCHAR2,    -- 이름
    NONMEMPHONE NUMBER,     -- 전화번호
    NONMEMBIRTH DATE,       -- 주민등록번호
    VERIFICATION BOOLEAN,   -- 본인인증
    FOREIGN KEY(NONMEMID) REFERENCES USER(USERID),  -- 임시아이디
    PRIMARY KEY(NONMEMNO)
);

-- 회원
CREATE TABLE MEMBER(
    MEMPWD VARCHAR2,        -- 비밀번호 
    MEMNAME VARCHAR2,       -- 이름
    MEMEMAIL VARCHAR2,      -- 이메일
    MEMPHONE NUMBER,        -- 전화번호
    MEMBIRTH DATE,          -- 주민등록번호
    VERIFICATION BOOLEAN,   -- 본인인증
    POINT NUMBER,           -- 포인트 점수
    FOREIGN KEY(MEMID) REFERENCES USER(USERID), -- 아이디
    PRIMARY KEY(MEMID)
);

-- 선호장르정보
CREATE TABLE FAVORGENRE_INFO(
    FAVORGENRE VARCHAR2,    -- 선호장르
    FOREIGN KEY(MEMID) REFERENCES MEMBER(MEMID),    -- 회원_아이디
    PRIMARY KEY(MEMID)
);

-- 결제방법
/* 카드 무통장입금 인터넷결제 */
CREATE TABLE HOWTOPAY(
    PAYWAYNO NUMBER,    -- 식별번호
    PAYWAY VARCHAR2,    -- 결제방법
    PRIMARY KEY(PAYWAYNO)
);

-- 결제정보
CREATE TABLE PAY_INFO(
    PAYNO NUMBER,       -- 식별번호
    PRICE NUMBER,       -- 결제금액
    PAYDATE DATE,       -- 결제시각
    PRIMARY KEY(PAYNO), 
    FOREIGN KEY(TICKETNO) REFERENCES TICKET(TICKETNO),      -- 티켓_일련번호
    FOREIGN KEY(PAYWAYNO) REFERENCES HOWTOPAY(PAYWAYNO)     -- 결제방법_식별번호
);

-- 결제자정보
CREATE TABLE PAYER(
    DOCLASS BOOLEAN,    -- 시청가능
    FOREIGN KEY(MEMID) REFERENCES MEMBER(MEMID)             -- 사용자_식별아이디
    PRIMARY KEY(PAYNO),
    FOREIGN KEY(PAYWAYNO) REFERENCES HOWTOPAY(PAYWAYNO),    -- 결제방법_식별번호
    FOREIGN KEY(MVNO) REFERENCES MOVIE(MVNO)                -- 영화_식별번호
);

-- 포인트정보
CREATE TABLE POINT_INFO(
    POINTDATE DATE,     -- 활용시각
    POINTWAY VARCHAR2,  -- 활용방식
    SCORE NUMBER,       -- 활용점수
    FOREIGN KEY(PAYNO) REFERENCES PAY_INFO(PAYNO)           -- 결제정보_식별번호
    PRIMARY KEY(PAYNO),
    FOREIGN KEY(MEMID) REFERENCES MEMBER(MEMID),            -- 회원_아이디
    PRIMARY KEY(MEMID),
);    