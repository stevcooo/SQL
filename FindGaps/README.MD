# Find gaps
dbo.sp_FindGaps is SQL procedure that helps you find gaps (deleted rows) in the ids of the table. For example, if you have a table with a lot of data where deleting rows is frequent operation and you want to find the gaps in the ids this procedure helps you to find them.

# Parametars
| Parametar | Description |
| ------ | ------ |
| @TableName | The name of the table |
| @ColumnName | This is an optional parameter, by default it is set to 'Id', but if your identity column is different you can set it here, it can only be of type int, bigint, tinyint or smallint.|
| @MinimumGap | This is an optional parameter, use it if you don't want to see the find gaps smaller than 1. |

# Output
	Text with the details.

# Example 1

```sh
exec sp_FindGaps @TableName = 'Employees'
```
Results:

Starting from: 35 Total empty spaces is: 1
Starting from: 37 Total empty spaces is: 2
Starting from: 40 Total empty spaces is: 1
Starting from: 49 Total empty spaces is: 1
Starting from: 56 Total empty spaces is: 90
Starting from: 152 Total empty spaces is: 6

# Example 2

```sh
exec sp_FindGaps @TableName = 'TestTable', @ColumnName = 'TestTableId'
```

Results:
Starting from: 5 Total empty spaces is: 3

# Example 3

```sh
exec sp_FindGaps @TableName = 'Employees', @ColumnName = 'Name'
```

Results:
Table Employees doesn't have a column named Name, or it is not of a type int, bigint, tinyint or smallint.

# Example 4
```sh
exec sp_FindGaps @TableName = 'Employees', @MinimumGap  = 5
```
Results:
Starting from: 56 Total empty spaces is: 90
Starting from: 152 Total empty spaces is: 6
Starting from: 176 Total empty spaces is: 12
Starting from: 241 Total empty spaces is: 5
Starting from: 442 Total empty spaces is: 59
Starting from: 503 Total empty spaces is: 8