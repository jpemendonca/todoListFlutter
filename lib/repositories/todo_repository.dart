import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../todo.dart';

class TodoRepository {
  TodoRepository() {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  late SharedPreferences sharedPreferences;

  void saveToDolist(List<Todo> todos) {
    final jstring = json.encode(todos);
    print(jstring);
  }
}
