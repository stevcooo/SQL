# Find table
sp_FindTable is SQL procedure that helps you find in witch tables is used some column. You only need the name of the column and the procedure will find all tables that have that column.

# Example

```sh
exec sp_FindTable 'Employee'
```
Results:
| Table | Column |
| ------ | ------ |
| Appointments | EmployeeId |
| AppointmentCAResponsibles | EmployeeId |
| DedicatedSalesRules | EmployeeId |
| Documents | EmployeeId |
| PosSessions | EmployeeClosedId |

# TIP
You can also include this procedure in SQL Management studio shortcuts and use it more easly:
  - In SQL Management Studio open Tools->Options->Environment->Keyboard->Query Shortcuts
  - Here choose withc shortcut you like, and in the StoredProcedure column write sp_FindTable (i'm using Ctrl+3)
  -![shortcustsExample](https://raw.githubusercontent.com/stevcooo/SQL/master/Resources/sqlQueryShortcuts.png)
 - Please note that this requires to restart the SQL Management studio.
 - After you have setup the shorcut, you can select some text and click the shortcute (in the example Ctrl+3) and the procedure will be executed and you will get the tables that have column with name like the text you have selected.
