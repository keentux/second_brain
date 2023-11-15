import 'package:second_brain/core/base_components/base_params_usecase.dart';
import 'package:second_brain/domain/entities/task_entity.dart';
import 'package:second_brain/domain/repositories/task_repository.dart';

class CreateTask implements DBBaseParamsUseCase<int?, TaskEntity> {
  final TaskRepository taskRepository;
  CreateTask(this.taskRepository);

  @override
  Future<int?> call(TaskEntity entity) {
    return taskRepository.createTask(task: entity);
  }
}

class GatTask implements DBBaseParamsUseCase<TaskEntity?, String> {
  final TaskRepository taskRepository;
  GatTask(this.taskRepository);

  @override
  Future<TaskEntity?> call(String input) {
    return taskRepository.getTask(uuid: input);
  }
}

class ListTaskUser implements DBBaseParamsUseCase<List<TaskEntity?>?, String> {
  final TaskRepository taskRepository;
  ListTaskUser(this.taskRepository);

  @override
  Future<List<TaskEntity>?> call(String userUuid) {
    return taskRepository.listTasksUser(userUuid: userUuid);
  }
}

class UpdateTask implements DBBaseParamsUseCase<int?, TaskEntity> {
  final TaskRepository taskRepository;
  UpdateTask(this.taskRepository);

  @override
  Future<int?> call(TaskEntity input) {
    return taskRepository.updateTask(task: input);
  }
}

class DeleteTasksUser implements DBBaseParamsUseCase<bool, String> {
  final TaskRepository taskRepository;
  DeleteTasksUser(this.taskRepository);

  @override
  Future<bool> call(String params) {
    return taskRepository.deleteTasksUser(userUuid: params);
  }
}

class DeleteTask implements DBBaseParamsUseCase<bool, String> {
  final TaskRepository taskRepository;
  DeleteTask(this.taskRepository);

  @override
  Future<bool> call(String input) {
    return taskRepository.deleteTask(uuid: input);
  }
}
