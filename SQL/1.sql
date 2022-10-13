-- Вариант 1 - с созданием таблицы
USE sber
CREATE TABLE prime(
	number INT
)

-- добавим в таблицу prime числа от 2 до 100
DECLARE @i INT = 2
WHILE @i <= 100
BEGIN
	INSERT INTO prime VALUES (@i)
	SET @i = @i+1
END
SELECT * FROM prime

SELECT number AS Prime FROM prime p WHERE NOT EXISTS(SELECT 1 FROM prime t2 WHERE p.number % t2.number = 0 AND p.number != t2.number) ORDER BY Prime

-- Вариант 2 - без создания таблицы
WITH test AS
(
    SELECT 2 AS Prime
    UNION ALL
    SELECT p.Prime+1 AS Prime FROM test p WHERE p.Prime < 100
)
SELECT * FROM test p WHERE NOT EXISTS(SELECT 1 FROM test t2 WHERE p.Prime % t2.Prime = 0 AND p.Prime != t2.Prime)