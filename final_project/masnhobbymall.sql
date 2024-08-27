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

-- Grade 테이블에 샘플 데이터 삽입
INSERT INTO Grade (gradeName, authority, discount)
VALUES (‘Bronze’, 1, 5), 
       (‘Silver’, 2, 10),
       (‘Gold’, 3, 15), 
       (‘Platinum’, 4, 20);
-- 등급 데이터 삭제
DELETE FROM Grade WHERE gradeName = 'Bronze';
DELETE FROM Grade;

-- User 테이블
CREATE TABLE User (
    userIdx int PRIMARY KEY AUTO_INCREMENT,
    gIdx int NOT NULL DEFAULT 1,
    id varchar(50) NOT NULL,
    password varchar(50) NOT NULL,
    nickName varchar(50) NOT NULL,
    name varchar(50) NOT NULL,
    phone varchar(50) NOT NULL,
    addr varchar(200) NOT NULL,
    adminAt char(1) NOT NULL DEFAULT 'N',
    point bigint NOT NULL DEFAULT 0,
    createAt DATETIME NOT NULL
);

-- User 테이블에 샘플 데이터 삽입
INSERT INTO User (gIdx, id, password, nickName, name, phone, addr, adminAt, point, createAt)
VALUES 
(1, ‘test’, ‘test’, ‘테스트‘, ‘테스트’, ‘010-1234-5678’, ‘Address 1’, ‘N’, 1, NOW()),
(4, ‘admin’, ‘admin’, ‘관리자‘, ‘관리자’, ‘010-1111-1111’, ‘서울시 관악구’, ‘Y’, 1000000, NOW());
-- 유저 데이터 삭제
DELETE FROM User WHERE gIdx = 1;
DELETE FROM User;

-- User 테이블과 Grade 테이블의 외래 키
ALTER TABLE User
ADD CONSTRAINT FK_Grade_TO_User FOREIGN KEY (gIdx) REFERENCES Grade (gIdx);

-- Email 테이블
CREATE TABLE Email (
    emailIdx int PRIMARY KEY AUTO_INCREMENT,
    userIdx int NOT NULL,
    email varchar(50) NULL,
    esite varchar(20) NOT NULL
);
-- Email 테이블과 User 테이블의 외래 키
ALTER TABLE Email
ADD CONSTRAINT FK_User_TO_Email FOREIGN KEY (userIdx) REFERENCES User (userIdx);

-- DAddress 테이블
CREATE TABLE DAddress (
    daIdx int PRIMARY KEY AUTO_INCREMENT,
    userIdx int NOT NULL,
    daPhone varchar(20) NOT NULL,
    daAddr LONGTEXT NOT NULL
);
-- DAddress 테이블과 User 테이블의 외래 키
ALTER TABLE DAddress
ADD CONSTRAINT FK_User_TO_DAddress FOREIGN KEY (userIdx) REFERENCES User (userIdx);

-- GCondition 테이블
CREATE TABLE GCondition (
    jIdx int PRIMARY KEY AUTO_INCREMENT,
    userIdx int NOT NULL,
    bpAmount BIGINT NOT NULL DEFAULT 0,
    rCount int NOT NULL DEFAULT 0,
    sGradeAt char(1) NOT NULL DEFAULT 'N'
);
-- GCondition 테이블과 User 테이블의 외래 키
ALTER TABLE GCondition
ADD CONSTRAINT FK_User_TO_GCondition_1 FOREIGN KEY (userIdx) REFERENCES User (userIdx);

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
    useAt char(1) NOT NULL DEFAULT 'N'
);
-- CouponBox 테이블과 User, Coupon 테이블의 외래 키
ALTER TABLE CouponBox
ADD CONSTRAINT FK_User_TO_CouponBox FOREIGN KEY (userIdx) REFERENCES User (userIdx);

ALTER TABLE CouponBox
ADD CONSTRAINT FK_coupon_TO_CouponBox FOREIGN KEY (cIdx) REFERENCES Coupon (cIdx);

-- Category 테이블
CREATE TABLE Category (
    categoryNo int PRIMARY KEY AUTO_INCREMENT,
    categoryName varchar(200) NOT NULL
);

-- MCategory 테이블
CREATE TABLE MCategory (
    mcategoryNo int PRIMARY KEY AUTO_INCREMENT,
    categoryNo int NOT NULL,
    mcategoryName varchar(200) NOT NULL
);
-- MCategory 테이블과 Category 테이블의 외래 키
ALTER TABLE MCategory
ADD CONSTRAINT FK_Category_TO_MCategory FOREIGN KEY (categoryNo) REFERENCES Category (categoryNo);

-- DCategory 테이블
CREATE TABLE DCategory (
    dcategoryNo int PRIMARY KEY AUTO_INCREMENT,
    mcategoryNo int NOT NULL,
    dcategoryName varchar(200) NOT NULL
);
-- DCategory 테이블과 Category 테이블의 외래 키
ALTER TABLE DCategory
ADD CONSTRAINT FK_MCategory_TO_DCategory FOREIGN KEY (mcategoryNo) REFERENCES MCategory (mcategoryNo);

-- Product 테이블
CREATE TABLE Product (
    pIdx int PRIMARY KEY AUTO_INCREMENT,
    categoryNo int NOT NULL,
    dcategoryNo int NOT NULL,
    pName varchar(200) NOT NULL,
    pEx LONGTEXT NOT NULL,
    amount BIGINT NOT NULL DEFAULT 0,
    price BIGINT NOT NULL DEFAULT 0
);
-- Product 테이블과 Category, DCategory 테이블의 외래 키
ALTER TABLE Product
ADD CONSTRAINT FK_Category_TO_Product FOREIGN KEY (categoryNo) REFERENCES Category (categoryNo);

ALTER TABLE Product
ADD CONSTRAINT FK_DCategory_TO_Product FOREIGN KEY (dcategoryNo) REFERENCES DCategory (dcategoryNo);

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
    oaddress LONGTEXT NOT NULL
);
-- Orders 테이블과 DStatus 테이블의 외래 키
ALTER TABLE Orders
ADD CONSTRAINT FK_DStatus_TO_Orders FOREIGN KEY (dsIdx) REFERENCES DStatus (dsIdx);

-- BuyList 테이블
CREATE TABLE BuyList (
    bIdx int PRIMARY KEY AUTO_INCREMENT,
    userIdx int NOT NULL,
    pIdx int NOT NULL,
    oIdx int NOT NULL,
    bamount int NOT NULL,
    buyDate DATETIME NOT NULL DEFAULT now()
);
-- BuyList 테이블과 User, Product, Orders 테이블의 외래 키
ALTER TABLE BuyList
ADD CONSTRAINT FK_User_TO_BuyList FOREIGN KEY (userIdx) REFERENCES User (userIdx);

ALTER TABLE BuyList
ADD CONSTRAINT FK_Product_TO_BuyList FOREIGN KEY (pIdx) REFERENCES Product (pIdx);

ALTER TABLE BuyList
ADD CONSTRAINT FK_Orders_TO_BuyList FOREIGN KEY (oIdx) REFERENCES Orders (oIdx);

-- SCart 테이블
CREATE TABLE SCart (
    scIdx int PRIMARY KEY AUTO_INCREMENT,
    userIdx int NOT NULL,
    pIdx int NOT NULL,
    scamount int NOT NULL DEFAULT 1
);
-- SCart 테이블과 User, Product 테이블의 외래 키
ALTER TABLE SCart
ADD CONSTRAINT FK_User_TO_SCart FOREIGN KEY (userIdx) REFERENCES User (userIdx);

ALTER TABLE SCart
ADD CONSTRAINT FK_Product_TO_SCart FOREIGN KEY (pIdx) REFERENCES Product (pIdx);

-- Review 테이블
CREATE TABLE review (
    rvIdx int PRIMARY KEY AUTO_INCREMENT,
    pIdx int NOT NULL,
    userIdx int NOT NULL,
    rvContent LONGTEXT NOT NULL,
    reviewPoint int NOT NULL DEFAULT 5
);
-- Review 테이블과 Product, User 테이블의 외래 키
ALTER TABLE Review
ADD CONSTRAINT FK_Product_TO_Review FOREIGN KEY (pIdx) REFERENCES Product (pIdx);

ALTER TABLE Review
ADD CONSTRAINT FK_User_TO_Review FOREIGN KEY (userIdx) REFERENCES User (userIdx);

-- Follow 테이블
CREATE TABLE Follow (
    fIdx int PRIMARY KEY AUTO_INCREMENT,
    rvIdx int NOT NULL,
    userIdx int NOT NULL,
    followDate DATETIME NOT NULL DEFAULT now()
);
-- Follow 테이블과 Review, User 테이블의 외래 키
ALTER TABLE Follow
ADD CONSTRAINT FK_Review_TO_Follow_1 FOREIGN KEY (rvIdx) REFERENCES Review (rvIdx);

ALTER TABLE Follow
ADD CONSTRAINT FK_User_TO_Follow_1 FOREIGN KEY (userIdx) REFERENCES User (userIdx);

-- Inquiry 테이블
CREATE TABLE Inquiry (
    inIdx int PRIMARY KEY AUTO_INCREMENT,
    pIdx int NOT NULL,
    userIdx int NOT NULL,
    inType varchar(30) NOT NULL DEFAULT '기타',
    inContent LONGTEXT NOT NULL,
    inDate DATETIME NOT NULL DEFAULT now(),
    inPP LONGTEXT NULL
);
-- Inquiry 테이블과 Product, User 테이블의 외래 키
ALTER TABLE Inquiry
ADD CONSTRAINT FK_Product_TO_Inquiry_1 FOREIGN KEY (pIdx) REFERENCES Product (pIdx);

ALTER TABLE Inquiry
ADD CONSTRAINT FK_User_TO_Inquiry_1 FOREIGN KEY (userIdx) REFERENCES User (userIdx);

-- Answer 테이블
CREATE TABLE Answer (
    aIdx int PRIMARY KEY AUTO_INCREMENT,
    inIdx int NOT NULL,
    userIdx int NOT NULL,
    aContent LONGTEXT NOT NULL,
    aDate DATETIME NOT NULL DEFAULT now()
);
-- Answer 테이블과 Inquiry 테이블의 외래 키
ALTER TABLE Answer
ADD CONSTRAINT FK_Inquiry_TO_Answer_1 FOREIGN KEY (inIdx) REFERENCES Inquiry (inIdx);

ALTER TABLE Answer
ADD CONSTRAINT FK_Inquiry_TO_Answer_3 FOREIGN KEY (userIdx) REFERENCES Inquiry (userIdx);

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