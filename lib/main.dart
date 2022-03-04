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
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 226, 222, 220)),
      debugShowCheckedModeBanner: false,
      home: TodoListPage(),
    );
  }
}
