import 'package:flutter/material.dart';

class Todo {
  final int id;
  final String title;
  Todo(this.id, this.title);
  bool done = false;
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _todos = <Todo>[];
  final _input = TextEditingController(); 
  int _nextId = 0;

  Todo? _lastDeletedTodo;
  int? _lastDeletedIndex;

  @override
  void dispose() {
    _input.dispose(); 
    super.dispose();
  }

  void _add() {
    if (_input.text.isEmpty) return;
    setState(() {
      _todos.add(Todo(_nextId++, _input.text)); 
    });
    _input.clear();
  }

  void _toggle(Todo todo) {
    setState(() => todo.done = !todo.done);
    //todo.done=!todo.done;
  }

  void _remove(Todo todo) {
    setState(() {
      _todos.removeWhere((t) => t.id == todo.id); 
    });
  }

  void _restore() {
    if (_lastDeletedTodo != null && _lastDeletedIndex != null) {
      setState(() {
        _todos.insert(_lastDeletedIndex!, _lastDeletedTodo!);
      });
    }
  }

  int _countDone() {
    int done = 0;
    for (var i = 0; i < _todos.length; i++) {
      done += _todos[i].done ? 1 : 0;
    }
    return done;
  }

  @override
  Widget build(BuildContext context) {
    String? _filter;
    
    final visible = _todos.where(
      (t) => t.title.contains(_filter ?? '')).toList();
      
    return Scaffold(
      appBar: AppBar(title: Text('Todo (Done: ${_countDone()})')),
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
            child: visible.isEmpty
                ? const Center(child: Text('Nothing to do yet.'))
                : ListView.builder(
                    itemCount: visible.length,
                    itemBuilder: (context, i) {
                      final todo = visible[i];
                      return Dismissible(
                        key: ValueKey(todo.id), 
                        direction: DismissDirection.endToStart, 
                        background: Container(color: Colors.red), 
                        onDismissed: (_) {

                          _lastDeletedIndex = _todos.indexOf(todo);
                          _lastDeletedTodo = todo;
                          
                          _remove(todo);
                          
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Todo deleted'),
                              action: SnackBarAction(
                                label: 'Undo', 
                                onPressed: _restore, 
                              ),
                            ), 
                          );
                        },
                        child: TodoTile(
                          todo: todo,
                          onToggle: () => _toggle(todo),
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
          value: todo.done,
          onChanged: (_) => onToggle(),
        ),
        title: Text(todo.title),
      ),
    );
  }
}