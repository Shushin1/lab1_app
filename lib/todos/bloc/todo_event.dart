sealed class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
    AddTodo(this.title);
    final String title;
}

class ToggleTodo extends TodoEvent{
    ToggleTodo(this.id);
    final int id;
}

class RemoveTodo extends TodoEvent{
    RemoveTodo(this.id);
    final int id;
}