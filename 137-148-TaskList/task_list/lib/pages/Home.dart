import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// flutter run --no-sound-null-safety

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todoController = TextEditingController();

  List _todoList = [];
  late Map<String, dynamic> _lastRemoved;
  late int _lastRemovedPosition;

  @override
  void initState() {
    super.initState();

    _readData().then((data) {
      if (data != null) {
        setState(() {
          _todoList = json.decode(data);
        });
      }
    });
  }

  void _addTodo() {
    setState(() {
      Map<String, dynamic> newTodo = {};
      newTodo['title'] = _todoController.text;
      _todoController.text = '';
      newTodo['ok'] = false;
      _todoList.add(newTodo);
      _saveData();
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _todoList.sort((a, b) {
        if (a['ok'] && !b['ok']) {
          return 1;
        } else if (!a['ok'] && b['ok']) {
          return -1;
        } else {
          return 0;
        }
      });
    });

    _saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text('Lista de Tarefas'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.blueAccent),
                      labelText: "Nova Tarefa",
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _addTodo,
                    child: const Text("ADD")),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                itemBuilder: buildItem,
                itemCount: _todoList.length,
                padding: const EdgeInsets.only(top: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, int i) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment(-0.9, 0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_todoList[i]);
          _lastRemovedPosition = i;
          _todoList.removeAt(i);
          _saveData();

          final snackBar = SnackBar(
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                setState(() {
                  _todoList.insert(_lastRemovedPosition, _lastRemoved);
                });
              },
            ),
            content: Text('Tarefa ${_lastRemoved['title']} removida!'),
            duration: const Duration(seconds: 2),
          );

          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      },
      child: CheckboxListTile(
        onChanged: (checked) {
          setState(() {
            _todoList[i]['ok'] = checked;
            _saveData();
          });
        },
        secondary: CircleAvatar(
          child: Icon(
            _todoList[i]['ok'] ? Icons.check : Icons.error,
          ),
        ),
        title: Text(_todoList[i]['title']),
        value: _todoList[i]['ok'],
      ),
    );
  }

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();

    return File("${dir.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_todoList);
    final file = await _getFile();

    return file.writeAsString(data);
  }

  Future<String?> _readData() async {
    try {
      final file = await _getFile();

      return file.readAsStringSync();
    } catch (e) {
      return null;
    }
  }
}
