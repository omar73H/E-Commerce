--T1
CREATE TABLE Users
(
username varchar(20),
password varchar(20),
first_name varchar(20),
last_name varchar(20),
email varchar(50),
CONSTRAINT pk_Users PRIMARY KEY(username)
);
 
--T2
CREATE TABLE User_mobile_numbers
(
mobile_number varchar(20),
username varchar(20),
CONSTRAINT pk_User_mobile_numbers PRIMARY KEY(mobile_number,username),
CONSTRAINT fk_User_mobile_numbers_Users FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

--T3
CREATE TABLE User_Addresses
(
address varchar(100),
username varchar(20),
CONSTRAINT pk_User_Addresses PRIMARY KEY(address,username),
CONSTRAINT fk_User_Addresses_Users FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);
 
--T4
CREATE TABLE Customer
(
username varchar(20),
points INT,
CONSTRAINT pk_Customer PRIMARY KEY(username),
CONSTRAINT fk_Customer_Users FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

 
--T5
CREATE TABLE Admins
(
username varchar(20),
CONSTRAINT pk_Admins PRIMARY KEY(username),
CONSTRAINT fk_Admins_Users FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);
 
--T6
CREATE TABLE Vendor
(
username varchar(20),
activated BIT,
company_name varchar(20), 
bank_acc_no varchar(20),
admin_username varchar(20) REFERENCES Admins 
CONSTRAINT pk_Vendor PRIMARY KEY(username),
CONSTRAINT fk_Vendor_User FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_Vendor_Admins FOREIGN KEY(admin_username) REFERENCES Admins 
);
 
--T7
CREATE TABLE Delivery_Person(
is_activated BIT,
username varchar(20)
CONSTRAINT pk_Delivery_Person PRIMARY KEY(username),
CONSTRAINT fk_Delivery_Person_Users FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);
 
--T8
CREATE TABLE Credit_Card
(
number varchar(20),
expiry_date DATE,
cvv_code varchar(20)
CONSTRAINT pk_Credit_Card PRIMARY KEY(number)
);
 
--T9
CREATE TABLE Delivery
(
id int IDENTITY,
type varchar(20),
time_duration int ,
fees int,--not sure
username varchar(20),
CONSTRAINT pk_Delivery PRIMARY KEY(id),
CONSTRAINT fk_Delivery_Admins FOREIGN KEY(username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE
);
 
--T10


 ALTER TABLE Orders 
 ALTER COLUMN credit_amount DECIMAL(10,2) 
CREATE TABLE Orders
(
order_no int IDENTITY, 
order_date date DEFAULT GETDATE(), 
total_amount DECIMAL(10,2), 
cash_amount DECIMAL(10,2), 
credit_amount DECIMAL(10,2), 
payment_type varchar(50), --not sure 
order_status varchar(50), --not sure
remaining_days int , 
time_limit date, 
Gift_Card_code_used varchar(10),
customer_name varchar(20), 
delivery_id int, 
creditCard_number varchar(20),
CONSTRAINT pk_Orders PRIMARY KEY(order_no),
CONSTRAINT fk_Orders_Giftcard FOREIGN KEY(Gift_Card_code_used)REFERENCES Giftcard ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_Orders_Customer FOREIGN KEY(customer_name)REFERENCES Customer ,
CONSTRAINT fk_Orders_Delivery FOREIGN KEY(delivery_id)REFERENCES Delivery ,
CONSTRAINT fk_Orders_creditCard_number FOREIGN KEY(creditcard_number)REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE
);
 
--T11
CREATE TABLE Product(
serial_no int IDENTITY,
product_name varchar(20),
category varchar(20),
product_description varchar(100),
price decimal(10,2),
final_price decimal(10,2), -- not sure
color varchar(20),
available BIT,
rate int, --only one user can rate
vendor_username varchar(20),
customer_username varchar(20),
customer_order_id int,
CONSTRAINT pk_Product PRIMARY KEY(serial_no),
CONSTRAINT fk_Product_Vendor FOREIGN KEY (vendor_username) REFERENCES Vendor ,
CONSTRAINT fk_Product_Customer FOREIGN KEY (customer_username) REFERENCES Customer,
CONSTRAINT fk_Product_Order FOREIGN KEY (customer_order_id) REFERENCES Orders ON UPDATE CASCADE ON DELETE CASCADE
);
--T12
CREATE TABLE CustomerAddstoCartProduct
(
serial_no INT,
customer_name varchar(20),
CONSTRAINT pk_CustomerAddstoCartProduct PRIMARY KEY(serial_no,customer_name),
CONSTRAINT fk_CustomerAddstoCartProduct_Product FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_CustomerAddstoCartProduct_Customer FOREIGN KEY(customer_name) REFERENCES Customer
);
 
 
--T13 
CREATE TABLE Todays_Deals
(
deal_id int IDENTITY, --not sure
deal_amount int,
expiry_date DATE,
admin_username varchar(20),
CONSTRAINT pk_Todays_Deals PRIMARY KEY(deal_id),
CONSTRAINT fk_Todays_Deals_Admins FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE
);
 
 
--T14
CREATE TABLE Todays_Deals_Product
(
deal_id int,
serial_no int,
--issue_date date DEFAULT GETDATE(),
CONSTRAINT pk_Todays_Deals_Product PRIMARY KEY(deal_id,serial_no),
CONSTRAINT fk_Todays_Deals_Product_Todays_Deals FOREIGN KEY(deal_id) REFERENCES Todays_Deals ,
CONSTRAINT fk_Todays_Deals_Product_Product FOREIGN KEY(serial_no) REFERENCES Product ON UPDATE CASCADE ON DELETE CASCADE
);
 
--T15
CREATE TABLE offer(
offer_id int IDENTITY,
offer_amount int,
expiry_date datetime,
CONSTRAINT pk_offer PRIMARY KEY(offer_id)
);
 
 
--T16
 
CREATE TABLE offersOnProduct
(--not executed waiting for offer and product
offer_id INT ,
serial_no INT,
CONSTRAINT pk_offersOnProduct PRIMARY KEY(offer_id,serial_no),
CONSTRAINT fk_offersOnProduct_offer FOREIGN KEY(offer_id) REFERENCES offer ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_offersOnProduct_Product FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE
);
 
--T17
CREATE TABLE Customer_Question_Product
(
serial_no INT, 
customer_name varchar(20),
question varchar(50),
answer text,
CONSTRAINT pk_Customer_Question_Product PRIMARY KEY(serial_no,customer_name),
CONSTRAINT fk_Customer_Question_Product_Product FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_Customer_Question_Product_Customer FOREIGN KEY(customer_name) REFERENCES Customer,
 
);
 
 
 
 
--T18
CREATE TABLE Wishlist
(
username varchar(20),
name varchar(20),
CONSTRAINT pk_Wishlist PRIMARY KEY(username,name),
CONSTRAINT fk_Wishlist_Customer FOREIGN KEY(username) REFERENCES Customer 
);
 
 
--T19
CREATE TABLE Giftcard
(
code varchar(10),
expiry_date DATE,
amount int,
username varchar(20) ,
CONSTRAINT pk_Giftcard PRIMARY KEY(code),
CONSTRAINT fk_Giftcard_Customer FOREIGN KEY(username) REFERENCES Admins 
);
 
--T20
CREATE TABLE Wishlist_Product(
username varchar(20),
wish_name varchar(20),
serial_no  int
CONSTRAINT pk_Wishlist_Product PRIMARY KEY(username,wish_name,serial_no),
CONSTRAINT fk_Wishlist_Product_Wishlist FOREIGN KEY(username,wish_name) REFERENCES Wishlist ,
CONSTRAINT fk_Wishlist_Product_Product FOREIGN KEY(serial_no) REFERENCES Product ON UPDATE CASCADE ON DELETE CASCADE
);
 
--T21
CREATE TABLE Admin_Customer_Giftcard
(
code varchar(10),
customer_name varchar(20),
admin_username varchar(20),
remaining_points int,
CONSTRAINT pk_Admin_Customer_Giftcard PRIMARY KEY(code,customer_name,admin_username),
CONSTRAINT fk_Admin_Customer_Giftcard_Giftcard FOREIGN KEY(code) REFERENCES Giftcard ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_Admin_Customer_Giftcard_Customer FOREIGN KEY(customer_name) REFERENCES Customer ,
CONSTRAINT fk_Admin_Customer_Giftcard_Admin FOREIGN KEY(admin_username) REFERENCES Admins 
);
 
--T22
CREATE TABLE Admin_Delivery_Order
(
delivery_username varchar(20),
order_no int ,
admin_username varchar(20),
delivery_window varchar(50)
CONSTRAINT pk_Admin_Delivery_Order PRIMARY KEY(delivery_username,order_no),
CONSTRAINT fk_Admin_Delivery_Order_Delivery_person FOREIGN KEY(delivery_username) REFERENCES  Delivery_person ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_Admin_Delivery_Order_Orders FOREIGN KEY(order_no) REFERENCES  Orders ,
CONSTRAINT fk_Admin_Delivery_Order_Admins FOREIGN KEY(adMin_username) REFERENCES  Admins 
);
 
--T23
CREATE TABLE Customer_CreditCard
(
customer_name varchar(20),
cc_number varchar(20),
CONSTRAINT pk_Customer_CreditCard PRIMARY KEY(customer_name,cc_number),
CONSTRAINT fk_Customer_CreditCard_Customer FOREIGN KEY(customer_name) REFERENCES Customer ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fk_Customer_CreditCard_CerditCard FOREIGN KEY(cc_number) REFERENCES Credit_Card ON UPDATE CASCADE ON DELETE CASCADE
);
 
---PROCEDURES
--P1 <---------------------------------------updated

GO

CREATE PROC customerRegister
@username varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50)
AS
BEGIN
INSERT INTO Users 
VALUES (@username,@password, @first_name,@last_name,@email)
INSERT INTO Customer
VALUES(@username,0)
END

--P2 <---------------------------------------updated
GO
CREATE PROCEDURE vendorRegister 
@username varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50),
@company_name varchar(20), 
@bank_acc_no varchar(20)
AS
INSERT INTO Users
VALUES (@username,@password, @first_name,@last_name,@email)
INSERT INTO Vendor (username,activated,company_name,bank_acc_no)
VALUES (@username,0,@company_name,@bank_acc_no)

SELECT * FROM Users

 
--P3
GO
CREATE PROCEDURE userLogin 
@username varchar(20),@password varchar(20),
@success bit output,@type int output
AS
BEGIN
if ( EXISTS (SELECT *
			FROM Users -- users oder user !!
			WHERE username = @username AND password = @password 
			)
	)
BEGIN
SET @success = '1'
if ( EXISTS (SELECT *
			FROM Customer 
			WHERE username = @username 
			)
	)
BEGIN
SET @type = 0
END
else
BEGIN
if ( EXISTS (SELECT *
			FROM vendor 
			WHERE username = @username 
			)
	)
BEGIN
SET @type = 1
END
else
BEGIN
if ( EXISTS (SELECT *
			FROM Admins 
			WHERE username = @username 
			)
	)
BEGIN
SET @type = 2
END
else
BEGIN
SET @type = 3
END
END
END
END
else
BEGIN
SET @success = '0'
SET @type = -1
END
END;
 
--P4
GO
CREATE PROC addMobile
@username varchar(20),
@mobile_number varchar(20)
AS
INSERT INTO User_mobile_numbers
values(@mobile_number,@username)
 
 
--P5
GO
CREATE PROC addAddres
@username varchar(20),
@address varchar(100)
AS
INSERT INTO User_Addresses 
VALUES (@address,@username)
 
--P6
GO
CREATE PROCEDURE showProducts
AS
BEGIN
SELECT product_name , product_description , price , final_price , color
FROM Product
WHERE available = '1'
END;
 
--P7
GO
CREATE PROC  ShowProductsbyPrice
AS
SELECT product_name , product_description , price  , color
FROM PRODUCT
WHERE available=1 
ORDER BY price
 
--P8
GO
CREATE PROC searchbyname
@text varchar(20)
AS
SELECT product_name , product_description , price , final_price , color
FROM Product
WHERE product_name like '%'+@text+'%'
 
--P9

SELECT * FROM Customer_Question_Product
GO
CREATE PROC AddQuestion
@serial int,
@customer varchar(20) ,
@Question varchar(50) 
AS 
BEGIN
INSERT INTO Customer_Question_Product(serial_no,customer_name,question)
VALUES(@serial,@customer,@Question)
END;
 
 
--P10
--P11

--P12


GO
CREATE PROC createWishlist
@customername varchar(20), 
@name varchar(20)
AS
INSERT INTO Wishlist
VALUES (@customername,@name)
 
--P13

GO
CREATE PROC	AddtoWishlist
@customername varchar(20),
@wishlistname varchar(20),
@serial int
AS
BEGIN

Declare @av bit
SELECT @av = available
FROM Product
WHERE serial_no = @serial
if(@av='1')
BEGIN
INSERT INTO Wishlist_Product
VALUES(@customername,@wishlistname,@serial)
END
else
BEGIN
print 'the product is not available'
END 
END;

--
CREATE PROC	AddtoWishlist
@customername varchar(20),
@wishlistname varchar(20),
@serial int,
@success int output
AS
BEGIN
 
if(EXISTS(SELECT * FROM Wishlist WHERE (name=@wishlistname AND username=@customername)))
BEGIN
SET @success=1;
Declare @av bit
SELECT @av = available
FROM Product
WHERE serial_no = @serial
if(@av='1')
BEGIN
INSERT INTO Wishlist_Product
VALUES(@customername,@wishlistname,@serial)
END
 
END
ELSE
BEGIN
SET @success=0;
END
END
 
 GO
--
 
--P14
GO
 
 
--P15 updated <---------------
GO
CREATE PROC showWishlistProduct
@customername varchar(20), 
@name varchar(20)
AS
SELECT p.product_name , p.product_description , p.price , p.final_price , p.color
FROM Wishlist_Product INNER JOIN  PRODUCT p ON p.serial_no=Wishlist_Product.serial_no
WHERE Wishlist_Product.username=@customername AND Wishlist_Product.wish_name=@name
 
--P16


GO
CREATE PROC viewMyCart
@customer varchar(20)
AS
SELECT p.product_name , p.product_description , p.price , p.final_price , p.color
FROM 
CustomerAddstoCartProduct c INNER JOIN Product p on c.serial_no=p.serial_no
WHERE c.customer_name=@customer
 
--P17
GO
CREATE PROC calculatepriceOrder
@customername varchar(20),
@sum decimal(10,2) output
AS
BEGIN
SELECT @sum = sum(final_price)
FROM (CustomerAddstoCartProduct cp INNER JOIN Product p ON cp.serial_no = p.serial_no)
WHERE cp.customer_name = @customername
END;
 
--P18
GO
CREATE PROC emptyCart
@customername varchar(20)
AS
BEGIN
DELETE FROM CustomerAddstoCartProduct 
WHERE customer_name = @customername
END;
--P19

EXEC makeOrder 'laylay'



GO

CREATE PROC makeOrder
@customername varchar(20)
AS
BEGIN

Declare @total decimal(10,2)
EXEC calculatepriceOrder @customername , @total output
INSERT INTO Orders(order_date, total_amount,order_status,customer_name)
VALUES(GETDATE(),@total,'not processed',@customername)
 
 
declare @temp2 int
SET @temp2 = (SELECT MAX(order_no) FROM Orders)

UPDATE Product 
SET customer_username=@customername , customer_order_id = @temp2
WHERE serial_no IN 
			(SELECT serial_no
			FROM CustomerAddstoCartProduct
			WHERE customer_name = @customername
			);
EXEC productsinorder @customername ,@temp2

EXEC emptyCart @customername
 
END
SELECT *
FROM Customer_CreditCard

SELECT *
FROM Customer
UPDATE Customer
SET points=100

GO
CREATE PROC viewOffers
AS
SELECT * FROM Offer

--P20
GO
CREATE PROC productsinorder
@customername varchar(20),
@orderID int
AS
BEGIN
 
DELETE FROM CustomerAddstoCartProduct
WHERE serial_no IN
(
SELECT serial_no
FROM Product
WHERE customer_username =@customername AND customer_order_id =@orderID
)
 
UPDATE Product
SET available = '0'
WHERE customer_username =@customername AND customer_order_id =@orderID

SELECT *
FROM Product
WHERE customer_username =@customername AND customer_order_id =@orderID

 
END
 
SELECT * FROM Orders
SELECT * FROM Product

-- To be continue
--P21

GO

CREATE PROC cancelOrder
@orderid int
AS
BEGIN
 
if(EXISTS
(
SELECT *
FROM Orders
WHERE order_no = @orderid AND ( order_status = 'not processed' OR order_status = 'in process')
)
)
BEGIN
DECLARE @paymenttype VARCHAR(50)
DECLARE @total_amount DECIMAL(10,2)
DECLARE @cash_amount DECIMAL(10,2)
DECLARE @credit_amount DECIMAL(10,2)
DECLARE @activecard BIT
DECLARE @giftcardcode VARCHAR(10)
Declare @customername varchar(20)
 
SELECT @paymenttype=payment_type,@total_amount=total_amount,@cash_amount=cash_amount,@credit_amount=credit_amount,@customername=customer_name
FROM Orders
WHERE order_no=@orderid
 
Declare @priceOfOrder decimal(10,2)
SET  @priceOfOrder = @total_amount

UPDATE Product
SET available = '1' , customer_order_id = NULL , customer_username = NULL
WHERE serial_no in (SELECT serial_no FROM Product
WHERE customer_order_id=@orderid)

DELETE FROM Orders
WHERE order_no = @orderid


Declare @exDate date
DECLARE @pointsToBeReturned INT

IF(@paymenttype='credit')
BEGIN
	IF(@total_amount>@credit_amount)--partially
	BEGIN
		SELECT @giftcardcode=code
		FROM Admin_Customer_Giftcard
		WHERE customer_name = @customername
		

		SELECT @exDate = expiry_date
		FROM Giftcard
		WHERE code = @giftcardcode

 --
		if(GETDATE() < @exDate)
		BEGIN
			SET @activecard = '1'
		END
		else
		BEGIN
			SET  @activecard = '0'
		END
--

		if(@activecard='1')
		BEGIN
			SET @pointsToBeReturned=@priceOfOrder-@credit_amount
			if(@pointsToBeReturned>0)
			BEGIN
				UPDATE Admin_Customer_Giftcard
				SET remaining_points=remaining_points+@pointsToBeReturned
				WHERE code=@giftcardcode AND  customer_name=@customername
 
				UPDATE Customer
				SET points=points+@pointsToBeReturned
				WHERE username=@customername
			END
		END
	END
END
ELSE --cash
BEGIN
	IF(@total_amount>@cash_amount)--partially
	BEGIN
		SELECT @giftcardcode=code
		FROM Admin_Customer_Giftcard
		WHERE customer_name = @customername 
 
 		

		SELECT @exDate = expiry_date
		FROM Giftcard
		WHERE code = @giftcardcode

 --
		if(GETDATE() < @exDate)
		BEGIN
			SET @activecard = '1'
		END
		else
		BEGIN
			SET  @activecard = '0'
		END
--

		if(@activecard='1')
		BEGIN
			SET @pointsToBeReturned=@priceOfOrder-@cash_amount
			if(@pointsToBeReturned>0)
			BEGIN
				UPDATE Admin_Customer_Giftcard
				SET remaining_points=remaining_points+@pointsToBeReturned
				WHERE code=@giftcardcode AND  customer_name=@customername
 
				UPDATE Customer
				SET points=points+@pointsToBeReturned
				WHERE username=@customername
			END
		END
	END
END
END
END

--P21
GO
--updated
CREATE PROC returnProduct
@serialno int,
@orderid int
AS
DECLARE @PriceofProd INT
DECLARE @paymenttype VARCHAR(50)
DECLARE @total_amount INT
DECLARE @cash_amount INT
DECLARE @credit_amount INT
DECLARE @activecard BIT
DECLARE @customername VARCHAR(20)
DECLARE @giftcardcode VARCHAR(10)
 
SELECT @customername=customer_name
FROM Orders
WHERE order_no=@orderid
 
SELECT @PriceofProd=final_price
FROM Product
WHERE serial_no=@serialno
 
SELECT @paymenttype=payment_type,@total_amount=total_amount,@cash_amount=cash_amount,@credit_amount=credit_amount
FROM Orders
WHERE order_no=@orderid
 
UPDATE Product
SET available='1' , customer_username=NULL , customer_order_id=NULL
WHERE serial_no=@serialno
 
UPDATE Orders
SET total_amount=@total_amount-@PriceofProd
WHERE order_no=@orderid
 

Declare @exDate date
Declare @pointsToBeReturned int
IF(@paymenttype='credit')
BEGIN
	IF(@total_amount>@credit_amount)--partially
	BEGIN
		SELECT @giftcardcode=code
		FROM Admin_Customer_Giftcard
		WHERE customer_name = @customername 

		SELECT @exDate = expiry_date
		FROM Giftcard
		WHERE code = @giftcardcode

 --
		if(GETDATE() < @exDate)
		BEGIN
			SET @activecard = '1'
		END
		else
		BEGIN
			SET  @activecard = '0'
		END
--

		if(@activecard='1')
		BEGIN
			SET @pointsToBeReturned=@PriceofProd-@credit_amount
			if(@pointsToBeReturned>0)
			BEGIN
				UPDATE Admin_Customer_Giftcard
				SET remaining_points=remaining_points+@pointsToBeReturned
				WHERE code=@giftcardcode AND  customer_name=@customername
 
				UPDATE Customer
				SET points=points+@pointsToBeReturned
				WHERE username=@customername
			END
		END
	END
END
ELSE --cash
BEGIN
	IF(@total_amount>@cash_amount)--partially
	BEGIN
		SELECT @giftcardcode=code
		FROM Admin_Customer_Giftcard
		WHERE customer_name = @customername
		
 		SELECT @exDate = expiry_date
		FROM Giftcard
		WHERE code = @giftcardcode

 --
		if(GETDATE() < @exDate)
		BEGIN
			SET @activecard = '1'
		END
		else
		BEGIN
			SET  @activecard = '0'
		END
--

		if(@activecard='1')
		BEGIN
			SET @pointsToBeReturned=@PriceofProd-@cash_amount
			if(@pointsToBeReturned>0)
			BEGIN
				UPDATE Admin_Customer_Giftcard
				SET remaining_points=remaining_points+@pointsToBeReturned
				WHERE code=@giftcardcode AND  customer_name=@customername
 
				UPDATE Customer
				SET points=points+@pointsToBeReturned
				WHERE username=@customername
			END
		END
	END
END
 
--P22
GO
CREATE PROC ShowproductsIbought
@customername varchar(20)
AS
BEGIN
SELECT serial_no , product_name , category ,product_description , price , final_price ,color
FROM Product
WHERE customer_username = @customername AND (EXISTS (SELECT * FROM Orders WHERE order_no=customer_order_id AND order_status='Delivered'))
END
 
--P23

GO
CREATE PROC rate --NOT SURE
@serial_no int, 
@rate int ,
@customername varchar(20)
AS
DECLARE @customerorderid int
SELECT @customerorderid=customer_order_id
FROM Product
WHERE serial_no=@serial_no

if(EXISTS (SELECT * FROM Orders WHERE order_no=@customerorderid AND order_status='Delivered'))
BEGIN
UPDATE  Product 
set rate=@rate
WHERE @serial_no=serial_no AND @customername=customer_username
 END
 ELSE
 BEGIN
 print 'You can not rate products that you did not bought as it is not DELIVERED yet'
 END

--P24

GO

go
CREATE PROC Specifyamount
@customername varchar(20), 
@orderID int, 
@cash decimal(10,2), 
@credit decimal(10,2),
@success BIT OUTPUT
AS
DECLARE @total DECIMAL(10,2)
SELECT @total=total_amount
FROM Orders
WHERE order_no=@orderID
 
 
DECLARE @code VARCHAR(10)
DECLARE @points INT
SELECT @points=points
FROM Customer
WHERE @customername=username


IF(@cash is NULL)--pay using credit
BEGIN
	IF(@total<=@credit)--no points
	BEGIN
	
			UPDATE Orders
			SET credit_amount=@credit , payment_type = 'credit'
			WHERE order_no=@orderID AND customer_name=@customername
			SET @success='1'
			
	END
	ELSE--with points
	BEGIN
	if(@total>@credit+@points)
	BEGIN
SET @success='0'
	
END
ELSE
BEGIN
SET @success='1'

SELECT @code=code
		FROM Admin_Customer_Giftcard
		WHERE customer_name=@customername
 
		UPDATE Orders
		SET credit_amount=@credit , payment_type = 'credit' , Gift_Card_code_used=@code
		WHERE order_no=@orderID AND customer_name=@customername
 
		UPDATE Admin_Customer_Giftcard
		SET remaining_points=remaining_points-(@total-@credit)
		WHERE code=@code AND  customer_name=@customername
 
		UPDATE Customer
		SET points=points-(@total-@credit)
		WHERE username=@customername

	END	
	END
END
ELSE--pay using cash
BEGIN
	IF(@total<=@cash)--no points
	BEGIN
		print @success
	
			UPDATE Orders
			SET cash_amount=@cash , payment_type = 'cash'
			WHERE order_no=@orderID AND customer_name=@customername
			SET @success='1'
	
	END
	ELSE--with points
	BEGIN
			if(@total>@cash+@points )
	BEGIN
SET @success='0'

END
ELSE
BEGIN
SET @success='1'
	print('helpme')
		SELECT @code=code
		FROM Admin_Customer_Giftcard
		WHERE customer_name=@customername
 
		UPDATE Orders
		SET cash_amount=@cash , payment_type = 'cash' , Gift_Card_code_used=@code
		WHERE order_no=@orderID AND customer_name=@customername
 
		UPDATE Admin_Customer_Giftcard
		SET remaining_points=remaining_points-(@total-@cash)
		WHERE code=@code AND  customer_name=@customername
 
		UPDATE Customer
		SET points=points-(@total-@cash)
		WHERE username=@customername
	END
END
END


DECLARE @success BIT 
execute Specify 'laylay',89,null,210,@success OUTPUT
PRINT @success

SELECT *
FROM Customer_CR


UPDATE CUSTOMER
SET points=100

UPDATE Orders
SET total_amount=300



go
--P25
GO
CREATE PROC AddCreditCard
@creditcardnumber varchar(20), @expirydate date , @cvv varchar(4), @customername varchar(20)
AS
BEGIN
INSERT INTO Credit_Card(number, expiry_date, cvv_code) 
VALUES (@creditcardnumber,@expirydate , @cvv);
INSERT INTO Customer_CreditCard(customer_name, cc_number)
VALUES (@customername,@creditcardnumber);
END
 
--P26
 
GO

CREATE PROC ChooseCreditCard
@creditcard varchar(20),@orderid int,@success BIT OUTPUT
AS
DECLARE @DATE date



SELECT @DATE=expiry_date
FROM Credit_Card
WHERE @creditcard=number

if(@DATE>GETDATE())
BEGIN
set @success=0
END


else
BEGIN
SET @success=1
UPDATE Orders
SET creditCard_number = @creditcard
WHERE order_no = @orderid
END


SELECT *
FROM Credit_Card


--P27
GO
CREATE PROC vewDeliveryTypes
AS
SELECT type,fees,time_duration
from Delivery
 

--P28
GO
CREATE PROC specifydeliverytype
@orderID int, 
@deliveryID int
AS
DECLARE @duration int
SELECT @duration=time_duration
FROM Delivery
WHERE id=@deliveryID
 
Declare @orderDate date
SELECT @orderDate=order_date
FROM Orders
WHERE order_no = @orderID

Declare @timelimit date
SET @timelimit = DATEADD(DAY,@duration ,@orderDate) 

UPDATE Orders
SET delivery_id=@deliveryID , remaining_days=@duration , time_limit = @timelimit
WHERE order_no=@orderID
 
--P29
GO -- ASK ABOUT THAT
CREATE PROC trackRemainingDays
@orderid int,@customername varchar(20),   --- Why I get the customername ,,,, I have orderid is enough to identify the order
@days int output
AS
BEGIN
declare @timelimit date
SELECT @timelimit = time_limit
FROM Orders
WHERE order_no=@orderid AND customer_name = @customername
 
SET @days = DATEDIFF(day , GETDATE() , @timelimit) 
 
UPDATE Orders
SET remaining_days = @days
WHERE order_no=@orderid AND customer_name = @customername
 
END
 
--P30
--RECOMMEND
GO
CREATE PROC recommend
@customername varchar(20)
AS
BEGIN
--case 1 top 3 cats. in my cart
 
CREATE TABLE temp
(
category varchar(20),
countP int
);
INSERT INTO temp
SELECT p.category , COUNT(cp.serial_no) AS countP
FROM CustomerAddstoCartProduct cp INNER JOIN Product p ON cp.serial_no = p.serial_no
WHERE cp.username = @customername
GROUP BY p.category
 
 
 
Declare @category1 varchar(20)
SELECT TOP 1 @category1 = category
FROM temp
 
DELETE FROM temp
WHERE category = @category1
 
Declare @category2 varchar(20)
SELECT TOP 1 @category2 = category
FROM temp
 
DELETE FROM temp
WHERE category = @category2
 
Declare @category3 varchar(20)
SELECT TOP 1 @category3 = category
FROM temp
 
DELETE FROM temp
WHERE category = @category3
 
DROP TABLE temp;
 
-- get the wished products of only cat1 , cat2 ,cat3
CREATE TABLE temp
(
serial varchar(20),
countW int
);
 
INSERT INTO temp
SELECT  p.serial_no , COUNT(*) AS countW
FROM Wishlist_Product w INNER JOIN Product p ON w.serial_no = p.serial_no
WHERE p.category IN (@category1,@category2,@category3)
GROUP BY p.serial_no
ORDER BY countW DESC
 
 
Declare @p1 varchar(20)
SELECT TOP 1 @p1 = serial
FROM temp
 
DELETE FROM temp
WHERE serial = @p1
 
Declare @p2 varchar(20)
SELECT TOP 1 @p2 = serial
FROM temp
 
DELETE FROM temp
WHERE serial = @p2
 
Declare @p3 varchar(20)
SELECT TOP 1 @p3 = serial
FROM temp
 
DELETE FROM temp
WHERE serial = @p3
 
 
DROP TABLE temp;
 
CREATE TABLE temp
(
username varchar(20),
countP int
)
INSERT INTO temp
SELECT username , count(DISTINCT serial_no) AS countP
FROM CustomerAddstoCartProduct
WHERE username <> @customername AND serial_no IN
										(
										SELECT serial_no
										FROM CustomerAddstoCartProduct
										WHERE username = @customername
										)
GROUP BY username
 
Declare @maxCount int
SELECT @maxCount=MAX(countP)
FROM temp
 
DELETE FROM temp WHERE countP <> @maxCount -- temp contains the customer most like to me
 
CREATE TABLE temp2
(
serial varchar(20),
username varchar(20)
);
 
INSERT INTO temp2 -- contains wished items of the most like customers
SELECT serial_no , username
FROM Wishlist_Product
WHERE username IN 
				(
				SELECT username
				FROM temp
				)
 
CREATE TABLE temp3
(
serial varchar(20),
countU int
);
 
 
INSERT INTO temp3
SELECT serial , count(DISTINCT username) AS countU
FROM temp2
GROUP BY serial
ORDER BY countU DESC
 
Declare @p4 varchar(20)
SELECT TOP 1 @p4 = serial
FROM temp3
 
DELETE TOP (1) FROM temp3
 
Declare @p5 varchar(20)
SELECT TOP 1 @p5 = serial
FROM temp3
 
DELETE TOP (1) FROM temp3
 
Declare @p6 varchar(20)
SELECT TOP 1 @p6 = serial
FROM temp3
 
DELETE TOP (1) FROM temp3
 
DROP TABLE temp;
DROP TABLE temp2;
DROP TABLE temp3;
 
SELECT serial_no , product_name , category , product_description , price , final_price , color
FROM Product
WHERE serial_no IN (@p1,@p2,@p3,@p4,@p5,@p6) AND available = '1';
 
END

--P31
 
GO

CREATE PROC postProduct
@vendorUsername varchar(20), 
@product_name varchar(20) ,
@category varchar(20), 
@product_description text , 
@price decimal(10,2), 
@color varchar(20),
@activatedVendor BIT output
AS
DECLARE @activated BIT
SELECT @activated=activated
FROM Vendor
WHERE username=@vendorUsername
if(@activated='1')
BEGIN
INSERT INTO Product(vendor_username,product_name,category, product_description,price,final_price, color,available)
VALUES(@vendorUsername,@product_name,@category,@product_description,@price,@price,@color,'1')
 END
SET @activatedVendor = @activated
 
--P32
GO -- SHOULD I SHOW ALL DETAILS (COLUMNS)
CREATE PROC vendorviewProducts
@vendorname varchar(20)
AS
BEGIN
SELECT *
FROM Product
WHERE vendor_username=@vendorname
END
 
--P33
GO
CREATE PROC EditProduct
@vendorname varchar(20), @serialnumber int, @product_name varchar(20) ,@category varchar(20),
@product_description text , @price decimal(10,2), @color varchar(20)
AS
if(@product_name IS NOT NULL)
BEGIN
UPDATE Product 
set  product_name=@product_name
WHERE serial_no=@serialnumber
END

if(@category IS NOT NULL)
BEGIN
UPDATE Product 
set  category=@category
WHERE serial_no=@serialnumber
END

if(@product_description IS NOT NULL)
BEGIN
UPDATE Product 
set  product_description=@product_description
WHERE serial_no=@serialnumber
END

if(@price IS NOT NULL)
BEGIN

DECLARE @amount INT
SET @amount=0

SELECT @amount=offer_amount
FROM offer
WHERE offer_id in (SELECT offer_id FROM offersOnProduct 
WHERE serial_no=@serialnumber)

UPDATE Product 
set  price=@price , final_price=@price-((@price*@amount)/100) 
WHERE serial_no=@serialnumber

DECLARE @amount2 INT
SET @amount2=0

SELECT @amount2=t.deal_amount
FROM Todays_Deals t INNER JOIN Todays_Deals_Product tp ON t.deal_id = tp.deal_id
WHERE tp.serial_no = @serialnumber 

UPDATE Product 
set  price=@price , final_price=final_price-((final_price*@amount2)/100) 
WHERE serial_no=@serialnumber
END

if(@color IS NOT NULL)
BEGIN
UPDATE Product 
set  color=@color
WHERE serial_no=@serialnumber
END

GO
--NOT SURE AT ALL
 
 
--P34
GO
CREATE PROC deleteProduct
@vendorname varchar(20), 
@serialnumber int
AS
DELETE FROM Products 
WHERE vendor_username=@vendorname AND serial_no=@serialnumber;
 
--P35
GO -- WHAT SHOULD I COLUMNS SHOW
CREATE PROC viewQuestions
@vendorname varchar(20)
AS
BEGIN
SELECT p.serial_no,cqp.customer_name,cqp.question,cqp.answer
FROM (Customer_Question_Product cqp INNER JOIN Product p ON p.serial_no = cqp.serial_no)
WHERE p.vendor_username = @vendorname
END
 
 
--P36
GO
CREATE PROC answerQuestions
@vendorname varchar(20), @serialno int, @customername varchar(20), @answer text
AS
DECLARE @ven varchar(20)
SELECT @ven=vendor_username
FROM Product
WHERE @serialno=serial_no 
if(@ven=@vendorname)
BEGIN
UPDATE Customer_Question_Product
SET answer=@answer
WHERE @serialno=serial_no AND  @customername=customer_name 
END
ELSE
BEGIN
print 'you are only allowed to answer questions on your products'
END

--P37
GO
 
CREATE PROC addOffer
@offeramount int,
@expiry_date DATETIME
AS
INSERT INTO Offer(offer_amount, expiry_date)
VALUES(@offeramount, @expiry_date)
 
--P38
GO
CREATE PROC checkOfferonProduct
@serial int,
@activeoffer BIT OUTPUT
AS
if(EXISTS (SELECT * FROM offersOnProduct WHERE serial_no=@serial))
BEGIN
SET @activeoffer='1'
END
ELSE
BEGIN
SET @activeoffer='0'
 END

 --extra
GO
CREATE PROC showMyProductsAndOffers
@vendor_name varchar(20)
AS
BEGIN
SELECT p.serial_no , p.product_name , op.offer_id , o.expiry_date , o.offer_amount
FROM Product p LEFT OUTER JOIN (offersOnProduct op INNER JOIN offer o ON o.offer_id = op.offer_id) ON p.serial_no = op.serial_no
WHERE p.vendor_username = @vendor_name;
END
SELECT * FROM offer;


GO

CREATE PROC	removeFromWishlist
@customername varchar(20),
@wishlistname varchar(20),
@serial int,
@success int output
AS
BEGIN
 
if(EXISTS(SELECT * FROM Wishlist WHERE (name=@wishlistname AND username=@customername)))
BEGIN
DELETE FROM Wishlist_Product
WHERE username = @customername AND wish_name = @wishlistname AND serial_no = @serial
SET @success=1;
END
ELSE
BEGIN
	SET @success=0;
END
END;
 GO
--
CREATE PROC	AddtoWishlist
@customername varchar(20),
@wishlistname varchar(20),
@serial int,
@success int output
AS
BEGIN
 
if(EXISTS(SELECT * FROM Wishlist WHERE (name=@wishlistname AND username=@customername)))
BEGIN
SET @success=1;
Declare @av bit
SELECT @av = available
FROM Product
WHERE serial_no = @serial
if(@av='1')
BEGIN
INSERT INTO Wishlist_Product
VALUES(@customername,@wishlistname,@serial)
END
 
END
ELSE
BEGIN
SET @success=0;
END
END
 
 GO
--
CREATE PROC removefromCart
@customername varchar(20), 
@serial int,
@success int output
AS
if(EXISTS(SELECT * FROM CustomerAddstoCartProduct WHERE serial_no=@serial AND customer_name=@customername))
BEGIN
DELETE FROM CustomerAddstoCartProduct WHERE @customername=customer_name AND @serial=serial_no;
 SET @success=1;
 END
 ELSE
 BEGIN
 SET @success=0;
 END

GO
--P39
CREATE PROC checkandremoveExpiredoffer
@offerid int,
@expired BIT output
AS
DECLARE @dateoffer DATETIME 
 DECLARE @amount INT
SELECT @dateoffer=expiry_date,@amount=offer_amount
FROM offer
WHERE offer_id=@offerid
 
 PRINT @dateoffer

if(@dateoffer<=GETDATE())
BEGIN
	
	SET @expired = '1';

	UPDATE Product
	SET final_price=final_price*100/(100.0-@amount)
	WHERE EXISTS (SELECT * FROM offersOnProduct o WHERE o.serial_no=serial_no AND o.offer_id=@offerid)
	

	
	DELETE FROM offer WHERE offer_id=@offerid;
	DELETE FROM offersOnProduct WHERE offer_id=@offerid;
END
ELSE
BEGIN
SET @expired = '0';
END
 --P40
GO
CREATE PROC applyOffer
@vendorname varchar(20), 
@offerid int, 
@serial int
AS
DECLARE @active BIT
DECLARE @dateoffer DATETIME 
DECLARE @amount INT
 
SELECT @dateoffer=expiry_date , @amount=offer_amount
FROM offer
WHERE offer_id=@offerid
 
EXEC checkOfferonProduct @serial , @active OUTPUT
 
if(@dateoffer>GETDATE() AND @active='0')
BEGIN
	Declare @ven varchar(20)
	SELECT @ven = vendor_username
	FROM Product
	WHERE serial_no = @serial
	if(@ven = @vendorname)
	BEGIN
		INSERT INTO offersOnProduct
		VALUES(@offerid,@serial)
 
		UPDATE Product
		SET final_price=final_price-((final_price*@amount)/100) 
		WHERE vendor_username=@vendorname AND serial_no=@serial
	END
	else
	BEGIN
		print 'you are only allowed to apply offers to your products'
	END
END
ELSE
BEGIN
	if(@dateoffer>GETDATE() )
	BEGIN
		PRINT('The product has an active offer ' )
	END
	else
	BEGIN
		print ('it is an expired offer')
	END
END
--P41
GO 
CREATE PROC activateVendors
@admin_username varchar(20),@vendor_username varchar(20)
AS
BEGIN
UPDATE Vendor
SET activated = '1' , admin_username = @admin_username
WHERE username = @vendor_username
END

--P42
--not sure
GO
CREATE PROC  inviteDeliveryPerson
@delivery_username varchar(20), @delivery_email varchar(50)
AS
INSERT INTO Users(username,email)
values(@delivery_username,@delivery_email)
INSERT INTO Delivery_Person
VALUES (0,@delivery_username)

 
--P43
GO
UPDATE 
Orders
SET total_amount=30;
GO
SELECT *
FROM Orders

 GO
 SELECT *
 FROM Orders

CREATE PROC reviewOrders
AS
SELECT *
FROM Orders
 
 EXEC reviewOrders
--P44
GO
CREATE PROC updateOrderStatusInProcess
@order_no int
AS
BEGIN
UPDATE Orders
SET order_status = 'in process'
WHERE order_no = @order_no
END
 
--P45
GO
CREATE PROC  addDelivery
 @delivery_type varchar(20),@time_duration int,@fees decimal(5,3),@admin_username varchar(20)
 AS
 INSERT INTO Delivery (time_duration,fees,username,type)
 VALUES (@time_duration,@fees ,@admin_username,@delivery_type)
 
 --P46
 GO
CREATE PROC assignOrdertoDelivery
@delivery_username varchar(20),
@order_no int,
@admin_username varchar(20)
AS
INSERT INTO Admin_Delivery_Order(delivery_username, order_no , admin_username)
VALUES (@delivery_username, @order_no , @admin_username)
 
--P47
GO
CREATE PROC createTodaysDeal -- DEAL ID should be IDENTITY
@deal_amount int,@admin_username varchar(20),@expiry_date datetime
AS 
BEGIN
INSERT INTO Todays_Deals VALUES(@deal_amount,@expiry_date,@admin_username)
END 
 
--48
GO
CREATE PROC checkTodaysDealOnProduct
@serial_no int,
@activeDeal bit output
AS
BEGIN
if( EXISTS (
		SELECT *
		FROM Todays_Deals_Product
		WHERE serial_no = @serial_no
		)
	)
BEGIN
SET @activeDeal = '1'
END
else
BEGIN
SET @activeDeal = '0'
END
END
 
--49
GO -- not sure about the else part
CREATE PROC addTodaysDealOnProduct
@deal_id int, @serial_no int
AS
BEGIN
DECLARE @date DATETIME 
DECLARE @amount INT
 
SELECT @date=expiry_date , @amount=deal_amount
FROM Todays_Deals
WHERE deal_id=@deal_id
 
declare @alreadyHasDeal bit
EXEC checkTodaysDealOnProduct @serial_no, @alreadyHasDeal output
if(@date>GETDATE() AND @alreadyHasDeal = '0')
BEGIN
INSERT INTO Todays_Deals_Product VALUES (@deal_id, @serial_no)

UPDATE Product
SET final_price=final_price-((final_price*@amount)/100) 
WHERE serial_no=@serial_no
END
else
BEGIN
	if(@date>GETDATE())
	BEGIN
		print 'The product already has a deal'
	END
	else
	BEGIN
		print 'you cannot add an expired deal'
	END
END
END
 
--50
GO
CREATE PROC removeExpiredDeal
@deal_iD int
AS
BEGIN
DECLARE @datetodaysdeal DATETIME 
 DECLARE @amount INT
SELECT @datetodaysdeal=expiry_date,@amount=deal_amount
FROM Todays_Deals
WHERE deal_id=@deal_iD
 
if(@datetodaysdeal<=GETDATE())
BEGIN
	
	UPDATE Product
	SET final_price=final_price*100/(100.0-@amount)
	WHERE EXISTS (SELECT * FROM Todays_Deals_Product t WHERE t.serial_no=serial_no AND t.deal_id=@deal_iD)
	
	DELETE FROM Todays_Deals WHERE deal_id=@deal_iD;
	DELETE FROM Todays_Deals_Product WHERE deal_id=@deal_iD;
END
END
 
 
--51
 GO
 
CREATE PROC createGiftCard
@code varchar(10),
@expiry_date datetime,
@amount int,
@admin_username varchar(20)
AS
INSERT INTO Giftcard
VALUES (@code , @expiry_date, @amount, @admin_username)


--52
 GO
 Create PROC checkGiftCardOnCustomer
 @code varchar(10) , @activeGiftCard BIT OUTPUT
 AS
if( EXISTS (
		SELECT *
		FROM Admin_Customer_Giftcard
		WHERE @code=code
		)
	)
 
SET @activeGiftCard = '1'
ELSE
SET @activeGiftCard = '0'
 

 --53
GO
CREATE PROC giveGiftCardtoCustomer 
@code varchar(10),@customer_name varchar(20),@admin_username varchar(20)
AS
DECLARE @P1 INT
EXEC removeExpiredGiftCard @code
declare @activeGiftCard bit

if(EXISTS (SELECT * FROM Admin_Customer_Giftcard WHERE customer_name=@customer_name AND code=@code))
SET @activeGiftCard='1'
ELSE
SET @activeGiftCard='0'
DECLARE @exist BIT
IF(EXISTS (SELECT * FROM Giftcard WHERE code=@code))
SET @exist='1'
ELSE
SET @exist='0'



IF(@activeGiftCard='0' AND @exist='1')
BEGIN

SELECT @P1=amount
FROM Giftcard
WHERE @code=code
 
INSERT INTO Admin_Customer_Giftcard VALUES(@code,@customer_name,@admin_username,@P1)

UPDATE  Customer 
SET points=points+@p1
WHERE @customer_name=username
END


--54
GO
 CREATE PROC removeExpiredGiftCard
 @code varchar(10)
 AS
 Declare @date DATE
 Declare @amount int
 SELECT @date = expiry_date ,@amount = amount
 FROM Giftcard
 WHERE code = @code
 if(@date<GETDATE())
 BEGIN
 UPDATE Customer
 SET points = points - @amount
 WHERE username in (SELECT customer_name FROM Admin_Customer_Giftcard WHERE code = @code)
 
 DELETE FROM Giftcard 
 WHERE code = @code
 DELETE FROM Admin_Customer_Giftcard
 WHERE code = @code
 END
 
 
 
 --55
 GO
CREATE PROC acceptAdminInvitation
@delivery_username varchar(20)
AS
BEGIN
UPDATE Delivery_Person
SET is_activated = '1'
WHERE username = @delivery_username
END
 
 
--56
GO
CREATE PROC deliveryPersonUpdateInfo
@username varchar(20),@first_name varchar(20),@last_name varchar(20),@password varchar(20),@email
varchar(50)
AS
UPDATE Users
SET first_name=@first_name , last_name=@last_name , password=@password , email=@email
WHERE @username=username 

--57
GO
CREATE PROC  viewmyorder
@deliveryperson varchar(20)
AS
SELECT o.*
FROM Admin_Delivery_Order d INNER JOIN  Orders o ON o.order_no=d.order_no
where d.delivery_username=@deliveryperson

--58
GO
CREATE PROC  specifyDeliveryWindow
@delivery_username varchar(20),@order_no int,@delivery_window varchar(50)
AS
UPDATE   Admin_Delivery_Order
SET delivery_window=@delivery_window
WHERE delivery_username=@delivery_username AND order_no=@order_no
 

 --59
 GO
CREATE PROC updateOrderStatusOutforDelivery
@order_no int
AS
BEGIN
UPDATE Orders
SET order_status = 'out for delivery'
WHERE order_no = @order_no
END
 
--60
GO
 
CREATE PROC updateOrderStatusDelivered
@order_no int
AS
UPDATE Orders
SET order_status='Delivered'
WHERE order_no=@order_no
 
 SELECT *
 FROM Orders


 --added proc 
 GO
 CREATE PROC CUSTOMERINFO
 @username varchar (20)
 , @point  INT OUTPUT 
 AS
 SELECT @point=points
 FROM Customer
 WHERE username=@username
 
 GO
 
 
 CREATE PROC CHECKIFPAYED
 @order_id INT ,
@success BIT OUTPUT
 AS
 DECLARE @type varchar(20)
 SELECT @type=payment_type
 FROM ORDERS
 WHERE @order_id=order_no
 if(@type IS  NULL)
 BEGIN
 SET @success=0
 END
 ELSE
 BEGIN
 SET @success=1
 END

 DECLARE @SUC BIT 
 EXEC CHECKIFPAYED 20 , @SUC OUTPUT
 PRINT @SUC
 
 SELECT *
 FROM Customer_CreditCard


 SELECT *
 FROM Orders




 SELECT *
 FROM Orders


 GO
 CREATE PROC orderstat
 @orderid INT,
 @success BIT OUTPUT

 AS
DECLARE @state varchar(20)
 SELECT @state=order_status
 FROM Orders
 WHERE @orderid=order_no
 if( @state = 'not processed' OR @state = 'in process')
 BEGIN
 set @success=1
 END
 

GO
 CREATE PROC  ShowProductsbyPriceAndSerial
AS
SELECT serial_no,product_name , product_description , price , final_price , color
FROM PRODUCT
WHERE available=1 
ORDER BY price
 
 
GO
CREATE PROC showWishlistProductWithSerial
@customername varchar(20), 
@name varchar(20)
AS
SELECT p.serial_no , p.product_name , p.product_description , p.price , p.final_price , p.color
FROM Wishlist_Product INNER JOIN  PRODUCT p ON p.serial_no=Wishlist_Product.serial_no
WHERE Wishlist_Product.username=@customername AND Wishlist_Product.wish_name=@name
 

GO
CREATE PROC viewMyCartWithSerial
@customer varchar(20)
AS
SELECT p.serial_no , p.product_name , p.product_description , p.price , p.final_price , p.color
FROM 
CustomerAddstoCartProduct c INNER JOIN Product p on c.serial_no=p.serial_no
WHERE c.customer_name=@customer
 GO
 
 CREATE PROC CHECKORDER
 @orderid INT , 
 @success BIT OUTPUT
 AS
 DECLARE @status  VARCHAR(20)
 SELECT @status=order_status
 FROM Orders
 WHERE @orderid=order_no
 
 if(@status= 'not processed' OR @status ='in process')
BEGIN
SET @success=1
END
ELSE
BEGIN
SET @success=0
END

UPDATE  Orders
SET order_status='not processed'

DECLARE @SUC BIT
EXEC CHECKORDER 132, @SUC OUTPUT
print @SUC


select *
from Orders


 GO


 SELECT *
 FROM USERS
 UPDATE Vendor
 SET activated=1

 select*
 from Product

 
 select *
 from Orders


 UPDATE Orders
 SET total_amount=300
 EXEC postProduct 'RIDER','sugar','food','nice',100,'yellow'

 select *
 from Credit_Card

 
 
 --new
 GO
 CREATE PROC allWislists
 @customername VARCHAR(20)
 AS
 SELECT name
 FROM Wishlist
 WHERE username=@customername
 GO

 
 CREATE PROC OWNSCARD
 @number varchar(20),
 @customername varchar(20),
 @customername varchar(20),
 @success BIT OUTPUT 
 AS
 IF EXISTS(SELECT *
 FROM Customer_CreditCard
 WHERE  @customername=customer_name AND @number=cc_number
 )
 BEGIN 
 SET @success=1;
 END
 ELSE
 BEGIN
 SET @success=0;
 END 


 SELECT *
 FROM Customer_CreditCard

 DECLARE @SUC bit
 EXEC OWNSCARD '4' ,'12312',@SUC OUTPUT
 PRINT @SUC


 select *
 from Orders

 SELECT *
 FROM Customer_CreditCard
UPDATE Customer
SET points=0

insert INTO offer VALUES(20,'01-01-1999');