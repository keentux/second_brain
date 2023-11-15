import 'package:second_brain/domain/entities/user_entities.dart';
import 'package:second_brain/domain/repositories/user_repository.dart';
import 'package:second_brain/core/base_components/base_params_usecase.dart';

class CreateUser implements DBBaseParamsUseCase<int?, UserEntity> {
  final UserRepository userRepository;
  CreateUser(this.userRepository);

  @override
  Future<int?> call(UserEntity input) {
    return userRepository.createUser(user: input);
  }
}

class GetUser implements DBBaseParamsUseCase<UserEntity?, String> {
  final UserRepository userRepository;
  GetUser(this.userRepository);

  @override
  Future<UserEntity?> call(String input) {
    return userRepository.getUser(uuid: input);
  }
}

class GetLastUser implements DBBaseParamsUseCase<UserEntity?, NoParams> {
  final UserRepository userRepository;
  GetLastUser(this.userRepository);

  @override
  Future<UserEntity?> call(NoParams input) {
    return userRepository.getLastUser();
  }
}

class UpdateUser implements DBBaseParamsUseCase<int?, UserEntity> {
  final UserRepository userRepository;
  UpdateUser(this.userRepository);

  @override
  Future<int?> call(UserEntity input) {
    return userRepository.updateUser(user: input);
  }
}

class DeleteUser implements DBBaseParamsUseCase<bool, String> {
  final UserRepository userRepository;
  DeleteUser(this.userRepository);

  @override
  Future<bool> call(String input) {
    return userRepository.deleteUser(uuid: input);
  }
}

class ListUser implements DBBaseParamsUseCase<List<UserEntity?>?, NoParams> {
  final UserRepository userRepository;
  ListUser(this.userRepository);

  @override
  Future<List<UserEntity?>?> call(NoParams input) {
    return userRepository.listUser();
  }
}
