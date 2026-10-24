DROP TABLE IF EXISTS books;

CREATE TABLE books (
    id BIGINT UNSIGNED PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    genre VARCHAR(100),
    publisher VARCHAR(255),
    year INT,
    price VARCHAR(10)
);

LOAD DATA LOCAL INFILE 'task1_d.json'
INTO TABLE books
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ', :'
LINES STARTING BY '{' TERMINATED BY '}'
(@id, @title, @author, @genre, @publisher, @year, @price)
SET
    id = SUBSTRING_INDEX(@id, '=>', -1),
    title = TRIM(BOTH '"' FROM SUBSTRING_INDEX(@title, '=>', -1)),
    author = TRIM(BOTH '"' FROM SUBSTRING_INDEX(@author, '=>', -1)),
    genre = TRIM(BOTH '"' FROM SUBSTRING_INDEX(@genre, '=>', -1)),
    publisher = TRIM(BOTH '"' FROM SUBSTRING_INDEX(@publisher, '=>', -1)),
    year = SUBSTRING_INDEX(@year, '=>', -1),
    price = TRIM(BOTH '"' FROM SUBSTRING_INDEX(@price, '=>', -1));

source summary.sql

SELECT 'books' AS table_name, COUNT(*) AS row_count FROM books
UNION ALL
SELECT 'book_summary', COUNT(*) FROM book_summary;