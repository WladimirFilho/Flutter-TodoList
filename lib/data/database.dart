import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // ref our bo
  final _myBox = Hive.box('mybox');

  // run this method is this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ['🔥 Wellcome to New ToDo List', false],
      ['📝 Lets note taking', false],
    ];
  }

  // load the data from the database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  // update the database
  void updateDataBase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
