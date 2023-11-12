import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:second_brain/objectbox.g.dart';

class AppLocalDatabase {
  late final Store store;

  AppLocalDatabase._create(this.store) {
    // Add any additional setup code, eg build queries.
  }

  /// Create an instance of Objectbox to use throughout the app
  static Future<AppLocalDatabase> create() async {
    final Directory docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: p.join(docsDir.path, "objectbox"),
    );
    return AppLocalDatabase._create(store);
  }

  int insert<T>(T object) {
    final Box<T> box = store.box<T>();
    return box.put(object);
  }

  Future<T?> getLast<T>() async {
    final Box<T> box = store.box<T>();
    int boxCnt = box.count();
    if (boxCnt != 0) {
      Query<T> query = box.query().build()
        ..offset = boxCnt - 1
        ..limit = 1;
      return query.find().last;
    }
    return null;
  }

  Future<List<T>?> getAll<T>() async {
    final Box<T> box = store.box<T>();
    return box.getAll();
  }
}
