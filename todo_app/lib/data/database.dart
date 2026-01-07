import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todoTasks = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    todoTasks = [
      ['Make app', false],
      ['Read book', false],
    ];
  }

  void loadData() {
    todoTasks = _myBox.get('TODOLIST');
  }

  void updateDatabase() {
    _myBox.put('TODOLIST', todoTasks);
  }
}
