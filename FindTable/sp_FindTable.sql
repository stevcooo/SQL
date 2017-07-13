/*
	exec sp_FindTable '%emp%'
*/
if exists (select * from sys.procedures where name = 'sp_FindTable')
	drop procedure sp_FindTable
go
create procedure sp_FindTable
(
	@ColumnName varchar(255)
) as
begin
	
	select object_name(object_id) as [Table], name as [Column] from sys.columns where name like '%'+@ColumnName+'%'
end


