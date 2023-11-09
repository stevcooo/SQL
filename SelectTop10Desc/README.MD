# Find table

sp_SelectTop10Desc is SQL procedure that helps you select top 10 rows of any table by descending order.

# Example

```sh
exec sp_SelectTop10Desc 'Cars'
```

Results:

| Id  | Name         |
| --- | ------------ |
| 302 | Aston Martin |
| 301 | Tesla        |
| 300 | Jaguar       |
| 299 | Maserati     |
| 298 | Land Rover   |

# TIP

You can also include this procedure in SQL Management studio shortcuts and use it more easily:

- In SQL Management Studio open Tools->Options->Environment->Keyboard->Query Shortcuts
- Here choose with shortcut you like, and in the StoredProcedure column write sp_SelectTop10Desc (i'm using Ctrl+3) -![shortcustsExample](https://raw.githubusercontent.com/stevcooo/SQL/master/Resources/sqlQueryShortcuts.png)
- Please note that this requires restarting the SQL Management studio.
- After you have setup the shortcut, you can select some text and click the shortcut (in the example Ctrl+3) and the procedure will be executed and you will get the tables that have a column with a name like the text you have selected.

- ![sample](https://raw.githubusercontent.com/stevcooo/SQL/master/Resources/selecttTop10.gif)
