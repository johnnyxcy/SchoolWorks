/*
    Chongyi Xu, 1531273
    CSE 154 HW7 Pokedex2
    Section AI
    This sets up my database and Pokedex Table
*/

/* create the database hw7 */
CREATE DATABASE IF NOT EXISTS hw7;
USE hw7;

/* clear up the table */
DROP TABLE IF EXISTS Pokedex;

/* create the table Pokedex*/
CREATE TABLE Pokedex(
    name VARCHAR(30) NOT NULL,
    nickname VARCHAR(30) NOT NULL,
    datefound DATETIME NOT NULL,
    PRIMARY KEY(name)
);