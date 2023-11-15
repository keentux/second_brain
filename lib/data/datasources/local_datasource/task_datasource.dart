import 'package:second_brain/data/datasources/local_datasource/local_database.dart';
import 'package:second_brain/data/models/task_model.dart';
import 'package:second_brain/objectbox.g.dart';

class TaskDataSource {
  final AppLocalDatabase appDB;
  TaskDataSource(this.appDB);

  Future<int?> createTask(TaskModel data) async {
    return appDB.insert<TaskModel>(data);
  }

  Future<TaskModel?> getTask(String uuid) async {
    return appDB.store
        .box<TaskModel>()
        .query(TaskModel_.uuid.equals(uuid))
        .build()
        .findUnique();
  }

  Future<List<TaskModel>?> listTaskUser(String userUuid) async {
    // TODO: Add Timestand and order through id (.order(IaskModel_.createdAt).build())
    Query<TaskModel> query = appDB.store
        .box<TaskModel>()
        .query(TaskModel_.owner.equals(userUuid))
        .build();
    TaskModel? first = query.findFirst();
    if (first == null) return null;
    return query.find();
  }

  Future<int?> updateTask(TaskModel data) async {
    return appDB.insert<TaskModel>(data);
  }

  Future<bool> deleteTask(String uuid) async {
    TaskModel? data = await getTask(uuid);
    if (data != null) {
      return appDB.remove<TaskModel>(data.id!);
    }
    return false;
  }

  Future<bool> deleteTasksUser(String userUuid) async {
    Query<TaskModel> query = appDB.store
        .box<TaskModel>()
        .query(TaskModel_.owner.equals(userUuid))
        .build();
    return query.remove() > 0;
  }
}
