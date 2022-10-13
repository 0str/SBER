-- проверяем существует ли временная таблица #Temp, необходимая для хранения промежуточных результатов. если существует, то удаляем
IF OBJECT_ID(N'tempdb..#Temp') IS NOT NULL
BEGIN
    DROP TABLE #Temp
END

-- создаем временную таблицу #Temp
CREATE TABLE #Temp
(
  product_name NVARCHAR(50),
  year INT,
  month INT,
  day INT,
  total Numeric
)

-- объявляем переменные month, year и p_name
DECLARE @month INT, @year INT, @p_name NVARCHAR(50)
-- указываем название продукта, для которого хотим увидеть статистику
SET @p_name = 'молоко'
-- находим самый ранний год
SELECT @year = MIN(DATEPART(yyyy,sales.date)) FROM sales
-- находим самый ранний месяц
SELECT @month = MIN(DATEPART(mm,sales.date)) FROM sales WHERE DATEPART(yyyy,sales.date) = @year

-- пока меньше или равно текущего года
WHILE @year <= YEAR(getdate())
BEGIN

    WHILE @month<=12
    BEGIN
        -- добавить данные во временную таблицу Temp
        INSERT INTO #Temp (product_name,year,month,day,total)
        -- выборка по каждому дню
        SELECT products.name, DATEPART(yyyy,sales.date),DATEPART(mm,sales.date),DATEPART(dd,sales.date), products.price * sales_details.count
        FROM sales_details
        JOIN products ON products.id = sales_details.product_id
        JOIN sales ON sales.id = sales_details.sale_id
        WHERE DATEPART(mm,sales.date)=@month AND DATEPART(yyyy,sales.date)=@year AND products.name = @p_name

        -- выборка по каждому месяцу
        INSERT INTO #Temp (product_name,year,month,total)
        SELECT products.name, DATEPART(yyyy,sales.date),DATEPART(mm,sales.date), SUM(products.price * sales_details.count)
        FROM sales_details
        JOIN products ON products.id = sales_details.product_id
        JOIN sales ON sales.id = sales_details.sale_id
        WHERE DATEPART(mm,sales.date)=@month AND DATEPART(yyyy,sales.date)=@year AND products.name = @p_name
        GROUP BY products.name,DATEPART(yyyy,sales.date),DATEPART(mm,sales.date)

        SET @month = @month + 1
    END
    -- выборка по каждому году
    INSERT INTO #Temp (product_name,year,total)
    SELECT products.name, DATEPART(yyyy,sales.date), SUM(products.price * sales_details.count)
    FROM sales_details
    JOIN products ON products.id = sales_details.product_id
    JOIN sales ON sales.id = sales_details.sale_id
    WHERE DATEPART(yyyy,sales.date)=@year AND products.name = @p_name
    GROUP BY products.name,DATEPART(yyyy,sales.date)

    SET @year = @year + 1
    SET @month = 1
END

-- вывод итоговых результатов
SELECT * FROM #Temp