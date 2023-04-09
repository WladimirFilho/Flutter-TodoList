import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/data/database.dart';
import 'package:todo_list/util/dialog_box.dart';
import 'package:todo_list/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// text controller
final _controller = TextEditingController();

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the first time openin the app, than create default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // there already exist data
      db.loadData();
    }
    super.initState();
  }

  //save new task
  void onSave() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      Navigator.of(context).pop();
      _controller.clear();
    });
    db.updateDataBase();
  }

  // checkbox was tapped
  void checkBoxChange(bool? value, index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBox(
          onSave: onSave,
          onCancel: () => Navigator.of(context).pop(),
          controller: _controller,
        );
      },
    );
    db.updateDataBase();
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(
          Icons.add,
        ),
      ),
      backgroundColor: Colors.yellow[200],
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
              deleteFunction: (contex) {
                return deleteTask(index);
              },
              taskName: db.toDoList[index][0],
              isChecked: db.toDoList[index][1],
              onChanged: (value) => checkBoxChange(value, index));
        },
      ),
    );
  }
}
