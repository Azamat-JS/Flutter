class TodoModel {
  final String name;
  final DateTime createdAt;
  TodoModel({required this.name, required this.createdAt});

  @override
  String toString() => 'TodoModel(name: $name, createdAt: $createdAt)';
}
