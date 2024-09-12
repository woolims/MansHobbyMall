-- 테이블 삭제
DROP TABLE IF EXISTS Compony;
DROP TABLE IF EXISTS Chat_logs;
DROP TABLE IF EXISTS Answer;
DROP TABLE IF EXISTS Inquiry;
DROP TABLE IF EXISTS Follow;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS SCart;
DROP TABLE IF EXISTS BuyList;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS DStatus;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS DCategory;
DROP TABLE IF EXISTS MCategory;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS CouponBox;
DROP TABLE IF EXISTS Coupon;
DROP TABLE IF EXISTS GCondition;
DROP TABLE IF EXISTS DAddress;
DROP TABLE IF EXISTS Email;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Grade;


-- Grade 테이블
CREATE TABLE Grade (
    gIdx int PRIMARY KEY AUTO_INCREMENT,
    gradeName varchar(200) NOT NULL,
    authority int NOT NULL,
    discount int NOT NULL
);

-- User 테이블
CREATE TABLE User (
    userIdx int PRIMARY KEY AUTO_INCREMENT,
    gIdx int NOT NULL DEFAULT 1,
    id varchar(50) NOT NULL UNIQUE,
    password varchar(50) NOT NULL,
    nickName varchar(50) NOT NULL UNIQUE,
    name varchar(50) NOT NULL,
    phone varchar(50) NOT NULL UNIQUE,
    addr varchar(70) NOT NULL,
    subAddr varchar(45),
    adminAt char(1) NOT NULL DEFAULT 'N',
    point bigint NOT NULL DEFAULT 0,
    createAt DATETIME NOT NULL default now(),
    FOREIGN KEY (gIdx) REFERENCES Grade (gIdx) ON DELETE CASCADE
);

-- Email 테이블
CREATE TABLE Email (
    emailIdx int PRIMARY KEY AUTO_INCREMENT,
    userIdx int NOT NULL,
    email varchar(50) NULL,
    esite varchar(20) NOT NULL,
    FOREIGN KEY (userIdx) REFERENCES User (userIdx) ON DELETE CASCADE
);

-- DAddress 테이블
CREATE TABLE DAddress (
    daIdx int PRIMARY KEY AUTO_INCREMENT,
    userIdx int NOT NULL,
    daPhone varchar(20) NOT NULL,
    daAddr LONGTEXT NOT NULL,
    FOREIGN KEY (userIdx) REFERENCES User (userIdx) ON DELETE CASCADE
);

-- GCondition 테이블
CREATE TABLE GCondition (
    jIdx int PRIMARY KEY AUTO_INCREMENT,
    userIdx int NOT NULL,
    bpAmount BIGINT NOT NULL DEFAULT 0,
    rCount int NOT NULL DEFAULT 0,
    sGradeAt char(1) NOT NULL DEFAULT 'N',
    FOREIGN KEY (userIdx) REFERENCES User (userIdx) ON DELETE CASCADE
);

-- Coupon 테이블
CREATE TABLE coupon (
    cIdx int PRIMARY KEY AUTO_INCREMENT,
    cName varchar(60) NOT NULL,
    discount int NOT NULL,
    dcType char(1) NOT NULL DEFAULT '-'
);

-- CouponBox 테이블
CREATE TABLE CouponBox (
    cbIdx int PRIMARY KEY AUTO_INCREMENT,
    userIdx int NOT NULL,
    cIdx int NOT NULL,
    useAt char(1) NOT NULL DEFAULT 'N',
    FOREIGN KEY (userIdx) REFERENCES User (userIdx) ON DELETE CASCADE,
    FOREIGN KEY (cIdx) REFERENCES Coupon (cIdx) ON DELETE CASCADE
);

-- Category 테이블
CREATE TABLE Category (
    categoryNo int PRIMARY KEY AUTO_INCREMENT,
    categoryName varchar(200) NOT NULL
);

-- MCategory 테이블
CREATE TABLE MCategory (
    mcategoryNo int PRIMARY KEY AUTO_INCREMENT,
    categoryNo int NOT NULL,
    mcategoryName varchar(200) NOT NULL,
    FOREIGN KEY (categoryNo) REFERENCES Category (categoryNo) ON DELETE CASCADE
);

-- DCategory 테이블
CREATE TABLE DCategory (
    dcategoryNo int PRIMARY KEY AUTO_INCREMENT,
    mcategoryNo int NOT NULL,
    dcategoryName varchar(200) NOT NULL,
    FOREIGN KEY (mcategoryNo) REFERENCES MCategory (mcategoryNo) ON DELETE CASCADE
);

-- Product 테이블
CREATE TABLE Product (
    pIdx int PRIMARY KEY AUTO_INCREMENT,
    categoryNo int NOT NULL,
    mcategoryNo int NOT NULL,
    dcategoryNo int NOT NULL,
    pName varchar(200) NOT NULL,
    pEx LONGTEXT NOT NULL,
    amount BIGINT NOT NULL DEFAULT 0,
    price BIGINT NOT NULL DEFAULT 0,
    FOREIGN KEY (categoryNo) REFERENCES Category (categoryNo) ON DELETE CASCADE,
    FOREIGN KEY (mcategoryNo) REFERENCES MCategory (mcategoryNo) ON DELETE CASCADE,
    FOREIGN KEY (dcategoryNo) REFERENCES DCategory (dcategoryNo) ON DELETE CASCADE
);

-- DStatus 테이블
CREATE TABLE DStatus (
    dsIdx int PRIMARY KEY AUTO_INCREMENT,
    dsType varchar(30) NOT NULL,
    dsContent LONGTEXT NOT NULL
);

-- Orders 테이블
CREATE TABLE Orders (
    oIdx int PRIMARY KEY AUTO_INCREMENT,
    dsIdx int NOT NULL,
    usepoint BIGINT NOT NULL DEFAULT 0,
    oDate DATETIME NOT NULL DEFAULT now(),
    oaddress LONGTEXT NOT NULL,
    FOREIGN KEY (dsIdx) REFERENCES DStatus (dsIdx) ON DELETE CASCADE
);

-- BuyList 테이블
CREATE TABLE BuyList (
    bIdx int PRIMARY KEY AUTO_INCREMENT,
    userIdx int NOT NULL,
    pIdx int NOT NULL,
    oIdx int NOT NULL,
    bamount int NOT NULL,
    buyDate DATETIME NOT NULL DEFAULT now(),
    FOREIGN KEY (userIdx) REFERENCES User (userIdx) ON DELETE CASCADE,
    FOREIGN KEY (pIdx) REFERENCES Product (pIdx) ON DELETE CASCADE,
    FOREIGN KEY (oIdx) REFERENCES Orders (oIdx) ON DELETE CASCADE
);

-- SCart 테이블
CREATE TABLE SCart (
    scIdx int PRIMARY KEY AUTO_INCREMENT,
    userIdx int NOT NULL,
    pIdx int NOT NULL,
    scamount int NOT NULL DEFAULT 1,
    FOREIGN KEY (userIdx) REFERENCES User (userIdx)  ON DELETE CASCADE,
    FOREIGN KEY (pIdx) REFERENCES Product (pIdx) ON DELETE CASCADE
);

-- Review 테이블
CREATE TABLE review (
    rvIdx int PRIMARY KEY AUTO_INCREMENT,
    pIdx int NOT NULL,
    userIdx int NOT NULL,
    rvContent LONGTEXT NOT NULL,
    reviewPoint int NOT NULL DEFAULT 5,
    rvImg LONGTEXT NULL,
    rvDate DATETIME NOT NULL DEFAULT now(),
    FOREIGN KEY (pIdx) REFERENCES Product (pIdx) ON DELETE CASCADE,
    FOREIGN KEY (userIdx) REFERENCES User (userIdx) ON DELETE CASCADE
);

-- Follow 테이블
CREATE TABLE Follow (
    fIdx int PRIMARY KEY AUTO_INCREMENT,
    rvIdx int NOT NULL,
    userIdx int NOT NULL,
    followDate DATETIME NOT NULL DEFAULT now(),
    FOREIGN KEY (rvIdx) REFERENCES Review (rvIdx) ON DELETE CASCADE,
    FOREIGN KEY (userIdx) REFERENCES User (userIdx) ON DELETE CASCADE
);

-- Inquiry 테이블
CREATE TABLE Inquiry (
    inIdx int PRIMARY KEY AUTO_INCREMENT,
    pIdx int NOT NULL,
    userIdx int NOT NULL,
    inType varchar(30) NOT NULL DEFAULT '기타',
    inContent LONGTEXT NOT NULL,
    inDate DATETIME NOT NULL DEFAULT now(),
    inPP LONGTEXT NULL,
    FOREIGN KEY (pIdx) REFERENCES Product (pIdx) ON DELETE CASCADE,
    FOREIGN KEY (userIdx) REFERENCES User (userIdx) ON DELETE CASCADE
);

-- Answer 테이블
CREATE TABLE Answer (
    aIdx int PRIMARY KEY AUTO_INCREMENT,
    inIdx int NOT NULL,
    userIdx int NOT NULL,
    aContent LONGTEXT NOT NULL,
    aDate DATETIME NOT NULL DEFAULT now(),
    FOREIGN KEY (inIdx) REFERENCES Inquiry (inIdx) ON DELETE CASCADE,
    FOREIGN KEY (userIdx) REFERENCES User (userIdx) ON DELETE CASCADE
);

-- Compony 테이블
CREATE TABLE Compony (
    comIdx int PRIMARY KEY AUTO_INCREMENT,
    comName varchar(200) NOT NULL,
    comAddr LONGTEXT NOT NULL,
    comPhone varchar(50) NOT NULL
);

-- Chat_logs 테이블
CREATE TABLE Chat_logs (
    chatIdx int PRIMARY KEY AUTO_INCREMENT,
    userId varchar(50) NULL,
    startTime DATETIME NOT NULL DEFAULT now(),
    inputMode char(1) NOT NULL DEFAULT 'T',
    messaginquiryType varchar(50) NOT NULL DEFAULT '기타',
    messageContent LONGTEXT NOT NULL,
    responseText LONGTEXT NOT NULL,
    endTime DATETIME NOT NULL
);

-- Grade 테이블에 샘플 데이터 삽입
INSERT INTO Grade(gradeName, authority, discount)
VALUES ('브론즈', 1, 0),
	('실버', 1, 3),
	('골드', 2, 3),
	('다이아', 2, 5),
	('마스터', 3, 5);

-- User 테이블에 샘플 데이터 삽입
INSERT INTO User(gIdx, id, password, nickName, name, phone, addr, subAddr, adminAt, point)
VALUES (5, 'admin', 'admin', '관리자', '관리자', '010-0000-0000', '서울시 관악구', '미공개', 'Y', 10000000),
	(1, 'user1', 'user1', '사용자1', '김원진', '010-1111-1111', '미공개', '미공개', 'N', default),
	(2, 'user2', 'user2', '사용자2', '배현진', '010-2222-2222', '미공개', '미공개', 'N', default),
	(3, 'user3', 'user3', '사용자3', '강민경', '010-3333-3333', '미공개', '미공개', 'N', default),
	(4, 'user4', 'user4', '사용자4', '손호영', '010-4444-4444', '미공개', '미공개', 'N', default),
	(5, 'user5', 'user5', '매니저(심우림)', '김원진', '010-5555-5555', '미공개', '미공개', 'N', 1000000);

-- 대 카테고리 데이터 추가
INSERT INTO category values(null,'게임');
INSERT INTO category values(null,'스포츠');

-- 중 카테고리 데이터 추가 게임
INSERT INTO mcategory values(null,1,'키보드');
INSERT INTO mcategory values(null,1,'마우스');
INSERT INTO mcategory values(null,1,'노트북');
INSERT INTO mcategory values(null,1,'기타');
-- 중 카테고리 데이터 추가 스포츠
INSERT INTO mcategory values(null,2,'축구');
INSERT INTO mcategory values(null,2,'야구');
INSERT INTO mcategory values(null,2,'농구');
INSERT INTO mcategory values(null,2,'기타');
select * from mcategory where categoryNo = 2;

-- 소 카테고리 데이터 추가  
-- 키보드
INSERT INTO dcategory values(null,1,'키보드패드');
INSERT INTO dcategory values(null,1,'기계식키보드');
INSERT INTO dcategory values(null,1,'멤브레인키보드');
INSERT INTO dcategory values(null,1,'게이밍키보드');

-- 마우스
INSERT INTO dcategory values(null,2,'손목받침대');
INSERT INTO dcategory values(null,2,'마우스패드');
INSERT INTO dcategory values(null,2,'손목보호마우스');
INSERT INTO dcategory values(null,2,'게이밍마우스');

-- 스포츠 축구
INSERT INTO dcategory values(null,5,'축구화');
INSERT INTO dcategory values(null,5,'축구공');
INSERT INTO dcategory values(null,5,'의상');
INSERT INTO dcategory values(null,5,'기타');

-- 스포츠 야구
INSERT INTO dcategory values(null,6,'야구배트');
INSERT INTO dcategory values(null,6,'야구공');
INSERT INTO dcategory values(null,6,'글러브');
INSERT INTO dcategory values(null,6,'기타');
select * from dcategory; 
-- 상품 데이터 추가 대 1=게임 2=스포츠 / 중 1=키보드 2=마우스 5=축구 6=야구 / 소 1~8까지 게임카테고리 9~16까지 스포츠카테고리
-- 소카테고리 하나당 상품 3개씩 키보드패드
insert into product values(null, 1, 1, 1, '각청 장패드', '각청이 그려진 장패드', 5, 50000);
insert into product values(null, 1, 1, 1, '일반 장패드', '꾸밈 없는 장패드', 6, 20000);
insert into product values(null, 1, 1, 1, '커스텀 장패드', '원하는 그림이 그려진 장패드', 7, 80000);

-- 소카테고리 하나당 상품 3개씩 기계식키보드
insert into product values(null, 1, 1, 2, '기계식키보드1', '흑축키보드', 3, 170000);
insert into product values(null, 1, 1, 2, '기계식키보드2', '갈축키보드', 1, 80000);
insert into product values(null, 1, 1, 2, '기계식키보드3', '적축키보드', 4, 110000);

-- 소카테고리 하나당 상품 3개씩 멤브레인키보드
insert into product values(null, 1, 1, 3, '멤브레인키보드1', '가격이 저렴한 멤브레인키보드1', 17, 20000);
insert into product values(null, 1, 1, 3, '멤브레인키보드2', '가격이 저렴한 멤브레인키보드2', 14, 10000);
insert into product values(null, 1, 1, 3, '멤브레인키보드3', '기계식인척하는 멤브레인키보드', 4, 40000);

-- 소카테고리 하나당 상품 3개씩 게이밍키보드
insert into product values(null, 1, 1, 4, '게이밍키보드1', '아무튼 반짝이는 화려한 키보드1', 7, 70000);
insert into product values(null, 1, 1, 4, '게이밍키보드2', '아무튼 반짝이는 화려한 키보드2', 4, 200000);
insert into product values(null, 1, 1, 4, '게이밍키보드3', '아무튼 반짝이는 화려한 키보드3', 3, 120000);

-- 소카테고리 하나당 상품 3개씩
insert into product values(null, 1, 2, 5, '실리콘 손목받침대', '실리콘 손목받침대', 3, 5000);
insert into product values(null, 1, 2, 5, '원목 손목받침대', '원목 손목받침대', 3, 20000);

-- 소카테고리 하나당 상품 3개씩
insert into product values(null, 1, 2, 6, '라이덴 마우스패드', '쇼군이 그려진 마우스패드', 5, 40000);
insert into product values(null, 1, 2, 6, '일반 마우스패드', '그냥 마우스패드', 5, 10000);
insert into product values(null, 1, 2, 6, '대형 마우스패드', 'fps게임에 유리한 대형 마우스패드', 5, 20000);

-- 소카테고리 하나당 상품 3개씩
insert into product values(null, 1, 2, 7, '손목보호 마우스1', '인체공학적으로 만들어진 손목보호마우스1', 5, 30000);
insert into product values(null, 1, 2, 7, '손목보호 마우스2', '인체공학적으로 만들어져 야근에 적합한 손목보호마우스2', 5, 40000);
insert into product values(null, 1, 2, 7, '손목보호 업무용 마우스3', '인체공학적으로 만들어져 사무용으로 적합한 손목보호마우스3', 5, 25000);

-- 소카테고리 하나당 상품 3개씩
insert into product values(null, 1, 2, 8, '게이밍마우스1', '반응이 빠른 게이밍 마우스', 5, 70000);
insert into product values(null, 1, 2, 8, '게이밍마우스2', '반응이 빠르고 내구성이 좋은 게이밍 마우스', 5, 170000);
insert into product values(null, 1, 2, 8, '게이밍마우스1', '내구성이 좋은 게이밍 마우스', 5, 100000);

-- 소카테고리 하나당 상품 3개씩
insert into product values(null, 2, 5, 9, '유명한 축구화', '대중적인 축구화', 30, 210000);
insert into product values(null, 2, 5, 9, '코난 운동화', '다이얼을 돌리고 차면 10배 강하게 나간다', 1, 21000000);
insert into product values(null, 2, 5, 9, '그냥 축구화', '그냥 축구화', 3, 100000);

-- 소카테고리 하나당 상품 3개씩 
insert into product values(null, 2, 5, 10, '그냥 축구공', '그냥 축구공', 3, 20000);
insert into product values(null, 2, 5, 10, '자블라니', '개같은 축구공', 3, 50000);
insert into product values(null, 2, 5, 10, '바람 넣는 펌프', '공에 바람을 넣는 펌프', 3, 20000);

-- 소카테고리 하나당 상품 3개씩 
insert into product values(null, 2, 5, 11, '토트넘 유니폼', '등번호 7번', 3, 200000);
insert into product values(null, 2, 5, 11, '체육복', '아무데나 입기 좋은 트레이닝복 세트', 3, 40000);
insert into product values(null, 2, 5, 11, '양말', '시멘트 바닥에 굴러도 끄떡없는 양말', 3, 10000);

-- 소카테고리 하나당 상품 3개씩 
insert into product values(null, 2, 5, 12, '기타상품', '나도몰라잉', 1, 1000);

-- 소카테고리 하나당 상품 3개씩 
insert into product values(null, 2, 6, 13, '알루미늄배트', '부산행 찍기 딱 좋은 빠따', 4, 51000);
insert into product values(null, 2, 6, 13, '나무배트', '홈런 치기 딱 좋은 빠따', 4, 101000);
insert into product values(null, 2, 6, 13, '티타늄배트', '손목 박살나기 딱 좋은 빠따', 4, 201000);

-- 소카테고리 하나당 상품 3개씩 
insert into product values(null, 2, 6, 14, '그냥 야구공', '언제나 쓰기 적당한 야구공', 4, 20000);
insert into product values(null, 2, 6, 14, '말랑한 야구공', '애들이 갖고 놀아도 안전한 야구공', 4, 30000);
insert into product values(null, 2, 6, 14, '장식용 가짜 싸인볼', '그냥 집에 장식하는 용도', 4, 10000);

-- 소카테고리 하나당 상품 3개씩 
insert into product values(null, 2, 6, 15, '그냥 글러브', '누구나 쓰기 좋은 글러브', 4, 31000);
insert into product values(null, 2, 6, 15, '튼튼한 글러브', '내구성이 좋은 글러브', 4, 101000);
insert into product values(null, 2, 6, 15, '아동용 글러브', '아이들이 쓰기 좋은 글러브', 4, 21000);

-- 소카테고리 하나당 상품 3개씩 
insert into product values(null, 2, 6, 16, '기타', '모자?', 4, 100);


CREATE OR REPLACE
VIEW `shop_list_view` AS
    SELECT 
        `p`.`pIdx` AS `pIdx`,
        `p`.`categoryNo` AS `categoryNo`,
        `p`.`mcategoryNo` AS `mcategoryNo`,
        `p`.`dcategoryNo` AS `dcategoryNo`,
        `p`.`pName` AS `pName`,
        `p`.`pEx` AS `pEx`,
        `p`.`price` AS `price`,
		`p`.`amount` As `amount`,
        `c`.`categoryName` AS `categoryName`,
        `m`.`mcategoryName` AS `mcategoryName`,
        `d`.`dcategoryName` AS `dcategoryName`
        
    FROM
        (((`product` `p`
        JOIN `category` `c` ON ((`p`.`categoryNo` = `c`.`categoryNo`)))
        JOIN `mcategory` `m` ON ((`p`.`mcategoryNo` = `m`.`mcategoryNo`)))
        JOIN `dcategory` `d` ON ((`p`.`dcategoryNo` = `d`.`dcategoryNo`)));

CREATE OR REPLACE VIEW LoginUserView AS
SELECT DISTINCT
    u.userIdx,
    u.gIdx,
    u.id,
    u.password,
    u.nickName,
    u.name,
    u.phone,
    u.addr,
    u.subAddr,
    u.adminAt,
    u.point,
    u.createAt,
    g.gradeName,
    g.authority,
    g.discount
FROM User u
INNER JOIN Grade g ON u.gIdx = g.gIdx;

CREATE OR REPLACE VIEW UserStatusView AS
SELECT DISTINCT
    u.userIdx,
    u.gIdx,
    u.id,
    u.password,
    u.nickName,
    u.name,
    u.phone,
    u.addr,
    u.subAddr,
    u.adminAt,
    u.point,
    u.createAt,
    e.emailIdx,
    e.email,
    e.esite,
    g.gradeName,
    g.authority,
    g.discount
FROM email e
INNER JOIN User u ON e.userIdx = u.userIdx
INNER JOIN Grade g ON u.gIdx = g.gIdx;

CREATE OR REPLACE VIEW InquiryView AS
SELECT
    i.inIdx,
    i.pIdx,
    i.userIdx,
    i.inType,
    i.inContent,
    i.inDate,
    i.inPP,
    u.name
FROM Inquiry i
INNER JOIN User u ON i.userIdx = u.userIdx;

CREATE OR REPLACE VIEW AnswerView AS
SELECT
    a.aIdx,
    a.inIdx,
    a.userIdx,
    a.aContent,
    a.aDate,
    u.name,
    u.adminAt
FROM Answer a
INNER JOIN User u ON a.userIdx = u.userIdx;
