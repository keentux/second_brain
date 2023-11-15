import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_brain/core/base_components/base_params_usecase.dart';
import 'package:second_brain/domain/entities/user_entities.dart';
import 'package:second_brain/domain/usecases/task_usecase.dart';
import 'package:second_brain/domain/usecases/user_usecases.dart';
import 'package:second_brain/presentation/cubit/task_cubit.dart';
import 'package:second_brain/utils/locator.dart';

class UserCubit extends Cubit<UserEntity?> {
  UserCubit() : super(null);

  Future<void> getLastUser() async {
    emit(await locator<GetLastUser>().call(NoParams()));
    if (state != null) locator<TaskCubit>().getTasksUser(state!.uuid);
  }

  Future<void> createUser(UserEntity newUser) async {
    await locator<CreateUser>().call(newUser);
    emit(newUser);
  }

  Future<void> updateUser(UserEntity newUser) async {
    await locator<UpdateUser>().call(newUser);
    emit(newUser);
  }

  Future<void> deleteUser(UserEntity user) async {
    await locator<DeleteTasksUser>().call(user.uuid);
    await locator<DeleteUser>().call(user.uuid);
    emit(await locator<GetLastUser>().call(NoParams()));
  }
}
