import 'package:equatable/equatable.dart';
import 'package:lab1_app/models/todo.dart';

class TodoState extends Equatable{
  final List<Todo> todos;
  final bool loading;

  const TodoState({this.todos=const[], this.loading=false});
  TodoState copyWith({List<Todo>? todos, bool? loading}) => TodoState(
      todos: todos ?? this.todos,
      loading: loading ?? this.loading,
  );

  @override
  List<Object?> get props => [todos, loading];

}