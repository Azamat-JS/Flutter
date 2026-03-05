import 'package:isar/isar.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;
  late String email;
  late String password;
  late String username;
}
