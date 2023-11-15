import 'package:second_brain/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<int?> createTask({required TaskEntity task});
  Future<TaskEntity?> getTask({required String uuid});
  Future<List<TaskEntity>?> listTasksUser({required String userUuid});
  Future<int?> updateTask({required TaskEntity task});
  Future<bool> deleteTasksUser({required String userUuid});
  Future<bool> deleteTask({required String uuid});
}
