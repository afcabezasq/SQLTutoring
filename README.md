# SQL

## Persistence of information

Store the information in a reliable media.

## Data Bases

### Relational



## MySql

`\! clear ` Command use to clean the console

`mysql -u root -h 127.0.0.1 -p` Connect to the console 

`show databases;` Show all the databases in the server

`use mydb;` Selct a database to work with

`show tables;` Show all the tables in the database selected

`select database();` See wich database is being used 

`create` Create a table


## Create a database

```SQL
CREATE database operation;
CREATE database if not exists operation;
CREATE TABLE IF NOT EXISTS books(
    `book_id` INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `author_id` INTEGER UNSIGNED,
    `title` VARCHAR(100) NOT NULL,
    `year` INTEGER UNSIGNED NOT NULL DEFAULT 1900,
    `language` VARCHAR(2) NOT NULL DEFAULT 'es' COMMENT 'ISO 639-1 Language',
    `cover_url` VARCHAR(500),
    `price` DOUBLE(6,2) NOT NULL DEFAULT 10.0,
    `sellable` TINYINT(1) DEFAULT 1,
    `copies` INTEGER NOT NULL DEFAULT 1,
    `description` TEXT 
);
CREATE TABLE IF NOT EXISTS authors (
    `author_id` INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `nationality` VARCHAR(3)
);
```

## Show warnings
`show warnings;` Show current warnings

## Drop a table
`drop table <name of table>` There is no turning back point after execute a drop table

## Describe a table
Describe an specific table, with all it's attributes
*   `describe <table name>`

*   `desc <table name>`

## Show full table with comments
*   `show full columns from <table name>`

## Create clients table

```sql
CREATE TABLE IF NOT EXISTS clients(
    client_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    birthdate DATETIME,
    gender ENUM('M','F','ND') NOT NULL,
    active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
    ON UPDATE CURRENT_TIMESTAMP
);
```

## Create transactions table

```sql
CREATE TABLE `transactions`(
    `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `book_id` int(10) unsigned NOT NULL,
    `client_id` int(10) unsigned NOT NULL,
    `type` enum('lend','sell') NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `finished` TINYINT(1) NOT NULL DEFAULT '0',
    PRIMARY KEY (`transaction_id`)
);
```

## Insert command

`INSERT INTO <table name>()` 

### Insert into authors table

```sql
INSERT INTO authors(author_id, `name`, nationality)
VALUES(NULL,'Juan Rulfo','MEX');

INSERT INTO authors( `name`, nationality)
VALUES('Gabriel Garcia Marquez', 'COL');

INSERT INTO authors
VALUES(NULL,'Juan Gabriel Vasquez','COL');

INSERT INTO authors(`name`, `nationality`)
VALUES('Julio Cortazar', 'ARG'),
    ('Isabel Allende','CHI'),
    ('Octavio Paz', 'MEX'),
    ('Juan Carlos Onetti', 'URU');
```

### Get all elements of a table

```sql
select * from authors;
select * from clients;
```
### Insert elements in clients table

```sql
INSERT INTO `clients` (client_id, name, email, birthdate,gender, active, created_at)
VALUES 
(1,'Maria Dolores Gomez','Maria Dolores.95983222J@random.names','1971-06-06','F',1,'2018-04-09 16:51:30'),
(2,'Adrian Fernandez','Adrian.55818851J@random.names','1970-04-09','M',1,'2018-04-09 16:51:30'),
(3,'Maria Luisa Marin','Maria Luisa.83726282A@random.names','1957-07-30','F',1,'2018-04-09 16:51:30'),
(4,'Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',1,'2018-04-09 16:51:30');
```

### On Duplicate 

```sql
INSERT INTO `clients`(name,email,birthdate,gender,active)
VALUES ('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',0)
ON DUPLICATE KEY UPDATE active = VALUES(active);
```

### See the query in another format
```sql
select * from clients where client_id = 4\G;
```

### Nested query

The time cab increase rapidly

```sql
INSERT INTO books(title, author,`year`)
VALUES(
        'Vuelta al Lberinto de la Soledad',
        (SELECT author_id FROM authors
        WHERE `name`= 'Octavio Paz'
        LIMIT 1),
        1960
        );
```

## Run scripts from command line

To run the structure of the database:
```bash
mysql -u root -p < <file>
```

To run the insertion of the data:
```bash
mysql - root -p -D <databse-name> < <file>
```

## Selct command

```sql
SELECT <attributes> FROM <table name>
SELECT `name`, email, gender FROM clients;
SELECT name, email, gender FROM clients LIMIT 10;
SELECT name, email, gender FROM clients WHERE gender = 'F'
```

### Functions

```sql
SELECT YEAR(birthdate) FROM clients;
SELECT NOW();
SELECT name, YEAR(NOW()) - YEAR(birthdate) as Age FROM clients limit 10;
```

### Like command
```sql
SELECT * FROM clients WHERE name like '%Saave';
SELECT name, email, YEAR(NOW()) - YEAR(birthdate) as Age 
FROM clients
WHERE gender = 'F'
    AND name LIKE '%Lop%';
```

## JOIN Command