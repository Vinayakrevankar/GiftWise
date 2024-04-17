DROP TABLE LoginAttempts;
DROP TABLE Transaction;
DROP TABLE PaymentMethod;
DROP TABLE UserPreference;
DROP TABLE Notification;
DROP TABLE UserFeedback;
DROP TABLE UserFavourites;
DROP TABLE GiftCard;
DROP TABLE PromoCode;
DROP TABLE ProductOrders;
DROP TABLE UserRewardsHistory;
DROP TABLE UserRewards;
DROP TABLE Product;
DROP TABLE Orders;
DROP TABLE Category;
DROP TABLE Brand;
DROP TABLE CustomerPhoneDetails;
DROP TABLE Customer;
DROP TABLE Users;
DROP TABLE Roles;


CREATE TABLE Roles (
idRole INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
isSuperAdmin NUMBER(1) NOT NULL,
isCustomer NUMBER(1) NOT NULL
);

INSERT INTO Roles (isSuperAdmin,isCustomer) VALUES (0,1);
INSERT INTO Roles (isSuperAdmin,isCustomer) VALUES (1,0);

CREATE TABLE Users (
idUser INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idRole INTEGER NOT NULL,
emailId VARCHAR(50),
password VARCHAR(80),
isActive NUMBER(1) NOT NULL,
lastLogin TIMESTAMP NOT NULL,
FOREIGN KEY(idRole) REFERENCES Roles(idRole));

CREATE TABLE Customer (
idCustomer INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idUser INTEGER,
firstName VARCHAR(50) NOT NULL,
lastName VARCHAR(50) NOT NULL,
zipcode INTEGER NOT NULL,
address VARCHAR(255),
DOB DATE,
FOREIGN KEY(idUser) REFERENCES Users(idUser));

CREATE TABLE CustomerPhoneDetails (
idCustomer INTEGER NOT NULL,
phoneNumber INTEGER NOT NULL,
phoneType VARCHAR(20) NOT NULL,
PRIMARY KEY (idCustomer, phoneNumber),
FOREIGN KEY(idCustomer) REFERENCES Customer(idCustomer) ON DELETE CASCADE);

CREATE TABLE LoginAttempts (
idUser INTEGER,
loginAttempts INTEGER NOT NULL,
loginDatetime TIMESTAMP NOT NULL,
PRIMARY KEY (idUser,loginAttempts),
FOREIGN KEY(idUser) REFERENCES Users(idUser) ON DELETE CASCADE);

CREATE TABLE PaymentMethod(
idPaymentMethod INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
paymentMethod VARCHAR(20)
);

CREATE TABLE Transaction (
idTransaction INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
orderId INTEGER NOT NULL,
idUser INTEGER NOT NULL,
idPaymentMethod INTEGER NOT NULL,
status VARCHAR(20),
amount REAL NOT NULL,
transactionDatetime TIMESTAMP,
FOREIGN KEY(idPaymentMethod) REFERENCES PaymentMethod(idPaymentMethod),
FOREIGN KEY(idUser) REFERENCES Users(idUser),
FOREIGN KEY(orderId) REFERENCES Orders(orderId));

CREATE TABLE UserPreference (
idPreference INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idUser INTEGER NOT NULL,
email NUMBER(1) NOT NULL,
sms NUMBER(1) NOT NULL,
FOREIGN KEY(idUser) REFERENCES Users(idUser) ON DELETE CASCADE);

CREATE TABLE Notification (
idNotification INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idUser INTEGER,
isSMSSent NUMBER(1),
isEmailSent NUMBER(1),
message VARCHAR(80),
notificationDatetime TIMESTAMP,
FOREIGN KEY(idUser) REFERENCES Users(idUser));

CREATE TABLE UserFeedback (
idFeedback INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idUser INTEGER NOT NULL,
message VARCHAR(255),
rating INTEGER,
FOREIGN KEY(idUser) REFERENCES Users(idUser));

CREATE TABLE Brand (
idBrand INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
brandName VARCHAR(40)
);

CREATE TABLE Category (
idCategory INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
categoryName VARCHAR(40)
);

CREATE TABLE Product (
idProduct INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idBrand INTEGER NOT NULL,
idCategory INTEGER NOT NULL,
productName VARCHAR(225) NOT NULL,
description VARCHAR(2000),
termsAndConditions VARCHAR(2000),
stepsToRedeem VARCHAR(2000),
imageURL VARCHAR(255),
quantity INTEGER NOT NULL,
amount INTEGER NOT NULL,
FOREIGN KEY(idBrand) REFERENCES Brand(idBrand),
FOREIGN KEY(idCategory) REFERENCES Category(idCategory));

CREATE TABLE UserFavourites (
idUser INTEGER NOT NULL,
idProduct INTEGER NOT NULL,
PRIMARY KEY(idUser, idProduct),
FOREIGN KEY(idProduct) REFERENCES Product(idProduct),
FOREIGN KEY(idUser) REFERENCES Users(idUser));

CREATE TABLE GiftCard (
idGiftcard INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idProduct INTEGER NOT NULL,
giftCardNumber VARCHAR(19) NOT NULL,
giftCardPin INTEGER NOT NULL,
status VARCHAR(16) NOT NULL,
FOREIGN KEY(idProduct) REFERENCES Product(idProduct));

CREATE TABLE PromoCode (
idPromocode INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idProduct INTEGER,
name VARCHAR(20),
discountInPercentage INTEGER NOT NULL,
isActive NUMBER(1),
FOREIGN KEY(idProduct) REFERENCES Product(idProduct));

CREATE TABLE Orders (
orderId INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idUser INTEGER NOT NULL,
status VARCHAR(20),
discount REAL NOT NULL,
totalAmount REAL NOT NULL,
startDate TIMESTAMP NOT NULL,
endDate TIMESTAMP NOT NULL,
orderDatetime TIMESTAMP NOT NULL,
FOREIGN KEY(idUser) REFERENCES Users(idUser) ON DELETE CASCADE);

CREATE TABLE ProductOrders (
orderId INTEGER NOT NULL,
idGiftcard INTEGER NOT NULL,
PRIMARY KEY (orderId, idGiftcard),
FOREIGN KEY(idGiftcard) REFERENCES GiftCard(idGiftcard),
FOREIGN KEY(orderId) REFERENCES Orders(orderId));

CREATE TABLE UserRewards (
idReward INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idUser INTEGER NOT NULL,
points REAL,
FOREIGN KEY(idUser) REFERENCES Users(idUser));

CREATE TABLE UserRewardsHistory (
idHistory INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idReward INTEGER NOT NULL,
orderId INTEGER NOT NULL,
points REAL NOT NULL,
modifiedDatetime TIMESTAMP,
FOREIGN KEY(idReward) REFERENCES UserRewards(idReward),
FOREIGN KEY(orderId) REFERENCES Orders(orderId));


INSERT INTO Category (categoryName) VALUES ('E-commerce/Online');
INSERT INTO Category (categoryName) VALUES ('Fashion / Lifestyle');
INSERT INTO Category (categoryName) VALUES ('Grocery');
INSERT INTO Category (categoryName) VALUES ('Home Needs');
INSERT INTO Category (categoryName) VALUES ('Home Furnishings');
INSERT INTO Category (categoryName) VALUES ('Travel');
INSERT INTO Category (categoryName) VALUES ('Gaming');
INSERT INTO Category (categoryName) VALUES ('Entertainment');
INSERT INTO Category (categoryName) VALUES ('Health / Beauty');
INSERT INTO Category (categoryName) VALUES ('Electronics');
INSERT INTO Category (categoryName) VALUES ('Food / Beverages');
INSERT INTO Category (categoryName) VALUES ('Hospitality');
INSERT INTO Category (categoryName) VALUES ('Jewellery');
INSERT INTO Category (categoryName) VALUES ('Luxury Brand');
INSERT INTO Category (categoryName) VALUES ('International Brands');
INSERT INTO Category (categoryName) VALUES ('Sportswear / Footwear');
INSERT INTO Category (categoryName) VALUES ('Baby Products');
INSERT INTO Category (categoryName) VALUES ('Books');
INSERT INTO Category (categoryName) VALUES ('Finance and Insurance');

INSERT INTO PaymentMethod VALUES(1,'Visa');
INSERT INTO PaymentMethod VALUES(2,'Mastercard');
INSERT INTO PaymentMethod VALUES(3,'Paypal');
