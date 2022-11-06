# Todo App

This would be a simple todo app
Use Hive as DB and Bloc as for State Management and Navigator 2.0 

The flow would be as:
When a new todo is created, a loading screen appears. After some seconds, the todo is added. 
Same timeout happens for deleting a todo or completing a todo.

Do not use the ValueListenable builder from the Hive package. Use bloc for everything.