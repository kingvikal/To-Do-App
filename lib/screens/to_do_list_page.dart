import 'package:flutter/material.dart';

import '../models/task.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  void deleteTask(String id) {
    setState(() {
      tasks.removeWhere((tasks) => tasks.id == id);
    });
  }

  void _saveForm() {
    setState(
      () {
        tasks.add(
          Task(
            id: DateTime.now().toIso8601String(),
            name: _nameController.text,
            address: _addressController.text,
          ),
        );
      },
    );
    _nameController.clear();
    _addressController.clear();
    Navigator.of(context).pop();
  }

  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) {
                return Dialog(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    height: 285,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        TextFormField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _saveForm();
                          },
                          child: const Text(
                            'Add',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'To do App',
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: tasks.isEmpty
              ? const Center(
                  child: Text(
                    'No Tasks Added',
                  ),
                )
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (ctx, i) {
                    return TaskWidget(tasks[i].id, tasks[i].name,
                        tasks[i].address, i, deleteTask);
                  },
                ),
        ),
      ),
    );
  }
}

class TaskWidget extends StatefulWidget {
  final int index;
  final String id;
  final String name;
  final String address;
  final Function deleteTask;

  TaskWidget(this.id, this.name, this.address, this.index, this.deleteTask);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 10),
              Text(
                widget.address,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              widget.deleteTask(widget.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ]),
      ),
    );
  }
}
