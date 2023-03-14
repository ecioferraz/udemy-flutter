import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adicione uma tarefa',
                    hintText: 'Ex.: Estudar Flutter',
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff00d7f3),
                  padding: EdgeInsets.all(14.0),
                ),
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
