-- Created Queries for league, Team, Product and using auto increment for Primary keys for each table 
CREATE TABLE League(
    league_ID INT AUTO_INCREMENT PRIMARY KEY, 
    league_name VARCHAR(50) NOT NULL,
    league_country VARCHAR(50) NOT NULL, 
    league_year YEAR NOT NULL, 
    league_sponsor VARCHAR(50), 
    league_tier INT NOT NULL
);

CREATE TABLE Team(
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    league_id INT NOT NULL,
    team_name VARCHAR(100) NOT NULL,
    team_country VARCHAR(100) NOT NULL,
    team_year SMALLINT,
    FOREIGN KEY (league_id) REFERENCES League(league_ID)
);

CREATE TABLE Product(
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT NOT NULL,
    prod_name VARCHAR(150) NOT NULL,
    prod_price DECIMAL(10,2) NOT NULL,
    prod_brand VARCHAR(100)  NOT NULL,
    prod_season VARCHAR(20),
    prod_type ENUM('Jersey','Footwear','Accessories') NOT NULL,
    FOREIGN KEY (team_id) REFERENCES Team(team_id)
);

CREATE TABLE Jersey(
    product_id INT NOT NULL,
    jsy_size VARCHAR(10) NOT NULL,
    jsy_player_nm VARCHAR(100),
    jsy_type VARCHAR(50) NOT NULL,
    PRIMARY KEY (product_id),
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