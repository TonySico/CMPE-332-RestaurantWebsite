drop database if exists restaurantdb;
create database restaurantdb;

CREATE TABLE Restaurant( 
URL             CHAR(30)    NOT NULL,
PostalCode      CHAR(6),
Street          VARCHAR(20),
City            VARCHAR(20),
Name            CHAR(20),
PRIMARY KEY(URL));

CREATE TABLE Employee( 
ID              INTEGER     NOT NULL,
Name            VARCHAR(40),
EmailAddress    VARCHAR(35),
PRIMARY KEY(ID));

CREATE TABLE Chef( 
ID              INTEGER     NOT NULL,
PRIMARY KEY(ID),
FOREIGN KEY(ID) REFERENCES Employee(ID) on delete cascade);

CREATE TABLE Credentials( 
ID              INTEGER     NOT NULL,
Credential      VARCHAR(40) NOT NULL,
PRIMARY KEY(ID, Credential),
FOREIGN KEY(ID) REFERENCES Chef(ID) on delete cascade);

CREATE TABLE Delivery(  
ID              INTEGER     NOT NULL,
PRIMARY KEY (ID),
FOREIGN KEY(ID) REFERENCES Employee(ID) on delete cascade);

CREATE TABLE Servers( 
ID              INTEGER     NOT NULL,
PRIMARY KEY (ID),
FOREIGN KEY(ID) REFERENCES Employee(ID) on delete cascade);

CREATE TABLE Manager( 
ID              INTEGER     NOT NULL,
PRIMARY KEY (ID),
FOREIGN KEY(ID) REFERENCES Employee(ID) on delete cascade);

CREATE TABLE Customers( 
EmailAddress    CHAR(35)    NOT NULL,
FName           VARCHAR(20),
LName           VARCHAR(20),
PNumber         CHAR(10),
PostalCode      CHAR(6),
Street          VARCHAR(20),
City            VARCHAR(20),
PRIMARY KEY(EmailAddress));

CREATE TABLE RelatedTo(
EmailAddress    CHAR(35)    NOT NULL,
ID              INTEGER     NOT NULL,
RelType         Char(20)    NOT NULL,
PRIMARY KEY(EmailAddress, ID, RelType),
FOREIGN KEY(EmailAddress) REFERENCES Customers(EmailAddress) on delete cascade,
FOREIGN KEY(ID) REFERENCES Employee(ID) on delete cascade);

CREATE TABLE Account( /* this seems irelevant as it takes the primary key of Customers and creates a new primary key that is used in the
Payment Table, however this is necessary if the ER diagram I submitted is followed. */
PaymentID       INTEGER     NOT NULL,
EmailAddress    CHAR(35)    NOT NULL,
Credit          DECIMAL(10,2),
PRIMARY KEY(PaymentID, EmailAddress),
FOREIGN KEY(EmailAddress) REFERENCES Customers(EmailAddress) on delete cascade);

CREATE TABLE Payment( 
PaymentID       INTEGER     NOT NULL,
EmailAddress    CHAR(35)    NOT NULL,
Day             DATE,
Amount          DECIMAL(10,2),
PRIMARY KEY(PaymentID, EmailAddress, Day),
FOREIGN KEY(PaymentID, EmailAddress) REFERENCES Account(PaymentID, EmailAddress) on delete cascade); -- takes composite foriegn keys to accomodate the keys from Account.

CREATE TABLE Schedule ( 
Days            DATE		NOT NULL,
EmpID           INTEGER     NOT NULL,
ShortDate       CHAR(3),
StartTime       TIME,
EndTime         TIME,
PRIMARY KEY(Days, EmpID),
FOREIGN KEY(EmpID) REFERENCES Employee(ID));


CREATE TABLE Menu( 
URL               CHAR(35)    NOT NULL,
FoodItem           CHAR(20)     NOT NULL,
PRIMARY KEY(FoodItem, URL),
FOREIGN KEY(URL) REFERENCES Restaurant(URL));

CREATE TABLE Food( 
URL             CHAR(35)    NOT NULL,
FoodItemN        CHAR(20)    NOT NULL,
Price           DECIMAL(10,2)     NOT NULL,
PRIMARY KEY(FoodItemN, URL, Price),
FOREIGN KEY(URL, FoodItemN) REFERENCES Menu(URL, FoodItem) on delete cascade);

CREATE TABLE Orders( 
EmailAddress    CHAR(35)    NOT NULL,
OrderID         INTEGER     NOT NULL,
DeliveryID      INTEGER     NOT NULL,
OrderTime       TIME,
DeliveryTime    TIME,
DateOrdered	    DATE,
Total           DECIMAL(10,2),
Tip             DECIMAL(10,2),
PRIMARY KEY(OrderID, EmailAddress),
FOREIGN KEY(EmailAddress) REFERENCES Customers(EmailAddress) on delete cascade);

CREATE TABLE ItemsOrdered( 
EmailAddress    CHAR(35)    NOT NULL,
OrderID         INTEGER     NOT NULL,
IURL            CHAR(35)    NOT NULL,
FoodItem        CHAR(20)    NOT NULL,
ItemNumber      INTEGER     NOT NULL,   
PRIMARY KEY(OrderID, EmailAddress, FoodItem, IURL, ItemNumber),
FOREIGN KEY(OrderID, EmailAddress) REFERENCES Orders(OrderID, EmailAddress),
FOREIGN KEY(IURL, FoodItem) References Menu(URL, FoodItem));

-- Insert Statements

insert into Restaurant values
('R1.com', 'L1L1C1', 'Albert Street', 'Kingston', 'Restaurant 1'),
('R2.com', 'L2L2C2', 'Alfred Street', 'Kingston', 'Restaurant 2'),
('R3.com', 'L3L3C3', 'Victoria Street', 'Kingston', 'Restaurant 3'),
('R4.com', 'L4L4C4', 'Clergy Street', 'Kingston', 'Restaurant 4')
;

insert into Employee values
('123555', 'Ronald Gorbstein', 'R.G@gmail.com'),
('123456', 'Bobald Stellar', 'B.S@gmail.com'),
('234567', 'Dan Yaniel', 'D.YG@gmail.com'),
('345678', 'Kenneth Laird', 'K.L@gmail.com'),
('456789', 'Zackary Savoie', 'Z.S@gmail.com'),
('567890', 'Shaoming Luan', 'S.L@gmail.com'),
('123567', 'Curtis Pike', 'C.P@gmail.com'),
('123678', 'Ivanna Boras', 'I.B@gmail.com')
;

insert into Chef values
('123555'),
('123456')
;

insert into Credentials values
('123555', 'Pro'),
('123456', 'Pro'),
('123555', 'Head Chef'),
('123456',  'Sue Chef')
;

insert into Delivery values
('234567'),
('345678')
;

insert into Servers values
('456789'),
('567890')
;

insert into Manager values
('123567'),
('123678')
;

insert into Customers values
('M.L@gmail.com', 'Maria', 'Londer', '6135678991', 'L1L1C1', 'CLergy Street', 'Kingston'),
('M_L@gmail.com', 'Maria', 'Lounder', '6135678992', 'L2L2C2', 'Albert Street', 'Kingston'),
('M-L@gmail.com', 'Mariana', 'Loonder', '6135678993', 'L3L3C3', 'Alfred Street', 'Kingston'),
('M_L_@gmail.com', 'Marianna', 'Londder', '6135678994', 'L4L4C4', 'Barrie Street', 'Kingston'),
('M..L@gmail.com', 'Marianne', 'Lonnder', '6135678995', 'L5L5C5', 'Victoria Street', 'Kingston'),
('M.S@gmail.com', 'Marius', 'Laurence', '6135678996', 'L6L6C6', 'Johnson Street', 'Kingston')
;

insert into RelatedTo values
('M.L@gmail.com', '123555', 'Father'),
('M_L@gmail.com', '123456', 'Sister'),
('M-L@gmail.com', '234567', 'Brother'),
('M.S@gmail.com', '345678', 'Father')
;

insert into Account values
('16253', 'M.L@gmail.com', '0.00'),
('12346', 'M.L@gmail.com', '0.00'),
('12348', 'M_L@gmail.com', '5.00'),
('14653', 'M_L@gmail.com', '10.00')
;

insert into Payment values
('16253', 'M.L@gmail.com', '2022-03-20', 12.54),
('12346', 'M.L@gmail.com', '2022-04-20', 125.54),
('12348', 'M_L@gmail.com', '2022-03-22', 124.54),
('14653', 'M_L@gmail.com', '2022-03-25', 123.54),
('14653', 'M_L@gmail.com', '2022-04-25', 123.54)
;

insert into Schedule values
('2023-03-20', '234567', 'Mon', '8:00:00', '20:00:00'),
('2023-04-20', '234567', 'Thr', '8:00:00', '20:00:00'),
('2023-04-21', '234567', 'Fri', '8:00:00', '20:00:00'),
('2023-04-22', '234567', 'Sat', '8:00:00', '20:00:00'),
('2023-04-23', '234567', 'Sun', '8:00:00', '20:00:00'),
('2023-04-24', '234567', 'Mon', '8:00:00', '20:00:00'),
('2023-03-20', '345678', 'Mon', '8:00:00', '20:00:00'),
('2023-04-20', '345678', 'Thr', '8:00:00', '20:00:00'),
('2023-03-20', '456789', 'Mon', '8:00:00', '20:00:00'),
('2023-04-20', '456789', 'Thr', '8:00:00', '20:00:00'),
('2023-03-20', '123567', 'Mon', '8:00:00', '20:00:00'),
('2023-04-20', '123567', 'Thr', '8:00:00', '20:00:00'),
('2023-03-20', '567890', 'Mon', '8:00:00', '20:00:00'),
('2023-04-20', '567890', 'Thr', '8:00:00', '20:00:00'),
('2023-03-20', '123678', 'Mon', '8:00:00', '20:00:00'),
('2023-04-20', '123678', 'Thr', '8:00:00', '20:00:00')
;

insert into Menu values
('R1.com', 'Fries'),
('R1.com', 'Steak'),
('R1.com', 'Burger'),
('R1.com', 'Milkshake'),
('R2.com', 'Fries'),
('R2.com', 'Steak'),
('R2.com', 'Burger'),
('R2.com', 'Milkshake'),
('R3.com', 'Fries'),
('R3.com', 'Steak'),
('R3.com', 'Burger'),
('R3.com', 'Milkshake'),
('R4.com', 'Fries'),
('R4.com', 'Steak'),
('R4.com', 'Burger'),
('R4.com', 'Milkshake')
;

insert into food values
('R1.com','Fries', 10.99),
('R1.com', 'Steak', 20.99),
('R1.com', 'Burger', 19.99),
('R1.com', 'Milkshake', 6.99),
('R2.com', 'Fries', 10.99),
('R2.com', 'Steak', 24.99),
('R2.com', 'Burger', 20.99),
('R2.com', 'Milkshake', 7.99),
('R3.com', 'Fries', 8.99),
('R3.com', 'Steak', 15.99),
('R3.com', 'Burger', 19.99),
('R3.com', 'Milkshake', 5.99),
('R4.com', 'Fries', 9.99),
('R4.com', 'Steak', 14.99),
('R4.com', 'Burger', 19.99),
('R4.com', 'Milkshake', 9.99)
;

insert into Orders values
('M.L@gmail.com', '672', '234567', '22:30', '22:45', '2023-03-21', 15.00, 0.00),
('M_L@gmail.com', '673', '234567', '22:00', '22:15', '2023-04-01', 30.00, 5.00),
('M-L@gmail.com', '674', '234567',  '08:00', '9:00', '2023-02-27', 18.55, 3.55),
('M_L_@gmail.com', '675', '345678', '12:00', '12:30', '2023-03-21', 76.00, 15.00),
('M.L@gmail.com', '676', '345678', '19:00', '19:30', '2023-03-21', 27.30, 2.30),
('M.S@gmail.com', '677', '345678', '20:00', '20:30', '2023-04-01', 38.00, 0.00)
;

insert into ItemsOrdered values
('M.L@gmail.com', '672', 'R4.com', 'Steak', '1'),
('M_L@gmail.com', '673', 'R2.com', 'Steak', '1'),
('M-L@gmail.com', '674', 'R4.com', 'Steak', '1'),
('M_L_@gmail.com', '675', 'R3.com', 'Burger', '1'),
('M_L_@gmail.com', '675', 'R3.com', 'Burger', '2'),
('M_L_@gmail.com', '675', 'R2.com', 'Burger', '3'),
('M.L@gmail.com', '676', 'R1.com', 'Milkshake', '1'),
('M.L@gmail.com', '676', 'R1.com', 'Milkshake', '2'),
('M.L@gmail.com', '676', 'R1.com', 'Fries', '3'),
('M.S@gmail.com', '677', 'R1.com', 'Fries', '1') ,
('M.S@gmail.com', '677', 'R1.com', 'Burger', '2'),
('M.S@gmail.com', '677', 'R1.com', 'Milkshake', '3')
;
