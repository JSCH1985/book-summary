DROP TABLE IF EXISTS book_summary;

CREATE TABLE book_summary AS
SELECT
    year AS publication_year,
    COUNT(*) AS book_count,
    ROUND(AVG(CAST(SUBSTRING(price, 2) AS DECIMAL(10, 2))
              * CASE WHEN price LIKE '€%' THEN 1.2 ELSE 1 END), 2) AS average_price
FROM books
GROUP BY year
ORDER BY year;