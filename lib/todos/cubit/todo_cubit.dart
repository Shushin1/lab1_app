import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1_app/api/todo_api.dart';
import 'package:lab1_app/todos/cubit/todo_state.dart';
import 'package:lab1_app/models/todo.dart';

class TodoCubit extends Cubit<TodoState>{
  TodoCubit() : super(const TodoState());
  
  Future<void> load() async {
    emit(state.copyWith(loading: true));
    emit(TodoState(todos: await fetchTodos()));
  }

  void add(String title) {
    final nextId = state.todos.isEmpty ? 1 : state.todos.last.id + 1;
    final todo = Todo(
      userId: 1,
      id: nextId,
      title: title,
      completed: false,
    );
    emit(state.copyWith(todos: [...state.todos, todo]));
  }

  void toggle(int id) => emit(state.copyWith(todos: [
        for (final t in state.todos) 
          if (t.id==id) t.copyWith(completed: !t.completed) else t,
      ]));
  
  void remove(int id) => emit(state.copyWith(todos: 
        state.todos.where((t) => t.id != id).toList(),
      ));

}