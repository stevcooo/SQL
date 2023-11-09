/*
	exec sp_SelectTop10Desc 'Cars'
*/
if exists (select * from sys.procedures where name = 'sp_SelectTop10Desc')
	drop procedure sp_SelectTop10Desc
go
create procedure sp_SelectTop10Desc
(
	@TableName varchar(255)
) as
begin
	DECLARE @Sql NVARCHAR(MAX);
	DECLARE @IdentityColumnName NVARCHAR(MAX);
	select @IdentityColumnName  = name FROM sys.columns WHERE [object_id] = OBJECT_ID(@TableName) AND is_identity = 1;
	SET @Sql = N'SELECT TOP 10 * FROM ' + @TableName  + ' order by ' + @IdentityColumnName + ' desc'
	EXECUTE sp_executesql @Sql
end
