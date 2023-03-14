import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({Key? key}) : super(key: key);

  // with controller
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                  ),
                  onChanged: onChanged, // with onChanged
                  onSubmitted: onSubmitted, // with onSubmitted
                ),
                ElevatedButton(
                  onPressed: login, // with controller
                  child: Text('Entrar'),
                ),
              ],
            )),
      ),
    );
  }

  // with controller
  void login() {
    String text = emailController.text;
    print('with controller $text'); // on button click
    emailController.clear();
  }

  void onChanged(String text) {
    print('with onChanged $text'); // as it's typed
  }

  void onSubmitted(String text) {
    print('with onSubmitted $text'); // only on enter
  }
}
