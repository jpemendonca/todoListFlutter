import 'package:flutter/material.dart';
import 'package:todo_list/todo_list_page.dart';
import 'todo.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromARGB(10, 208, 183, 176)),
      debugShowCheckedModeBanner: false,
      home: TodoListPage(),
    );
  }
}
