# Find table
sp_ScriptRows is SQL procedure that helps you create SQL Insert statements for the existing records from your tables. For example, if you have some data in some table that you want to be copied and inserted into another table using SQL statements this procedure will create the SQL statements for you.

# Parametars
| Parametar | Description |
| ------ | ------ |
| @table | The name of the table that should be scripted. |
| @where | [Optional] The Where condition. |
| @order | [Optional] The Order clause. |
| @top   | [Optional] If you want to select only few records. |
| @dest_table | [Optional] If you want your values to be stored in table.|



# Output
	Text with the details.

# Example 1

```sh
Exec sp_ScriptRows 'SampleTable'
```
SET QUOTED_IDENTIFIER OFF
GO
INSERT INTO SampleTable
([VarcharColumn1],[VarcharColumn2],[VarcharColumn3],[BigintColumn1],[BigintColumn2],[BigintColumn3],[DateTimeColumn1],[DateTimeColumn2],[DateTimeColumn3])
VALUES
("F09F5F2C-8012-438C-9E95-BB09FE7E37EB","2D07C1C2-AC32-42DB-BBF9-498A7AA384D7","6E7653DB-200C-4977-A7CC-FCFE6CF16865","1111111","222222","333333","Jul 25 2017  1:56PM","Jul 25 2017  1:56PM","Jul 25 2017  1:56PM")
GO
INSERT INTO SampleTable
([VarcharColumn1],[VarcharColumn2],[VarcharColumn3],[BigintColumn1],[BigintColumn2],[BigintColumn3],[DateTimeColumn1],[DateTimeColumn2],[DateTimeColumn3])
VALUES
("2ECC3488-A2D5-424A-8786-C3D8B2B51E07","6D660ABD-5D19-4C5C-BA45-7B4328F7A4CC","90C057E3-1D58-4C30-8D96-61F8938538B5","1111111","222222","333333","Jul 25 2017  1:56PM","Jul 25 2017  1:56PM","Jul 25 2017  1:56PM")
GO
....
GO
SET QUOTED_IDENTIFIER ON
GO

# Example 2

```sh
Exec sp_ScriptRows @table = 'SampleTable', @where = 'VarcharColumn1 like ''4%'''
```

SET QUOTED_IDENTIFIER OFF  
GO  
INSERT INTO SampleTable  
([VarcharColumn1],[VarcharColumn2],[VarcharColumn3],[BigintColumn1],[BigintColumn2],[BigintColumn3],[DateTimeColumn1],[DateTimeColumn2],[DateTimeColumn3])  
VALUES  
("4735B2C5-32F9-45DB-8F23-2563A9300B81","66B8F5DE-DB71-407D-8962-37EF00438A6E","5B71213D-1FCD-436F-8B76-119F76774F9D","1111111","222222","333333","Jul 25 2017  1:56PM","Jul 25 2017  1:56PM","Jul 25 2017  1:56PM")  
GO  
INSERT INTO SampleTable  
([VarcharColumn1],[VarcharColumn2],[VarcharColumn3],[BigintColumn1],[BigintColumn2],[BigintColumn3],[DateTimeColumn1],[DateTimeColumn2],[DateTimeColumn3])  
VALUES  
("4AE9A4C5-6C9F-46D3-AD71-E59A69000D3B","AAF8CE1E-B9DA-4198-A792-C012DAF9B1E1","18168095-9BAB-47EC-8930-CAC55B9FE63C","1111111","222222","333333","Jul 25 2017  1:56PM","Jul 25 2017  1:56PM","Jul 25 2017  1:56PM")  
GO  
SET QUOTED_IDENTIFIER ON  
GO  


# Example 3

```sh
Exec sp_ScriptRows @table = 'SampleTable', @where = 'VarcharColumn1 like ''4%''', @top=1
```
SET QUOTED_IDENTIFIER OFF
GO
INSERT INTO SampleTable
([VarcharColumn1],[VarcharColumn2],[VarcharColumn3],[BigintColumn1],[BigintColumn2],[BigintColumn3],[DateTimeColumn1],[DateTimeColumn2],[DateTimeColumn3])
VALUES
("4735B2C5-32F9-45DB-8F23-2563A9300B81","66B8F5DE-DB71-407D-8962-37EF00438A6E","5B71213D-1FCD-436F-8B76-119F76774F9D","1111111","222222","333333","Jul 25 2017  1:56PM","Jul 25 2017  1:56PM","Jul 25 2017  1:56PM")
GO
SET QUOTED_IDENTIFIER ON
GO


