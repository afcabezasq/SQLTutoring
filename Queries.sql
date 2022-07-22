INSERT INTO authors(author_id, name, nationality)
VALUES(NULL,'Gabriel Garcia Marquez','COL');

INSERT INTO authors(`name`, nationality)
VALUES('J.K. Rowlling', 'ENG');

INSERT INTO authors
VALUES(NULL,'Shakespeare','ENG');


INSER INTO authors(name,nationality)
VALUES(NULL, 'Julio Cortazar','ARG'),
(NULL, 'Isabel Allende','CHI'),
(NULL, 'Octavio Paz','MEX')

USE operation;
SELECT name AS ClientName, email, gender FROM clients;
SELECT name AS ClientName, email, gender FROM clients LIMIT 10;
SELECT name AS ClientName, email, gender FROM clients WHERE gender = 'F';
SELECT * FROM clients WHERE gender = 'F' AND name LIKE '%Maria%';
SELECT * FROM clients WHERE name LIKE '%Ma%';
SELECT * FROM clients WHERE name like '%Saave';


SELECT name, email, YEAR(NOW())-YEAR(birthdate) AS Age 
FROM clients
WHERE gender = 'M' AND name LIKE '%Sanchez%';


SELECT * FROM authors WHERE author_id > 0  and author_id <= 5;
SELECT * FROM books WHERE author_id between 1 and 5;

SELECT b.book_id AS BookNumber, b.author_id Author, a.name AS Name, b.title as Title
FROM books as b
INNER JOIN authors as a
	ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5; 

SELECT c.name, b.title, t.type
FROM transactions as t
JOIN books as b
ON t.book_id = b.book_id 
JOIN clients as c
ON t.client_id = c.client_id;





SELECT c.name, b.title,a.name AS Author , t.type
FROM transactions as t
JOIN books as b
ON t.book_id = b.book_id 
JOIN clients as c
ON t.client_id = c.client_id
JOIN authors as a
ON b.author_id = a.author_id
	WHERE c.gender =  'F' AND t.type ='sell';
;


SELECT c.name, b.title, a.name as BookAuthor, t.type
FROM transactions as t
JOIN books as b
ON t.book_id = b.book_id
JOIN clients as c
ON t.client_id = c.client_id
JOIN authors as a
ON b.author_id = a.author_id
	WHERE c.gender = 'M' AND t.type='lend';





SELECT b.title, a.name, a.nationality
FROM authors as a, books as b
WHERE a.author_id = b.author_id
LIMIT 10;


SELECT b.title, a.name, a.nationality, b.title
FROM books as b
LEFT JOIN authors as a
	ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id DESC; 



SELECT a.author_id, b.title, a.name, a.nationality, b.title, COUNT(b.book_id) as BooksCount
FROM authors as a
LEFT JOIN books as b
	ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id
ORDER BY a.author_id DESC; 



SELECT b.book_id, a.author_id, a.name, b.title
FROM books as b
JOIN authors as a
	ON a.author_id = b.author_id
WHERE b.title LIKE '%Machine Learning%';



Find all books that were written after 1995
Find all authors that were born in United States
Find all authors that wrote a book with the matching character "The"
Find all authors that wrote a book with the matching character "Machine Learning"
Find all books that does not have a description without showing nulls


What natonalities are there?

How many authors are therre for each nationality?


SELECT nationality, COUNT(author_id) as  c_authors
FROM authors
GROUP BY nationality 
ORDER BY c_authors DESC, nationality ASC;




















