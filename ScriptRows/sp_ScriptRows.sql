--Exec sp_ScriptRows 'Employees'
IF EXISTS(SELECT * FROM sys.procedures where Name = 'sp_ScriptRows')
	DROP PROCEDURE sp_ScriptRows
GO
CREATE PROCEDURE [dbo].[sp_ScriptRows]  
  @table      varchar(256),  
  @where      varchar(1000)='',  
  @noident    bit = 1,  
  @order      varchar(1000)='',  
  @top        int = 0,  
  @dest_table varchar(256) = ''  
AS  
    IF object_id(@table) IS NULL  
    BEGIN  
        PRINT('Ne postoji tabela '+@table+' !')  
        RETURN  
    END  
  
    DECLARE @name     varchar(256),  
            @into     varchar(8000),  
            @xtype    int,  
            @declare  varchar(8000),  
            @values   varchar(8000),  
            @pntTable varchar(262),  
            @tname    varchar(256),  
            @intolist varchar(8000),  
			@SelectColumns varchar(8000),
            @status   tinyint,  
            @s_top    varchar(20),  
            @max      int,  
            @values1  varchar(8000),  
            @values2  varchar(8000),  
            @values3  varchar(8000),  
            @values4  varchar(8000),  
            @values5  varchar(8000),  
            @values6  varchar(8000),  
            @values7  varchar(8000)  
    SET @max = 6000  
    SET @into = ''  
    SET @intolist = ''  
	set @SelectColumns = ''
    SET @declare = 'declare '  
    SET @values1=''  
    SET @values2=''  
    SET @values3=''  
    SET @values4=''  
    SET @values5=''  
    SET @values6=''  
    SET @values7=''  
    IF @dest_table=''  
      SET @pntTable = 'set @t=@t+'''+@table+''''  
    ELSE  
      SET @pntTable = 'set @t=@t+'''+@dest_table+''''  
    IF @where<>''  
      SET @where = 'where '+@where  
    IF @order<>''  
      SET @order = 'order by '+@order  
    IF @top=0  
      SET @s_top = ''  
    ELSE  
      SET @s_top = ' top '+cast(@top AS varchar)  
    
	DECLARE col CURSOR FOR  
      SELECT  
        name,  
        status  
      FROM   syscolumns  c
      WHERE  c.id=object_id(@table)  and c.xtype <> 189
    OPEN col  

    FETCH NEXT FROM col INTO @name, @status  
  
    WHILE @@FETCH_STATUS=0  
    BEGIN  
        SET @into = @into+'@'+@name+','  
		SET @SelectColumns = @SelectColumns + '['+@name+'],'
        SET @declare = @declare+'@'+@name+' varchar(8000)'+',' --sql_variant        
  
        IF (@noident=0)  
            OR ((@status & 128)<>128)  
        BEGIN  
            IF (len(@values1)/@max)<1  
              SET @values1 = @values1+' set @t=@t+case when @'+@name+' is null then ''NULL''else''"''+cast(replace(@'+@name+',''"'','''''''') as varchar(8000))+''"''end+'+''','''  
            ELSE  
              IF (len(@values2)/@max)<1  
                SET @values2 = @values2+' set @t=@t+case when @'+@name+' is null then ''NULL''else''"''+cast(replace(@'+@name+',''"'','''''''') as varchar(8000))+''"''end+'+''','''  
              ELSE  
                IF (len(@values3)/@max)<1  
                  SET @values3 = @values3+' set @t=@t+case when @'+@name+' is null then ''NULL''else''"''+cast(replace(@'+@name+',''"'','''''''') as varchar(8000))+''"''end+'+''','''  
                ELSE  
                  IF (len(@values4)/@max)<1  
                    SET @values4 = @values4+' set @t=@t+case when @'+@name+' is null then ''NULL''else''"''+cast(replace(@'+@name+',''"'','''''''') as varchar(8000))+''"''end+'+''','''  
                  ELSE  
                    IF (len(@values5)/@max)<1  
                      SET @values5 = @values5+' set @t=@t+case when @'+@name+' is null then ''NULL''else''"''+cast(replace(@'+@name+',''"'','''''''') as varchar(8000))+''"''end+'+''','''  
                    ELSE  
                      IF (len(@values6)/@max)<1  
                        SET @values6 = @values6+' set @t=@t+case when @'+@name+' is null then ''NULL''else''"''+cast(replace(@'+@name+',''"'','''''''') as varchar(8000))+''"''end+'+''','''  
                      ELSE  
                        IF (len(@values7)/@max)<1  
                          SET @values7 = @values7+' set @t=@t+case when @'+@name+' is null then ''NULL''else''"''+cast(replace(@'+@name+',''"'','''''''') as varchar(8000))+''"''end+'+''','''  
            SET @intolist = @intolist+' set @t=@t+''['+@name+'],'''  
        END  
  
        FETCH NEXT FROM col INTO @name, @status  
    END  
    
	IF @values7<>''  
      SET @values7 = left(@values7, len(@values7)-4)  
    ELSE  
      IF @values6<>''  
        SET @values6 = left(@values6, len(@values6)-4)  
      ELSE  
        IF @values5<>''  
          SET @values5 = left(@values5, len(@values5)-4)  
        ELSE  
          IF @values4<>''  
            SET @values4 = left(@values4, len(@values4)-4)  
          ELSE  
            IF @values3<>''  
              SET @values3 = left(@values3, len(@values3)-4)  
            ELSE  
              IF @values2<>''  
                SET @values2 = left(@values2, len(@values2)-4)  
              ELSE  
                IF @values1<>''  
                  SET @values1 = left(@values1, len(@values1)-4)  
  
    SET @intolist = left(@intolist, len(@intolist)-2)+''''  
    SET @into = left(@into, len(@into)-1)  
	SET @SelectColumns = left(@SelectColumns, len(@SelectColumns)-1)  
    SET @declare = left(@declare, len(@declare)-1)  
  
    CLOSE col  
    DEALLOCATE col  

    PRINT 'SET QUOTED_IDENTIFIER OFF'  
    PRINT 'GO'  
    
	EXEC (' declare @var varchar(256), @t varchar(8000) '+ @declare+ ' declare c cursor'+ ' for'+ ' select '+@s_top+ ' '+ @SelectColumns +'  from '+@table+ ' '+@where+ ' '+@order+ ' open c'+ ' fetch next from c'+ ' into '+@into+ ' while @@fetch_status = 0'+ ' begin'+ ' set @t=''INSERT INTO '''+ @pntTable + ' set @t=@t + char(13)+char(10)'+ ' set @t=@t + ''('''+ @intolist+ ' set @t=@t+ '')'''+ ' set @t=@t + char(13)+char(10)'+ ' set @t=@t+ ''VALUES'''+ ' set @t=@t + char(13)+char(10)+ ''('''+ @values1 + @values2 + @values3 + @values4 + @values5 + @values6 + @values7 + ' set @t=@t+ '')'''+ ' print @t'+ ' print ''GO'''+ ' fetch next from c'+ ' into '+@into+ ' end'+ ' close c'+ ' deallocate c' )
    PRINT 'SET QUOTED_IDENTIFIER ON'  
    PRINT 'GO'  
  