USE shop
GO
CREATE TABLE products(
	id INT NOT NULL PRIMARY KEY,
	name NVARCHAR(50) NOT NULL,
	price NUMERIC NOT NULL
)

CREATE TABLE sales(
	id INT NOT NULL PRIMARY KEY,
	date date NOT NULL
)

CREATE TABLE sales_details(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	sale_id INT NOT NULL REFERENCES sales(id),
	product_id INT NOT NULL REFERENCES products(id),
	count INT NOT NULL
)

INSERT INTO [dbo].[products]
           ([id]
           ,[name]
           ,[price])
     VALUES
           (101,'молоко',59.99),
           (245,'хлеб',34.90),
           (366,'яйца',89),
           (484,'помидор',99.90),
           (666,'сок',79.80)

INSERT INTO [dbo].[sales]
           ([id]
           ,[date])
     VALUES
           (311,'2021-01-01'),
           (312,'2021-01-09'),
           (313,'2021-01-21'),
           (314,'2021-02-01'),
           (315,'2021-02-13'),
           (316,'2021-05-02'),
           (317,'2021-05-02'),
           (318,'2021-05-30'),
           (319,'2021-06-03'),
           (320,'2021-06-03'),
           (321,'2021-06-09'),
           (322,'2021-06-16'),
           (323,'2021-08-04'),
           (324,'2021-08-29'),
           (325,'2021-08-30'),
           (326,'2021-10-05'),
           (327,'2021-10-05'),
           (328,'2021-10-08'),
           (329,'2021-10-15'),
           (330,'2021-10-25'),
           (331,'2021-10-27'),
           (332,'2021-12-02'),
           (333,'2021-12-30'),
           (334,'2022-01-04'),
           (335,'2022-01-29'),
           (336,'2022-01-30'),
           (337,'2022-02-05'),
           (338,'2022-02-08'),
           (339,'2022-03-15'),
           (340,'2022-03-25'),
           (341,'2022-03-27'),
           (342,'2022-04-02'),
           (343,'2022-04-30'),
           (344,'2022-05-04'),
           (345,'2022-07-29'),
           (346,'2022-07-30'),
           (347,'2022-09-05'),
           (348,'2022-09-08'),
           (349,'2022-10-05'),
           (350,'2022-10-05')

INSERT INTO [dbo].[sales_details]
           ([sale_id]
           ,[product_id],
           [count])
     VALUES
           (311,101,1),
           (312,245,2),
           (313,366,3),
           (314,484,4),
           (315,666,5),
           (316,245,3),
           (317,101,1),
           (318,245,10),
           (319,101,1),
           (320,484,2),
           (321,245,6),
           (322,366,1),
           (323,245,11),
           (324,101,1),
           (325,484,3),
           (326,245,7),
           (327,245,1),
           (328,366,3),
           (329,666,1),
           (330,101,2),
           (331,484,1),
           (332,101,3),
           (333,245,1),
           (334,101,4),
           (335,245,1),
           (336,101,13),
           (337,245,1),
           (338,666,2),
           (339,101,1),
           (340,245,3),
           (341,101,1),
           (342,366,1),
           (343,245,5),
           (344,666,1),
           (345,484,6),
           (346,101,1),
           (347,245,3),
           (348,101,1),
           (349,245,2),
           (350,366,1)