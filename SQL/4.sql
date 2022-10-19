USE sber

CREATE TABLE ip_addresses(
	id INT IDENTITY(1,1) PRIMARY KEY,
	first NVARCHAR(50),
	last NVARCHAR(50)
)

INSERT INTO [dbo].[ip_addresses]
     VALUES
        ('0.0.0.0','0.0.1.0'),
        ('127.0.0.1','127.0.0.255'),
        ('123.100.45.28','192.68.0.1')

DECLARE @first_ip nvarchar(20), @last_ip nvarchar(20), @ip1 int, @ip2 int, @ip3 int, @ip4 int, @result int
-- SET @first_ip = '0.0.0.0'
-- SET @last_ip  = '0.0.1.0'

SET @first_ip = (SELECT first FROM ip_addressses WHERE id = 1)
SET @last_ip = (SELECT last FROM ip_addressses WHERE id = 1)

-- первая часть ip-адреса
SET @ip1 = (SELECT CAST(PARSENAME(@last_ip, 4) AS int) - CAST(PARSENAME(@first_ip, 4) AS int) AS ip1)
-- вторая часть ip-адреса
SET @ip2 = (SELECT CAST(PARSENAME(@last_ip, 3) AS int) - CAST(PARSENAME(@first_ip, 3) AS int) AS ip2)
-- третья часть ip-адреса
SET @ip3 = (SELECT CAST(PARSENAME(@last_ip, 2) AS int) - CAST(PARSENAME(@first_ip, 2) AS int) AS ip3)
-- четвертая часть ip-адреса
SET @ip4 = (SELECT CAST(PARSENAME(@last_ip, 1) AS int) - CAST(PARSENAME(@first_ip, 1) AS int) AS ip4)

SET @result = @ip1 * POWER(256, 3) + @ip2 * POWER(256, 2) + @ip3 * 256 + @ip4
SELECT @result