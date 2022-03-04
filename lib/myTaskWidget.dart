import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyTaskWidget extends StatelessWidget {
  MyTaskWidget({Key? key, required this.todo, required this.onDelete})
      : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Slidable(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: Colors.grey[200]),
          child: Column(
            children: [
              Text(
                DateFormat('EEEE  dd/MM/yyyy     HH:mm').format(todo.dateTime),
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 5),
              Text(
                todo.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Se usar o start ele vai ocupar apenas a menor area
          ),
        ),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              label: 'Deletar',
              backgroundColor: Colors.red,
              icon: Icons.delete,
              onPressed: (c) {
                onDelete(todo);
              },
            ),
          ],
        ),
      ),
    );
  }
}
