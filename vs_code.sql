-- Created Queries for league, Team, Product and using auto increment for Primary keys for each table 
CREATE TABLE League(
    league_id INT AUTO_INCREMENT PRIMARY KEY, 
    league_name VARCHAR(50) NOT NULL,
    league_country VARCHAR(50) NOT NULL, 
    league_year YEAR NOT NULL, 
    league_sponsor VARCHAR(50), 
    league_tier INT NOT NULL
);

CREATE TABLE Team(
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    team_country VARCHAR(100) NOT NULL,
    team_year SMALLINT,
    league_id INT NOT NULL,
    FOREIGN KEY (league_id) REFERENCES League(league_ID)
);

CREATE TABLE Product(
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    prod_name VARCHAR(150) NOT NULL,
    prod_price DECIMAL(10,2) NOT NULL,
    prod_brand VARCHAR(100)  NOT NULL,
    prod_season VARCHAR(20),
    prod_type ENUM('Jersey','Footwear','Accessories') NOT NULL,
    team_id INT NOT NULL,
    FOREIGN KEY (team_id) REFERENCES Team(team_id)
);

CREATE TABLE Jersey(
    PRIMARY KEY (product_id),
    jsy_size VARCHAR(10) NOT NULL,
    jsy_player_nm VARCHAR(100),
    jsy_type VARCHAR(50) NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Footwear(
    product_id INT NOT NULL,
    foot_size VARCHAR(10) NOT NULL,
    foot_cleat_type VARCHAR(50) NOT NULL,
    foot_color VARCHAR(50),
    PRIMARY KEY (product_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Accessories(
    product_id INT NOT NULL,
    accy_type VARCHAR(50) NOT NULL,
    accy_descript VARCHAR(255),
    accy_size VARCHAR(20),
    PRIMARY KEY (product_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABKE Inventory(
    invent_id INT AUTO_INCREMENT PRIMARY KEY,
    invent_quantity INT NOT NULL DEFAULT 0,
    invent_update_date DATE,
    invent_location VARCHAR(100),
    invent_id INT NOT NULL,
    FOREIGN KEY(product_id) REFERENCES Product(product_id)
);

CREATE TABLE Vendor(
    vend_id INT AUTO_INCREMENT PRIMARY KEY, 
    vend_name VARCHAR(100) NOT NULL,
    vend_email VARCHAR(100) NOT NULL,
    vend_phone VARCHAR(30),
    vend_country VARCHAR(100) NOT NULL, 
    vend_address VARCHAR(250) NOT NULL
);

CREATE TABLE Product_Vendor(
    prod_vend_id INT AUTO_INCREMENT PRIMARY KEY,
    prod_vend_price DECIMAL(10,2) NOT NULL,
    prod_vend_date DATE,
    vend_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (vend_id) REFERENCES Vendor(vend_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Sales_Channel(
    channel_id INT AUTO_INCREMENT PRIMARY KEY,
    chl_name VARCHAR(100) NOT NULL,
    chl_region VARCHAR(100),
    chl_status VARCHAR(20) NOT NULL DEFAULT 'Active',  --Default key active to keep the channel on unlsess specified to turn off 
    chl_date DATE
);

CREATE TABLE Shipment(
    shipment_id INT AUTO_INCREMENT PRIMARY KEY,
    ship_address VARCHAR(250) NOT NULL,
    ship_date DATE, 
    ship_carrier VARCHAR(100),
    ship_delivery_status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    invoice_id INT NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id)
);

CREATE TABLE Invoice_item(
    invoice_item_id INT AUTO_INCREMENT PRIMARY KEY, 
    prod_quantity INT NOT NULL,
    prod_price_at_time DECIMAL(10,2) NOT NULL,
    invoice_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY(invoice_id) REFERENCES Invoice(invoice_id),
    FOREIGN KEY(product_id) REFERENCES Product(product_id)
);

CREATE TABLE Invoice(
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    inv_date DATE,
    inv_status VARCHAR(50) NOT NULL,
    customer_id INT NOT NULL,
    --Why would it be channel id as a FK? Shouldn't it be payment_id? 
    --To create an invoice you need customer details and payment information. 
    payment_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
);

CREATE TABLE Customer(
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_fname VARCHAR(100) NOT NULL,
    cust_lname VARCHAR(100) NOT NULL,
    cust_ph_num VARCHAR(30),
    cust_address VARCHAR(250) NOT NULL, 
    cust_email VARCHAR(100) NOT NULL
);

CREATE TABLE Payment(
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    pymt_method VARCHAR(30) NOT NULL,
    pymt_date DATE NOT NULL,
    pymt_status VARCHAR(50) NOT NULL DEFAUL 'Pending', --Payment remain pending until processed 
    pymt_trans_ref VARCHAR(100) NOT NULL,
    pymt_amt DECIMAL(10,2) NOT NULL,
    invoice_id INT NOT NULL,
    FOREIGN KEY(invoice_id) REFERENCES Invoice(invoice_id)
);

--6 main leagues Only put MLS IDK why 
INSERT INTO League VALUES ('Premier League','England',2024,'Barclays',1);
INSERT INTO League VALUES ('La Liga','Spain',2024,'EA Sports',1);
INSERT INTO League VALUES ('Serie A','Italy',2024,'Enilive',1);
INSERT INTO League VALUES ('Bundesliga','Germany',2024,'Amazon Web Services',1);
INSERT INTO League VALUES ('Ligue 1','France',2024,'McDonald',1);
INSERT INTO League VALUES ('MLS','USA',2024,'Apple',1);


--20 real world data for teams 
INSERT INTO Team VALUES (1,'Arsenal','England',1886);
INSERT INTO Team VALUES (1,'Chelsea','England',1905);
INSERT INTO Team VALUES (1,'Liverpool','England',1892);
INSERT INTO Team VALUES (1,'Manchester City','England',1880);
INSERT INTO Team VALUES (1,'Manchester United','England',1878); 
INSERT INTO Team VALUES (1,'Tottenham Hotspur','England',1882); --NOT A BIG 6 ANYMORE
INSERT INTO Team VALUES (2,'Real Madrid','Spain',1902);
INSERT INTO Team VALUES (2,'FC Barcelona','Spain',1899);
INSERT INTO Team VALUES (2,'Atletico Madrid','Spain',1903);
INSERT INTO Team VALUES (3,'Juventus','Italy',1897);
INSERT INTO Team VALUES (3,'AC Milan','Italy',1899);
INSERT INTO Team VALUES (3,'Inter Milan','Italy',1908);
INSERT INTO Team VALUES (4,'Bayern Munich','Germany',1900);
INSERT INTO Team VALUES (4,'Borussia Dortmund','Germany',1909);
INSERT INTO Team VALUES (4,'Bayer Leverkusen','Germany',1904);
INSERT INTO Team VALUES (5,'Paris Saint-Germain','France',1970);
INSERT INTO Team VALUES (5,'Olympique de Marseille','France',1899);
INSERT INTO Team VALUES (6,'Inter Miami CF','USA',2018);
INSERT INTO Team VALUES (6,'LA Galaxy','USA',1996);
INSERT INTO Team VALUES (6,'Atlanta United FC','USA',2014);
--20 real world data for VENDORS
INSERT INTO VENDOR VALUES ('Nike Inc.','orders@nike.com','+1-503-671-6453','USA','One Bowerman Drive, Beaverton, OR');
INSERT INTO VENDOR VALUES ('Adidas AG','b2b@adidas.com','+49-9132-84-0','Germany','Adi-Dassler-Strasse 1, Herzogenaurach');
INSERT INTO VENDOR VALUES ('Puma SE','wholesale@puma.com','+49-9132-81-0','Germany','PUMA Way 1, Herzogenaurach');
INSERT INTO VENDOR VALUES ('New Balance','sales@newbalance.com','+1-617-783-4000','USA','100 Guest Street, Brighton, MA');
INSERT INTO VENDOR VALUES ('Umbro','trade@umbro.com','+44-161-834-6700','UK','Umbro House, Manchester');
INSERT INTO VENDOR VALUES ('Macron Sport','info@macron.com','+39-051-608-5311','Italy','Via Rosselli 90, Valsamoggia');
INSERT INTO VENDOR VALUES ('Kappa','sales@kappa.com','+39-011-822-7111','Italy','Via Germagnano 30, Turin');
INSERT INTO VENDOR VALUES ('Hummel','info@hummel.net','+45-96-172100','Denmark','Ane Staunings Vej 15, Ikast');
INSERT INTO VENDOR VALUES ('Castore','trade@castore.com','+44-151-909-3800','UK','The Plaza, Liverpool');
INSERT INTO VENDOR VALUES ('Under Armour','wholesale@underarmour.com','+1-410-454-6428','USA','1020 Hull Street, Baltimore, MD');
INSERT INTO VENDOR VALUES ('Authentic XI Direct','stock@authenticxi.com','+1-813-555-0101','USA','123 Kit Lane, Tampa, FL');
INSERT INTO VENDOR VALUES ('Euro Kit Imports','buy@eurokitimports.com','+1-305-555-0202','USA','456 Merch Blvd, Miami, FL');
INSERT INTO VENDOR VALUES ('Sport Direct','trade@sportdirect.com','+44-845-129-9100','UK','Brook Park East, Shirebrook');
INSERT INTO VENDOR VALUES ('Pro Direct Soccer','trade@prodirectsoccer.com','+44-1392-456789','UK','Marsh Barton, Exeter');
INSERT INTO VENDOR VALUES ('Soccer.com','orders@soccer.com','+1-800-950-3611','USA','431 US Hwy 70A, Hillsborough, NC');
INSERT INTO VENDOR VALUES ('Subside Sports','info@subsidesports.com','+31-543-479700','Netherlands','Haaksbergerveen 55, Haaksbergen');
INSERT INTO VENDOR VALUES ('Classic Football Shirts','info@classicfootballshirts.co.uk','+44-161-888-2500','UK','Manchester');
INSERT INTO VENDOR VALUES ('Kit Heritage','sales@kitheritagestore.com','+1-212-555-0303','USA','789 Heritage Ave, New York, NY');
INSERT INTO VENDOR VALUES ('Retro Football Kits','orders@retrofootballkits.com','+44-20-7946-0404','UK','London, UK');
INSERT INTO VENDOR VALUES ('World Soccer Shop','service@worldsoccershop.com','+1-877-417-7625','USA','Atlanta, GA');
--Sales channel 
INSERT INTO Sales_Channel VALUES ('Authentic XI','Southeast','Active','2020-01-15');
INSERT INTO Sales_Channel VALUES ('Authentic XI','Midwest','Active','2021-06-01');
INSERT INTO Sales_Channel VALUES ('Authentic XI','Norteast','Active','2020-03-10');
INSERT INTO Sales_Channel VALUES ('Authentic XI','Southwest','Active','2020-05-22');
INSERT INTO Sales_Channel VALUES ('Authentic XI','Southeast','Active','2022-09-01');
INSERT INTO Sales_Channel VALUES ('Authentic XI','Midwest','Inactive','2021-01-01');
INSERT INTO Sales_Channel VALUES ('Authentic XI','Southeast','Inactive','2023-07-04');
INSERT INTO Sales_Channel VALUES ('Authentic XI','Northwest','Active','2023-11-15');
--20 real world data for customers
INSERT INTO Customer VALUES ('James','Martinez','813-555-0101','101 Oak St, Tampa, FL 33601','james.martinez@email.com');
INSERT INTO Customer VALUES ('Sofia','Johnson','305-555-0202','220 Palm Ave, Miami, FL 33101','sofia.johnson@email.com');
INSERT INTO Customer VALUES ('Liam','Thompson','212-555-0303','55 Broadway, New York, NY 10006','liam.thompson@email.com');
INSERT INTO Customer VALUES ('Emma','Garcia','323-555-0404','876 Sunset Blvd, Los Angeles, CA 90028','emma.garcia@email.com');
INSERT INTO Customer VALUES ('Noah','Williams','312-555-0505','433 Michigan Ave, Chicago, IL 60601','noah.williams@email.com');
INSERT INTO Customer VALUES ('Olivia','Brown','404-555-0606','789 Peachtree St, Atlanta, GA 30308','olivia.brown@email.com');
INSERT INTO Customer VALUES ('Ethan','Davis','617-555-0707','12 Commonwealth Ave, Boston, MA 02215','ethan.davis@email.com'); 
INSERT INTO Customer VALUES ('Ava','Wilson','206-555-0808','301 Pike St, Seattle, WA 98101','ava.wilson@email.com');
INSERT INTO Customer VALUES ('Mason','Taylor','602-555-0909','500 N Central Ave, Phoenix, AZ 85004','mason.taylor@email.com');
INSERT INTO Customer VALUES ('Isabella','Anderson','832-555-1010','123 Main St, Houston, TX 77002','isabella.anderson@email.com');
INSERT INTO Customer VALUES ('Lucas','Thomas','720-555-1111','400 16th St, Denver, CO 80202','lucas.thomas@email.com');
INSERT INTO Customer VALUES ('Mia','Jackson','415-555-1212','1 Market St, San Francisco, CA 94105','mia.jackson@email.com');
INSERT INTO Customer VALUES ('Aiden','White','503-555-1313','200 SW Broadway, Portland, OR 97201','aiden.white@email.com');
INSERT INTO Customer VALUES ('Charlotte','Harris','702-555-1414','3700 Las Vegas Blvd, Las Vegas, NV 89109','charlotte.harris@email.com');
INSERT INTO Customer VALUES ('Jackson','Martin','919-555-1515','100 Fayetteville St, Raleigh, NC 27601','jackson.martin@email.com');
INSERT INTO Customer VALUES ('Amelia','Thompson','214-555-1616','1500 Marilla St, Dallas, TX 75201','amelia.thompson@email.com');
INSERT INTO Customer VALUES ('Logan','Moore','813-555-1717','4801 E Fowler Ave, Tampa, FL 33617','logan.moore@email.com');
INSERT INTO Customer VALUES ('Harper','Clark','305-555-1818','600 Brickell Ave, Miami, FL 33131','harper.clark@email.com');
INSERT INTO Customer VALUES ('Elijah','Rodriguez','407-555-1919','400 S Orange Ave, Orlando, FL 32801','elijah.rodriguez@email.com');
INSERT INTO Customer VALUES ('Abigail','Lewis','954-555-2020','1 E Broward Blvd, Fort Lauderdale, FL 33301','abigail.lewis@email.com');
--20 REAL WORLD DATA FOR PRODUCT
INSERT INTO Product VALUES (1,'Arsenal Home Jersey 2024/25',89.99,'Adidas','2024/25','Jersey');
INSERT INTO Product VALUES (2,'Chelsea Away Jersey 2024/25',84.99,'Nike','2024/25','Jersey');
INSERT INTO Product VALUES (3,'Liverpool Home Jersey 2024/25',89.99,'Nike','2024/25','Jersey'),
INSERT INTO Product VALUES (4,'Manchester City Home Jersey 2024/25',89.99,'Puma','2024/25','Jersey');
INSERT INTO Product VALUES (5,'Manchester United Home Jersey 2024/25',89.99,'Adidas','2024/25','Jersey');
INSERT INTO Product VALUES (7,'FC Barcelona Home Jersey 2024/25',94.99,'Nike','2024/25','Jersey');
INSERT INTO Product VALUES (8,'Real Madrid Home Jersey 2024/25',94.99,'Adidas','2024/25','Jersey');
INSERT INTO Product VALUES (13,'Bayern Munich Home Jersey 2024/25',89.99,'Adidas','2024/25','Jersey');
INSERT INTO Product VALUES (16,'PSG Home Jersey 2024/25',94.99,'Nike','2024/25','Jersey');
INSERT INTO Product VALUES (3,'Liverpool Retro 1989 Home Jersey',74.99,'Adidas','1989/90','Jersey');
INSERT INTO Product VALUES (1,'Nike Mercurial Vapor 15 - FG',229.99,'Nike','2024/25','Footwear');
INSERT INTO Product VALUES (8,'Adidas Predator 30 - AG',199.99,'Adidas','2024/25','Footwear');
INSERT INTO Product VALUES (4,'Puma Future 7 - FG',179.99,'Puma','2024/25','Footwear');
INSERT INTO Product VALUES (7,'Nike Phantom GX 2 - IC',219.99,'Nike','2024/25','Footwear');
INSERT INTO Product VALUES (13,'Adidas Copa Pure 2 - FG',159.99,'Adidas','2024/25','Footwear');
INSERT INTO Product VALUES (3,'Liverpool FC Scarf 2024/25',24.99,'Adidas','2024/25','Accessories');
INSERT INTO Product VALUES (8,'Real Madrid Club Beanie',19.99,'Adidas','2024/25','Accessories');
INSERT INTO Product VALUES (1,'Arsenal FC Knit Scarf',22.99,'Adidas','2024/25','Accessories');
INSERT INTO Product VALUES (16,'PSG Training Socks 3-Pack',18.99,'Nike','2024/25','Accessories');
INSERT INTO Product VALUES (5,'Manchester United Mini Pennant',14.99,'Adidas','2024/25','Accessories');
--Values into Jersey
INSERT INTO Jersey VALUES (1,'L','Gyokores','Home');
INSERT INTO Jersey VALUES (2,'M','Messi','Away');
INSERT INTO Jersey VALUES (3,'XL','Salah','Home');
INSERT INTO Jersey VALUES (4,'L','Haaland','Home');
INSERT INTO Jersey VALUES (5,'M','Fernandes','Home');
INSERT INTO Jersey VALUES (6,'L','Yamal','Home');
INSERT INTO Jersey VALUES (7,'XL','Mbappe','Home');
INSERT INTO Jersey VALUES (8,'M','Kane','Home');
INSERT INTO Jersey VALUES (9,'L','Dembele','Home');
INSERT INTO Jersey VALUES (10,'M','Ronaldo','Home');
--Values into Footwear
INSERT INTO Footwear VALUES (11,'10','FG','Black/Red');
INSERT INTO Footwear VALUES (12,'9','AG','Black/White');
INSERT INTO Footwear VALUES (13,'11','FG','Blue/Yellow');
INSERT INTO Footwear VALUES (14,'10','IC','Black/Purple');
INSERT INTO Footwear VALUES (15,'9.5','FG','White/Black');
--Values into Accessories
INSERT INTO Accessories VALUES (16,'Scarf','Woven jacquard club scarf','One Size');
INSERT INTO Accessories VALUES (17,'Beanie','Knit pom pom club beanie','One Size');
INSERT INTO Accessories VALUES (18,'Scarf','Knit club scarf with fringe ends','One Size');
INSERT INTO Accessories VALUES (19,'Socks','Cushioned training crew socks','M/L');
INSERT INTO Accessories VALUES (20,'Pennant','Mini felt pennant wall decor','12 inch');

--20 real world data into Inventory 
INSERT INTO Inventory VALUES (1,142,'2024-08-01','Warehouse A - Shelf 1');
INSERT INTO Inventory VALUES (2,98,'2024-08-01','Warehouse A - Shelf 2');
INSERT INTO Inventory VALUES (3,215,'2024-08-01','Warehouse A - Shelf 3');
INSERT INTO Inventory VALUES (4,176,'2024-08-01','Warehouse A - Shelf 4');
INSERT INTO Inventory VALUES (5,203,'2024-08-01','Warehouse A - Shelf 5');
INSERT INTO Inventory VALUES (6,189,'2024-08-01','Warehouse B - Shelf 1');
INSERT INTO Inventory VALUES (7,221,'2024-08-01','Warehouse B - Shelf 2');
INSERT INTO Inventory VALUES (8,167,'2024-08-01','Warehouse B - Shelf 3');
INSERT INTO Inventory VALUES (9,134,'2024-08-01','Warehouse B - Shelf 4');
INSERT INTO Inventory VALUES (10,45,'2024-08-01','Warehouse C - Shelf 1');
INSERT INTO Inventory VALUES (11,62,'2024-08-01','Warehouse C - Shelf 2');
INSERT INTO Inventory VALUES (12,58,'2024-08-01','Warehouse C - Shelf 3');
INSERT INTO Inventory VALUES (13,71,'2024-08-01','Warehouse C - Shelf 4');
INSERT INTO Inventory VALUES (14,44,'2024-08-01','Warehouse C - Shelf 5');
INSERT INTO Inventory VALUES (15,53,'2024-08-01','Warehouse C - Shelf 6');
INSERT INTO Inventory VALUES (16,310,'2024-08-01','Warehouse D - Shelf 1');
INSERT INTO Inventory VALUES (17,287,'2024-08-01','Warehouse D - Shelf 2');
INSERT INTO Inventory VALUES (18,265,'2024-08-01','Warehouse D - Shelf 3');
INSERT INTO Inventory VALUES (19,341,'2024-08-01','Warehouse D - Shelf 4');
INSERT INTO Inventory VALUES (20,198,'2024-08-01','Warehouse D - Shelf 5');

--20 real world data into product vendor 
INSERT INTO Product_Vendor VALUES (2,1,54.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (1,2,51.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (1,3,54.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (3,4,54.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (2,5,54.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (1,6,57.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (2,7,57.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (2,8,54.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (1,9,57.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (17,10,40.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (1,11,138.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (2,12,120.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (3,13,108.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (1,14,132.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (2,15,96.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (11,16,9.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (2,17,8.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (2,18,9.0,'2024-07-01');
INSERT INTO Product_Vendor VALUES (1,19,7.5,'2024-07-01');
INSERT INTO Product_Vendor VALUES (11,20,5.0,'2024-07-01');

--20 real world data into payment 
INSERT INTO Payment VALUES ('Credit Card','2024-01-10 10:15:00','Completed','TXN-AX-000001',179.98);
INSERT INTO Payment VALUES ('PayPal','2024-01-12 14:30:00','Completed','TXN-AX-000002',89.99);
INSERT INTO Payment VALUES ('Debit Card','2024-01-15 09:00:00','Completed','TXN-AX-000003',229.99);
INSERT INTO Payment VALUES ('Credit Card','2024-01-20 16:45:00','Completed','TXN-AX-000004',114.98);
INSERT INTO Payment VALUES ('Apple Pay','2024-02-01 11:20:00','Completed','TXN-AX-000005',94.99);
INSERT INTO Payment VALUES ('Credit Card','2024-02-05 13:00:00','Completed','TXN-AX-000006',199.99);
INSERT INTO Payment VALUES ('PayPal','2024-02-10 08:30:00','Completed','TXN-AX-000007',108.98);
INSERT INTO Payment VALUES ('Debit Card','2024-02-14 17:15:00','Completed','TXN-AX-000008',89.99);
INSERT INTO Payment VALUES ('Google Pay','2024-02-20 12:00:00','Completed','TXN-AX-000009',219.99);
INSERT INTO Payment VALUES ('Credit Card','2024-03-01 10:45:00','Completed','TXN-AX-000010',179.98);
INSERT INTO Payment VALUES ('Credit Card','2024-03-05 15:30:00','Completed','TXN-AX-000011',74.99);
INSERT INTO Payment VALUES ('PayPal','2024-03-10 09:15:00','Completed','TXN-AX-000012',247.98);
INSERT INTO Payment VALUES ('Apple Pay','2024-03-15 14:00:00','Completed','TXN-AX-000013',94.99);
INSERT INTO Payment VALUES ('Debit Card','2024-03-20 11:30:00','Completed','TXN-AX-000014',159.99);
INSERT INTO Payment VALUES ('Credit Card','2024-03-25 16:00:00','Completed','TXN-AX-000015',44.98);
INSERT INTO Payment VALUES ('Google Pay','2024-04-01 10:00:00','Completed','TXN-AX-000016',89.99);
INSERT INTO Payment VALUES ('Credit Card','2024-04-05 13:45:00','Completed','TXN-AX-000017',179.98);
INSERT INTO Payment VALUES ('PayPal','2024-04-10 08:15:00','Completed','TXN-AX-000018',94.99);
INSERT INTO Payment VALUES ('Debit Card','2024-04-15 15:00:00','Completed','TXN-AX-000019',229.99);
INSERT INTO Payment VALUES ('Apple Pay','2024-04-20 12:30:00','Completed','TXN-AX-000020',109.98);

--20 real world data into Invoice
INSERT INTO Invoice VALUES (1,1,'2024-01-10 10:14:00','Delivered');
INSERT INTO Invoice VALUES (2,2,'2024-01-12 14:29:00','Delivered');
INSERT INTO Invoice VALUES (3,3,'2024-01-15 08:59:00','Delivered');
INSERT INTO Invoice VALUES (4,4,'2024-01-20 16:44:00','Delivered');
INSERT INTO Invoice VALUES (5,5,'2024-02-01 11:19:00','Delivered');
INSERT INTO Invoice VALUES (6,6,'2024-02-05 12:59:00','Delivered');
INSERT INTO Invoice VALUES (7,7,'2024-02-10 08:29:00','Delivered');
INSERT INTO Invoice VALUES (8,8,'2024-02-14 17:14:00','Delivered');
INSERT INTO Invoice VALUES (9,9,'2024-02-20 11:59:00','Delivered');
INSERT INTO Invoice VALUES (10,10,'2024-03-01 10:44:00','Delivered');
INSERT INTO Invoice VALUES (11,11,'2024-03-05 15:29:00','Delivered');
INSERT INTO Invoice VALUES (12,12,'2024-03-10 09:14:00','Delivered');
INSERT INTO Invoice VALUES (13,13,'2024-03-15 13:59:00','Delivered');
INSERT INTO Invoice VALUES (14,14,'2024-03-20 11:29:00','Delivered');
INSERT INTO Invoice VALUES (15,15,'2024-03-25 15:59:00','Delivered');
INSERT INTO Invoice VALUES (16,16,'2024-04-01 09:59:00','Delivered');
INSERT INTO Invoice VALUES (17,17,'2024-04-05 13:44:00','Shipped');
INSERT INTO Invoice VALUES (18,18,'2024-04-10 08:14:00','Processing');
INSERT INTO Invoice VALUES (19,19,'2024-04-15 14:59:00','Processing');
INSERT INTO Invoice VALUES (20,20,'2024-04-20 12:29:00','Pending');

--20 real world invoice_item data
INSERT INTO Invoice_item VALUES (1,1,2,89.99);
INSERT INTO Invoice_item VALUES (2,3,1,89.99);
INSERT INTO Invoice_item VALUES (3,11,1,229.99);
INSERT INTO Invoice_item VALUES (4,2,1,84.99);
INSERT INTO Invoice_item VALUES (4,16,1,24.99);
INSERT INTO Invoice_item VALUES (5,6,1,94.99);
INSERT INTO Invoice_item VALUES (6,12,1,199.99);
INSERT INTO Invoice_item VALUES (7,4,1,89.99);
INSERT INTO Invoice_item VALUES (7,19,1,18.99);
INSERT INTO Invoice_item VALUES (8,5,1,89.99);
INSERT INTO Invoice_item VALUES (9,14,1,219.99);
INSERT INTO Invoice_item VALUES (10,7,2,89.99);
INSERT INTO Invoice_item VALUES (11,10,1,74.99);
INSERT INTO Invoice_item VALUES (12,8,1,89.99);
INSERT INTO Invoice_item VALUES (12,9,1,94.99);
INSERT INTO Invoice_item VALUES (12,18,1,22.99);
INSERT INTO Invoice_item VALUES (13,6,1,94.99);
INSERT INTO Invoice_item VALUES (14,15,1,159.99);
INSERT INTO Invoice_item VALUES (15,17,1,19.99);
INSERT INTO Invoice_item VALUES (15,20,1,14.99);

--20 real world data for Shipment 
INSERT INTO Shipment VALUES (1,'101 Oak St, Tampa, FL 33601','2024-01-12','UPS','Delivered');
INSERT INTO Shipment VALUES (2,'220 Palm Ave, Miami, FL 33101','2024-01-14','FedEx','Delivered');
INSERT INTO Shipment VALUES (3,'55 Broadway, New York, NY 10006','2024-01-17','UPS','Delivered');
INSERT INTO Shipment VALUES (4,'876 Sunset Blvd, Los Angeles, CA 90028','2024-01-22','USPS','Delivered');
INSERT INTO Shipment VALUES (5,'433 Michigan Ave, Chicago, IL 60601','2024-02-03','FedEx','Delivered');
INSERT INTO Shipment VALUES (6,'789 Peachtree St, Atlanta, GA 30308','2024-02-07','UPS','Delivered');
INSERT INTO Shipment VALUES (7,'12 Commonwealth Ave, Boston, MA 02215','2024-02-12','FedEx','Delivered');
INSERT INTO Shipment VALUES (8,'301 Pike St, Seattle, WA 98101','2024-02-16','USPS','Delivered');
INSERT INTO Shipment VALUES (9,'500 N Central Ave, Phoenix, AZ 85004','2024-02-22','UPS','Delivered');
INSERT INTO Shipment VALUES (10,'123 Main St, Houston, TX 77002','2024-03-03','FedEx','Delivered');
INSERT INTO Shipment VALUES (11,'400 16th St, Denver, CO 80202','2024-03-07','USPS','Delivered');
INSERT INTO Shipment VALUES (12,'1 Market St, San Francisco, CA 94105','2024-03-12','UPS','Delivered');
INSERT INTO Shipment VALUES (13,'200 SW Broadway, Portland, OR 97201','2024-03-17','FedEx','Delivered');
INSERT INTO Shipment VALUES (14,'3700 Las Vegas Blvd, Las Vegas, NV 89109','2024-03-22','UPS','Delivered');
INSERT INTO Shipment VALUES (15,'100 Fayetteville St, Raleigh, NC 27601','2024-03-27','USPS','Delivered');
INSERT INTO Shipment VALUES (16,'1500 Marilla St, Dallas, TX 75201','2024-04-03','FedEx','Delivered');
INSERT INTO Shipment VALUES (17,'4801 E Fowler Ave, Tampa, FL 33617','2024-04-07','UPS','In Transit');
INSERT INTO Shipment VALUES (18,'600 Brickell Ave, Miami, FL 33131','2024-04-12','FedEx','In Transit');
INSERT INTO Shipment VALUES (19,'400 S Orange Ave, Orlando, FL 32801','2024-07-20','DHL','Pending');
INSERT INTO Shipment VALUES (20,'1 E Broward Blvd, Fort Lauderdale, FL 33301','2024-12-27','DHL','Pending');