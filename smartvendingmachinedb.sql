CREATE DATABASE IF NOT EXISTS smartvendingmachinedb;

USE smartvendingmachinedb;

CREATE TABLE IF NOT EXISTS users(
 
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  email varchar(255),
  password varchar(255),
  name varchar(255),
  surname varchar(255),
  walletBalance DOUBLE DEFAULT 0,
  type varchar(255) DEFAULT 'user'
 
);

CREATE TABLE if NOT EXISTS machines(
 
  id INTEGER PRIMARY key AUTO_INCREMENT,
  name varchar(255),
  status varchar(255) DEFAULT 'disabled',
  maxCapacity INTEGER DEFAULT 20,
  actualCapacity INTEGER DEFAULT 0,
  occupiedSince DATETIME
 
);
 
CREATE table if not EXISTS products(
 
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name varchar(255),
  price DOUBLE,
  typology varchar(255)
 
);
 
CREATE TABLE if not EXISTS refills(
 
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  techId INTEGER,
  machId INTEGER,
  prod1Id INTEGER,
  prod1Quantity INTEGER,
  prod2Id INTEGER,
  prod2Quantity INTEGER,
  prod3Id INTEGER,
  prod3Quantity INTEGER,
  prod4Id INTEGER,
  prod4Quantity INTEGER,
	
  FOREIGN KEY (techId)  REFERENCES users(id)     ON DELETE SET NULL,
  FOREIGN KEY (machId)  REFERENCES machines(id)  ON DELETE CASCADE,
  FOREIGN KEY (prod1Id) REFERENCES products(id)  ON DELETE SET NULL,
  FOREIGN KEY (prod2Id) REFERENCES products(id)  ON DELETE SET NULL,
  FOREIGN KEY (prod3Id) REFERENCES products(id)  ON DELETE SET NULL,
  FOREIGN KEY (prod4Id) REFERENCES products(id)  ON DELETE SET NULL
 
);
 
CREATE TABLE IF NOT EXISTS purchases(
 
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  date varchar(255),
  cost DOUBLE,
  userId INTEGER,
  productId INTEGER,
  machineId INTEGER,
 
  FOREIGN KEY (userId) REFERENCES users(id)  ON DELETE CASCADE,
  FOREIGN KEY (productId) REFERENCES products(id)  ON DELETE SET NULL,
  FOREIGN KEY (machineId) REFERENCES machines(id) ON DELETE SET NULL
 
);
 
CREATE TABLE IF not EXISTS  movements (
 
  id INTEGER primary key AUTO_INCREMENT,
  userId INTEGER,
  type varchar(255),
  date varchar(255),
  value DOUBLE,
 
  FOREIGN key (userId) REFERENCES users(id)  ON DELETE CASCADE
 
);

#users
INSERT INTO users(email,password,name,surname,type) VALUES('admin@svm.com','96075d3e8b3be10a4cab21816aa805c6e281b5bdebb13af3c11997ac5c1ba54e','admin','admin','admin');
INSERT INTO users(email,password,name,surname,type) VALUES('tech@svm.com','335220b7ccdd0def424a22afbdf33b857567de39f59a114687ed34f9b5523361','tech','tech','tech');

#products
INSERT INTO products(name,price,typology) VALUES('caffe','1','coffe');
INSERT INTO products(name,price,typology) VALUES('caffeA','1','coffe');
INSERT INTO products(name,price,typology) VALUES('caffeB','1','coffe');
INSERT INTO products(name,price,typology) VALUES('coca cola','2','drink');
INSERT INTO products(name,price,typology) VALUES('patatine','1','snack');
INSERT INTO products(name,price,typology) VALUES('acqua','1','water');
INSERT INTO products(name,price,typology) VALUES('cioccolata','1','coffe');
INSERT INTO products(name,price,typology) VALUES('barretta','1','snack');

#machines

INSERT INTO machines(name) VALUES('Macchinetta-A');

#triggers

#DELIMITER &&

#CREATE TRIGGER beforeConnectionToMachine BEFORE UPDATE ON smartvendingmachinedb.machines 
#FOR EACH ROW BEGIN 

	#IF (OLD.occupiedSince IS NOT NULL AND TIMESTAMPDIFF(MINUTE,OLD.occupiedSince,NOW())> 1) 
	#THEN 
    
		#SET NEW.status='free';
		#SET NEW.occupiedSince=null;
        
	#END IF;
#END;
#&&

#DELIMITER ;