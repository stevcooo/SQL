IF EXISTS (SELECT * FROM SYS.procedures where Name = 'sp_FindGaps')
	DROP PROCEDURE dbo.sp_FindGaps
go
CREATE PROCEDURE dbo.sp_FindGaps
(
	@TableName varchar(300),
	@ColumnName varchar(2000) = 'Id',
	@MinimumGap int = 0
)
AS 
BEGIN

	DECLARE @counter int = 0
	DECLARE @CurrentGap int = 0
	DECLARE @PrevGap int = 0
	DECLARE @Space bigint
	DECLARE @TotalSpace bigint
	DECLARE @Max bigint
	DECLARE @SQLString NVARCHAR(500)
	DECLARE @ParmDefinition NVARCHAR(500)
	DECLARE @Table varchar(300) = ''
	DECLARE @Column varchar(300) = ''
	
	SET @SQLString = N'SELECT @TableOUT = [Name] from sys.tables where [Name] = '''+@TableName+''''	
	SET @ParmDefinition = N'@TableOUT varchar(200) OUTPUT'
	EXECUTE sp_executesql @SQLString, @ParmDefinition, @TableOUT = @Table OUTPUT
	
	IF(@Table = '')
	BEGIN
		PRINT 'Table '+@TableName+' not exists!'
		RETURN;
	END

	SET @SQLString = N'SELECT @ColumnOUT = [Name] from sys.columns where [Name] = '''+@ColumnName+''' and OBJECT_NAME(OBJECT_ID) = '''+@TableName+''' and system_type_id in (127, 56, 52, 48)'	
	SET @ParmDefinition = N'@ColumnOUT varchar(200) OUTPUT'
	EXECUTE sp_executesql @SQLString, @ParmDefinition, @ColumnOUT = @Column OUTPUT
	
	IF(@Column = '')
	BEGIN
		PRINT 'Table '+@TableName+' doesn''t have a column named '+ @ColumnName+', or it is not of a type int, bigint, tinyint or smallint.'
		RETURN;
	END	

	SET @SQLString = N'SELECT @MaxOUT = max('+@ColumnName+') FROM '+@TableName+''
	SET @ParmDefinition = N'@MaxOUT bigint OUTPUT'

	EXECUTE sp_executesql @SQLString, @ParmDefinition, @MaxOut = @Max OUTPUT
	

WHILE(1 =1)
	BEGIN		
		SELECT @PrevGap  = @CurrentGap 

		SET @SQLString = '
		SELECT TOP 1
			@CurrentGapOUT = '+@ColumnName+' + 1
		FROM '+@TableName+' mo
		WHERE NOT EXISTS
			(
			SELECT NULL
			FROM '+@TableName+' mi 
			WHERE mi.'+@ColumnName+' = mo.'+@ColumnName+' + 1
			)	
		and '+@ColumnName+'>=@CurrentGap 
		ORDER BY '+@ColumnName+''
		SET @ParmDefinition = N'@CurrentGap  bigint, @CurrentGapOUT bigint OUTPUT'
		EXECUTE sp_executesql @SQLString, @ParmDefinition, @CurrentGap = @CurrentGap, @CurrentGapOUT = @CurrentGap OUTPUT

		SELECT @counter+=1		
				
		SET @SQLString = 'select @SpaceOUT = min('+@ColumnName+') from '+@TableName+' where '+@ColumnName+'> @CurrentGap'
		SET @ParmDefinition = N'@CurrentGap  bigint, @SpaceOUT bigint OUTPUT'
		EXECUTE sp_executesql @SQLString, @ParmDefinition, @CurrentGap = @CurrentGap, @SpaceOUT = @Space OUTPUT
		
		SELECT @TotalSpace = @Space  - @CurrentGap
		IF(@TotalSpace > = @MinimumGap)
		BEGIN			
			PRINT 'Starting from: ' + cast(@CurrentGap as varchar) + ' Total empty spaces is: ' +cast(@TotalSpace   as varchar)			
		END

		IF(@CurrentGap>@Max)
			BREAK
	END
END
