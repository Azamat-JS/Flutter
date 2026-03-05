import 'package:isar/isar.dart';

part 'auth_model.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;
  late String username;
  late String email;
  late String password;
}
