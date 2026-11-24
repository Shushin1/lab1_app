import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo.dart';
//import '../todos/cubit/todo_cubit.dart';
//import '../todos/cubit/todo_state.dart';
import '../todos/bloc/todo_bloc.dart';
import '../todos/bloc/todo_event.dart';
import '../todos/bloc/todo_state.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _input = TextEditingController();

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _add() {
    if (_input.text.isEmpty) return;
    //context.read<TodoCubit>().add(_input.text);
    context.read<TodoBloc>().add(AddTodo(_input.text));
    _input.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        final doneCount = state.todos.where((t) => t.completed).length;

        return Scaffold(
          appBar: AppBar(title: Text('Todo (Done: $doneCount)')),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _input,
                  decoration: const InputDecoration(hintText: 'Enter new todo'),
                ),
              ),
              Expanded(
                child: state.loading
                    ? const Center(child: CircularProgressIndicator())
                    : state.todos.isEmpty
                        ? const Center(child: Text('Nothing to do yet.'))
                        : ListView.builder(
                            itemCount: state.todos.length,
                            itemBuilder: (context, i) {
                              final todo = state.todos[i];
                              return Dismissible(
                                key: ValueKey(todo.id),
                                direction: DismissDirection.endToStart,
                                background: Container(color: Colors.red),
                                onDismissed: (_) =>
                                    //context.read<TodoCubit>().remove(todo.id),
                                    context.read<TodoBloc>().add(RemoveTodo(todo.id)),
                                child: TodoTile(
                                  todo: todo,
                                  onToggle: () =>
                                      //context.read<TodoCubit>().toggle(todo.id),
                                      context.read<TodoBloc>().add(ToggleTodo(todo.id)),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _add,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.todo, required this.onToggle});
  final Todo todo;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: todo.completed,
          onChanged: (_) => onToggle(),
        ),
        title: Text(todo.title),
      ),
    );
  }
}