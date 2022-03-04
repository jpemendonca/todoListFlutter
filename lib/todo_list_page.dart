import 'package:flutter/material.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'todo.dart';
import 'myTaskWidget.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController newTodo = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();
  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPosition;
  String? errorText;

  @override
  void initState() {
    super.initState();

    todoRepository.getToDoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  void addTask() {
    if (newTodo.text.isEmpty) {
      setState(() {
        errorText = 'Você deve inserir um título na sua tarefa';
      });
      return;
    }

    setState(() {
      Todo newTask = Todo(title: newTodo.text, dateTime: DateTime.now());
      todos.add(newTask);
      errorText = null;
    });
    newTodo.clear();
    todoRepository.saveToDolist(todos);
  }

  void showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpar tudo?'),
        content: Text('Você tem certeza que deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Não, voltar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                todos.clear();
              });
              todoRepository.saveToDolist(todos);

              Navigator.of(context).pop();
            },
            child: Text('Limpar tudo'),
            style:
                TextButton.styleFrom(primary: Color.fromARGB(255, 255, 17, 0)),
          )
        ],
      ),
    );
  }

  void onDelete(Todo todoItem) {
    deletedTodo = todoItem;
    deletedTodoPosition = todos.indexOf(todoItem);

    setState(() {
      todos.remove(todoItem);
      todoRepository.saveToDolist(todos);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.purple,
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPosition!, deletedTodo!);
            });
            todoRepository.saveToDolist(todos);
          },
        ),
        content: Text(
          'A tarefa "${todoItem.title}" foi removida com sucesso',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: newTodo,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.purple),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple)),
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Exemplo: Estudar',
                          errorText: errorText,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3))),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: addTask,
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple, padding: EdgeInsets.all(16)),
                  )
                ],
              ),
              SizedBox(height: 16),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    for (Todo todo in todos)
                      MyTaskWidget(todo: todo, onDelete: onDelete)
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Você possui ${todos.length} tarefas pendentes',
                    style: TextStyle(color: Colors.purple),
                  )), //O Expanded serve pra o conteúdo ocupar o maior espaço possivel
                  ElevatedButton(
                    onPressed: showDeleteConfirmationDialog,
                    child: Text('Limpar tudo'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple, padding: EdgeInsets.all(16)),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
