import 'package:blog_cle_arch/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);
  @override
  List<BlogModel> loadBlogs() {
    return box.values
        .map((e) {
          try {
            return BlogModel.fromJson(Map<String, dynamic>.from(e));
          } catch (err) {
            return null;
          }
        })
        .whereType<BlogModel>()
        .toList();
  }

  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    for (var blog in blogs) {
      box.put(blog.id, blog.toJsonForLocal());
    }
  }
}
