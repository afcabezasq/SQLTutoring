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

### Inner join
```sql
select * from authors where author_id > 0 and author_id <= 5;
select * from books where author_id between 1 and 5;
select book_id, author_id, title from books where author_id between 1 and 5;

SELECT b.book_id, a.author_id, a.name, b.title
FROM books as b
JOIN authors as a
    ON a.author_id = b.author_id
WHERE a.author_id between 1 and 5;

SELECT c.name, b.title,a.name ,t.type
FROM transactions as t
JOIN books as b
ON t.book_id = b.book_id
JOIN clients as c
ON t.client_id = c.client_id
JOIN authors as a
ON b.author_id = a.author_id
WHERE c.gender = 'F' 
    and t.type = 'sell';


SELECT c.name, b.title,a.name ,t.type
FROM transactions as t
JOIN books as b
ON t.book_id = b.book_id
JOIN clients as c
ON t.client_id = c.client_id
JOIN authors as a
ON b.author_id = a.author_id
WHERE c.gender = 'M' 
    and t.type IN ('sell','lend');

```

### Left join


```sql
SELECT b.title, a.name, a.nationality
FROM authors as a, books as b
WHERE a.author_id = b.author_id
LIMIT 10;

SELECT b.title, a.name, a.nationality
FROM books as b 
INNER join authors as a
    ON a.author_id = b.author_id
    LIMIT 10;

SELECT a.author_id, a.name, a.nationality, b.title
FROM authors as a
JOIN books as b
    ON b.author_id = a.author_id
WHERE a.author_id between 1 and 5
ORDER by a.author_id;

SELECT a.author_id, a.name, a.nationality, b.title
FROM authors as a
JOIN books as b
    ON b.author_id = a.author_id
WHERE a.author_id between 1 and 5
ORDER by a.author_id desc;


SELECT a.author_id, a.name, a.nationality, b.title
FROM authors as a
LEFT JOIN books as b
    ON b.author_id = a.author_id
WHERE a.author_id between 1 and 5
ORDER by a.author_id asc;


SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id) AS BooksCount -- comment--
FROM authors as a
LEFT JOIN books as b
    ON b.author_id = a.author_id
WHERE a.author_id between 1 and 5
GROUP BY a.author_id
ORDER BY a.author_id asc;
```


## Join Types

### Inner Join


![inner join](https://www.tutorialrepublic.com/lib/images/inner-join.png "Inner Join").

### Left Join

![Left Join](https://www.tutorialrepublic.com/lib/images/left-join.png "Left Join").

### Right Join

![Left Join](https://www.tutorialrepublic.com/lib/images/right-join.png "Left Join").

### Full Join

![Left Join](https://www.tutorialrepublic.com/lib/images/full-join.png "Left Join").

### Cross Join
![Left Join](https://www.tutorialrepublic.com/lib/images/cross-join.png "Left Join").


### Left Excluding Join

![Left Join](https://static.platzi.com/media/user_upload/BadgesMesa%20de%20trabajo%202%20copia%204-8bed8f2c-6338-491e-b81f-119027ad8a9c.jpg "Left Excluding Join").

```sql
SELECT <columna_1> , <columna_2>,  <columna_3> ... <columna_n>
FROM Tabla_A A
LEFT JOIN Tabla_B B
ON A.pk = B.pk
WHERE B.pk IS NULL
```

### Right Excluding Join


![Left Join](https://static.platzi.com/media/user_upload/BadgesMesa%20de%20trabajo%202%20copia%205-abeea9a6-964f-4b52-b0a5-4f790101695a.jpg "Right Excluding Join").

```sql
SELECT <columna_1> , <columna_2>,  <columna_3> ... <columna_n>
FROM Tabla_A A
RIGHT JOIN Tabla_B B
ON A.pk = B.pk
WHERE A.pk IS NULL
```

### Outer Excluding Join

![Left Join](https://static.platzi.com/media/user_upload/BadgesMesa%20de%20trabajo%202%20copia%206-fa9ef4f5-1475-4e54-8b33-ebbdfb29df29.jpg "Outer Excluding Join"). 

```sql
SELECT <select_list>
FROM Table_A A
FULL OUTER JOIN Table_B B
ON A.Key = B.Key
WHERE A.Key IS NULL OR B.Key IS NULL
```