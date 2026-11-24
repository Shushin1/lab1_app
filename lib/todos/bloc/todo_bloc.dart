import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1_app/models/todo.dart';
import 'package:lab1_app/todos/bloc/todo_event.dart';
import 'package:lab1_app/todos/bloc/todo_state.dart';
import 'package:lab1_app/todos/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState>{
  TodoBloc(this._repo) : super(const TodoState()){
    on<LoadTodos>(_onLoad);
    on<AddTodo>(_onAdd);
    on<ToggleTodo>(_onToggle);
    on<RemoveTodo>(_onRemove);
  }

  final TodoRepository _repo;

  Future<void> _onLoad(LoadTodos e, Emitter<TodoState> emit) async {
    emit(state.copyWith(loading: true));
    emit(TodoState(todos: await _repo.fetchTodos()));
  }

  void _onAdd(AddTodo event, Emitter<TodoState> emit) {
    final nextId = state.todos.isEmpty ? 1 : state.todos.last.id + 1;
    final todo = Todo(
      userId: 1,
      id: nextId,
      title: event.title,
      completed: false,
    );
    emit(state.copyWith(todos: [...state.todos, todo]));
  }

  void _onToggle(ToggleTodo event, Emitter<TodoState> emit) {
    emit(
      state.copyWith(
        todos: [
          for (final t in state.todos)
            if (t.id == event.id) t.copyWith(completed: !t.completed) else t,
        ],
      ),
    );
  }

  void _onRemove(RemoveTodo event, Emitter<TodoState> emit) {
    emit(
      state.copyWith(
        todos: state.todos.where((t) => t.id != event.id).toList(),
      ),
    );
  }
  
}