import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../todo.dart';

const toDoListKey = 'todo_list';

class TodoRepository {
  late SharedPreferences sharedPreferences;

  Future<List<Todo>> getToDoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jstring = sharedPreferences.getString(toDoListKey) ?? '[]';
    final List jsonDecoded = json.decode(jstring) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  void saveToDolist(List<Todo> todos) {
    final String jstring = json.encode(todos);
    sharedPreferences.setString('todo_list', jstring);
  }
}
