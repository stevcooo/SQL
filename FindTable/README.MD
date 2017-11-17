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
You can also include this procedure in SQL Management studio shortcuts and use it more easily:
  - In SQL Management Studio open Tools->Options->Environment->Keyboard->Query Shortcuts
  - Here choose with shortcut you like, and in the StoredProcedure column write sp_FindTable (i'm using Ctrl+3)
  -![shortcustsExample](https://raw.githubusercontent.com/stevcooo/SQL/master/Resources/sqlQueryShortcuts.png)
 - Please note that this requires restarting the SQL Management studio.
 - After you have setup the shortcut, you can select some text and click the shortcut (in the example Ctrl+3) and the procedure will be executed and you will get the tables that have a column with a name like the text you have selected.
 
- ![sample](https://raw.githubusercontent.com/stevcooo/SQL/master/Resources/sample.gif)
