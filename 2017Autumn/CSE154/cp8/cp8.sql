DROP TABLE IF EXISTS Products;
CREATE TABLE Products(
   id          INTEGER  NOT NULL PRIMARY KEY 
  ,price       INTEGER NOT NULL
  ,prod_name   VARCHAR(243) NOT NULL
);
INSERT INTO Products(id, price, prod_name) VALUES (00001, 1499, 'iPhone X');
INSERT INTO Products(id, price, prod_name) VALUES (00002, 2199, 'MacBook Pro');
INSERT INTO Products(id, price, prod_name) VALUES (00003, 3999, 'Surface Book Pro');
INSERT INTO Products(id, price, prod_name) VALUES (00004, 1899, 'Dell Gaming Laptop');
INSERT INTO Products(id, price, prod_name) VALUES (00005, 399, 'Chrome Book');
INSERT INTO Products(id, price, prod_name) VALUES (00006, 699, 'Samsung Galaxy S8');
INSERT INTO Products(id, price, prod_name) VALUES (00007, 899, 'iPhone 8');


SELECT id, prod_name FROM Products WHERE price <= 1000;
SELECT prod_name FROM Products ORDER BY price DESC;