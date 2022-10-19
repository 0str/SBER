USE [credit]
GO

-- проверяем существуют ли временные таблицы. если есть, то удаляем
IF OBJECT_ID(N'tempdb..#Temp1') IS NOT NULL
BEGIN
    DROP TABLE #Temp1
END
IF OBJECT_ID(N'tempdb..#Temp2') IS NOT NULL
BEGIN
    DROP TABLE #Temp2
END

-- таблица для временного хранения разбития full_name на два столбца из таблицы prospects
CREATE TABLE #Temp1
    (id INT IDENTITY,
    part_one NVARCHAR(50),
    part_two  NVARCHAR(50),
    lim  float
)

-- таблица для временного хранения промежуточных результатов
CREATE TABLE #Temp2
    (id INT IDENTITY,
	row_numb INT,
    first_name NVARCHAR(50),
    last_name  NVARCHAR(50),
    old_limit  float,
    new_limit  float
)

-- разбить full_name на два столбца
INSERT INTO #Temp1 (part_one,part_two,lim)
SELECT
    CASE
    WHEN full_name LIKE '% %'
        THEN LEFT(full_name, Charindex(' ', full_name) - 1)
        ELSE full_name
    END,
    CASE
    WHEN full_name LIKE '% %'
        THEN RIGHT(full_name, Charindex(' ', Reverse(full_name)) - 1)
    END,
	credit_limit
FROM prospects
ORDER BY credit_limit DESC

-- таблица для хранения промежуточных результатов
INSERT INTO #Temp2 (row_numb,first_name, last_name, old_limit,new_limit)
SELECT
    -- кол-во строк, где повторяются имя и фамилия
    ROW_NUMBER() OVER(PARTITION BY t1.first_name,t1.last_name ORDER BY t2.lim DESC),
    t1.first_name, t1.last_name, t1.credit_limit AS old_limit, t2.lim AS new_limit
FROM customers t1
JOIN #Temp1 t2
-- сравниванием по двум столбцам для поиска записей об одном человеке
ON (t1.first_name = t2.part_one OR t1.first_name = t2.part_two) AND (t1.last_name = t2.part_one OR t1.last_name = t2.part_two)
WHERE t2.lim > t1.credit_limit

-- итоговый вывод
SELECT first_name, last_name, old_limit, new_limit
FROM #Temp2
WHERE row_numb = 1
ORDER BY first_name