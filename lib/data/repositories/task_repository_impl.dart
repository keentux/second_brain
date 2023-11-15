import 'package:second_brain/data/datasources/local_datasource/task_datasource.dart';
import 'package:second_brain/data/models/task_model.dart';
import 'package:second_brain/domain/entities/task_entity.dart';
import 'package:second_brain/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource dataSource;
  TaskRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<int?> createTask({required TaskEntity task}) async {
    return await dataSource.createTask(TaskModel.fromEntity(task));
  }

  @override
  Future<bool> deleteTask({required String uuid}) {
    return dataSource.deleteTask(uuid);
  }

  @override
  Future<bool> deleteTasksUser({required String userUuid}) async {
    return await dataSource.deleteTasksUser(userUuid);
  }

  @override
  Future<TaskEntity?> getTask({required String uuid}) async {
    TaskModel? result = await dataSource.getTask(uuid);
    return result?.mapToEntity();
  }

  @override
  Future<List<TaskEntity>?> listTasksUser({required String userUuid}) async {
    List<TaskModel>? result = await dataSource.listTaskUser(userUuid);
    if ((result?.length ?? 0) == 0) {
      return null;
    }
    return result?.map((TaskModel model) => model.mapToEntity()).toList();
  }

  @override
  Future<int?> updateTask({required TaskEntity task}) async {
    return await dataSource.updateTask(TaskModel.fromEntity(task));
  }
}
