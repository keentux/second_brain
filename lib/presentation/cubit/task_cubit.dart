import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:second_brain/domain/entities/task_entity.dart';
import 'package:second_brain/domain/usecases/task_usecase.dart';
import 'package:second_brain/utils/locator.dart';

class TaskCubit extends Cubit<List<TaskEntity>?> {
  TaskCubit() : super([]);

  Future<void> createTask(TaskEntity newTask) async {
    await locator<CreateTask>().call(newTask);
    if (state == null) {
      return emit(<TaskEntity>[newTask]);
    } else {
      List<TaskEntity> updatedList = List.from(state!, growable: true);
      updatedList.add(newTask);
      return emit(updatedList);
    }
  }

  Future<void> getTasksUser(String uuid) async {
    emit(await locator<ListTaskUser>().call(uuid));
  }

  Future<void> updateTask(TaskEntity newTask) async {
    await locator<UpdateTask>().call(newTask);
    if (state != null) {
      List<TaskEntity>? listTask = [...state!];
      listTask[state!.indexWhere((element) => element.uuid == newTask.uuid)] =
          newTask;
      emit(listTask);
    }
  }

  Future<void> deleteTask(String uuid) async {
    await locator<DeleteTask>().call(uuid);
    if (state != null) {
      List<TaskEntity> updatedList = List.from(state!, growable: true);
      updatedList
          .removeAt(state!.indexWhere((element) => element.uuid == uuid));
      emit(updatedList);
    }
  }
}
