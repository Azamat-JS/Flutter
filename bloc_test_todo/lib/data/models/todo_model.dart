import 'package:isar/isar.dart';

@collection
class TodoModel {
  Id id = Isar.autoIncrement;

  late String title;
  late bool isCompleted;
}
