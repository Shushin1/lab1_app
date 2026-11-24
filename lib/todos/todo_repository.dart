import 'package:dio/dio.dart';
import 'package:lab1_app/models/todo.dart';

class TodoRepository {
    TodoRepository(this._dio);
    final Dio _dio;
    static const _url= 'https://jsonplaceholder.typicode.com/todos';
    
    Future<List<Todo>> fetchTodos() async {
      final res = await _dio.get(_url);
      return (res.data as List)
          .map((json) => Todo.fromJson(json))
          .toList();

    }
}