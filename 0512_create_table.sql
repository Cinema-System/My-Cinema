-- 지역
CREATE TABLE LOCAL (
    LOCALNO NUMBER,         -- 식별번호
    LOCALNAME VARCHAR2,     -- 이름
    PRIMARY KEY(LOCALNO)
);

-- 영화관
CREATE TABLE CINEMA (
    CINEMANO NUMBER,        -- 식별번호
    CINEMANAME VARCHAR2,    -- 이름
    PRIMARY KEY(CINEMANO),
    FOREIGN KEY(LOCALNO) REFERENCES LOCAL(LOCALNO)  -- 지역_식별번호
);

-- 상영방식
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

-- 좌석
CREATE TABLE SEAT (
    SEATNO NUMBER,    -- 좌석번호
    PRIMARY KEY(SEATNO),
    FOREIGN KEY(THEATERNO) REFERENCES THEATER(THEATERNO)  -- 영화_식별번호
);

-- 관객종류
CREATE TABLE MOVIEGOERS (
    GOERSNO NUMBER,     -- 식별번호
    GOERSTYPE VARCHAR2, -- 관객종류
    PRIMARY KEY(GOERSNO)
);

-- 티켓
CREATE TABLE TICKET (
    TICKETNO NUMBER,    -- 일련번호
    PRIMARY KEY(TICKETNO)  
);

-- 예매정보
CREATE TABLE BOOKING_INFO (
    GOERSCNT NUMBER,    -- 관객수
    BOOKINGDATE DATE,   -- 예매시각
    FOREIGN KEY(SEATNO) REFERENCES SEAT(SEATNO),        -- 좌석_식별번호
    PRIMARY KEY(SEATNO),  
    FOREIGN KEY(GOERSNO) REFERENCES MOVIEGOERS(GOERSNO),-- 관객종류_식별번호
    FOREIGN KEY(TICKETNO) REFERENCES TICKET(TICKETNO)   -- 티켓_일련번호
);

-- 비회원
CREATE TABLE NONMEMBER(
    NONMEMNO NUMBER,        -- 식별번호
    NONMEMNAME VARCHAR2,    -- 이름
    NONMEMPHONE NUMBER,     -- 전화번호
    NONMEMBIRTH DATE,       -- 주민등록번호
    VERIFICATION BOOLEAN,   -- 본인인증
    DOPOINT BOOLEAN,        -- 포인트체크 (무)
    PRIMARY KEY(NONMEMNO)
);

-- 회원
CREATE TABLE MEMBER(
    MEMID VARCHAR2,         -- 아이디
    MEMPWD VARCHAR2,        -- 비밀번호 
    MEMNAME VARCHAR2,       -- 이름
    MEMEMAIL VARCHAR2,      -- 이메일
    MEMPHONE NUMBER,        -- 전화번호
    MEMBIRTH DATE,          -- 주민등록번호
    VERIFICATION BOOLEAN,   -- 본인인증
    DOPOINT BOOLEAN,        -- 포인트체크 (유)
    POINT NUMBER,           -- 포인트
    PRIMARY KEY(MEMID)
);

-- 선호장르정보
CREATE TABLE FAVORGENRE_INFO(
    FAVORGENRE VARCHAR2,    -- 선호장르
    FOREIGN KEY(MEMID) REFERENCES MEMBER(MEMID),    -- 회원_아이디
    PRIMARY KEY(MEMID)
);

-- 결제방법
CREATE TABLE HOWTOPAY(
    PAYWAYNO NUMBER,    -- 식별번호
    PAYWAY VARCHAR2,    -- 결제방법
    PRIMARY KEY(PAYWAYNO)
);

-- 결제정보
CREATE TABLE PAY_INFO(
    PAYNO NUMBER,       -- 식별번호
    PRICE NUMBER,       -- 결제금액
    POINTWAY BOOLEAN,   -- 결제시각
    POINTDATE DATE,     -- 활용방식
    SCORE NUMBER,       -- 활용시각
    PRIMARY KEY(PAYNO), -- 포인트점수
    FOREIGN KEY(TICKETNO) REFERENCES TICKET(TICKETNO),      -- 티켓_일련번호
    FOREIGN KEY(PAYWAYNO) REFERENCES HOWTOPAY(PAYWAYNO),    -- 결제방법_식별번호
    FOREIGN KEY(MEMID) REFERENCES MEMBER(MEMID)             -- 회원_아이디
);

-- 결제자정보
CREATE TABLE PAYER(
    DOCLASS BOOLEAN,    -- 시청가능
    DOPOINT BOOLEAN,    -- 포인트체크
    FOREIGN KEY(PAYNO) REFERENCES PAY(PAYNO),   -- 결제정보_식별번호
    PRIMARY KEY(PAYNO),
    FOREIGN KEY(MVNO) REFERENCES MOVIE(MVNO),   -- 영화_식별번호
    PRIMARY KEY(MVNO),
    FOREIGN KEY(NONMEMNO) REFERENCES NONMEMBER(NONMEMNO),   -- 비회원_식별번호
    FOREIGN KEY(MEMID) REFERENCES MEMBER(MEMID)             -- 회원_아이디
);

/*
    # 추가 고려사항

    1. 좌석수 업데이트 / 결제 후에.. 줄어들드록...

    2. 선호도에 따른 영화 홍보 테이블

    3. 결제자정보 - 기본키 재수정

    4. 회원 - 포인트 점수
*/