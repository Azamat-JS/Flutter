import 'package:isar/isar.dart';

part 'todo_model.g.dart';

// dart run build_runner build --delete-conflicting-outputs

// this line is needed for code generation
// then run: dart run build_runner build

@collection
class TodoModel {
  Id id = Isar.autoIncrement;

  late String title;
  late bool isCompleted;
}
