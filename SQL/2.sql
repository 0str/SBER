-- создадим таблицы
USE sber
GO

CREATE TABLE documents(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	data NVARCHAR(50)
)

CREATE TABLE documents_changelog(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	document_id INT,
	old_data NVARCHAR(50),
	new_data NVARCHAR(50)
)

-- триггер на добавление новых записей
USE sber
GO
CREATE TRIGGER Docs_INSERT
ON documents
AFTER INSERT
AS
BEGIN
	-- получим добавленные данные из виртуальной таблицы INSERTED.
	INSERT INTO documents_changelog (document_id, new_data)
	SELECT id, data FROM INSERTED
END

-- триггер на удаление данных
USE sber
GO
CREATE TRIGGER Docs_DELETE
ON documents
AFTER DELETE
AS
	-- получим удаленные данные из виртуальной таблицы DELETED.
	INSERT INTO documents_changelog (document_id, old_data)
	SELECT id, data FROM DELETED

-- триггер на обновление данных
USE sber
GO
CREATE TRIGGER Docs_UPDATE
ON documents
AFTER UPDATE
AS
BEGIN
	-- получим новые данные из виртуальной таблицы INSERTED и старые из DELETED.
	INSERT INTO documents_changelog (document_id, old_data, new_data)
	SELECT DELETED.id, DELETED.data, INSERTED.data FROM DELETED
	JOIN INSERTED ON INSERTED.id = DELETED.id
END

-- добавим три записи в таблицу documents и проверим появились ли данные в documents_changelog
INSERT INTO documents VALUES ('Добавление документа 1'),('Добавление документа 2'),('Добавление документа 3')
SELECT * FROM documents
SELECT * FROM documents_changelog

-- удалим вторую запись и изменим первую
DELETE FROM documents WHERE id=2
UPDATE documents SET data = 'Обновление документа 1' WHERE id = 1
SELECT * FROM documents
SELECT * FROM documents_changelog