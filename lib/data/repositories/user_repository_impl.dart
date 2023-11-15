import 'package:second_brain/data/datasources/local_datasource/user_datasource.dart';
import 'package:second_brain/data/models/user_model.dart';
import 'package:second_brain/domain/entities/user_entities.dart';
import 'package:second_brain/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;
  UserRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<int?> createUser({required UserEntity user}) async {
    return await dataSource.createUser(UserModel.fromEntity(user));
  }

  @override
  Future<UserEntity?> getUser({required String uuid}) async {
    UserModel? result = await dataSource.getUser(uuid);
    return result?.mapToEntity();
  }

  @override
  Future<UserEntity?> getLastUser() async {
    UserModel? result = await dataSource.getLastUser();
    return result?.mapToEntity();
  }

  @override
  Future<int?> updateUser({required UserEntity user}) async {
    return await dataSource.updateUser(UserModel.fromEntity(user));
  }

  @override
  Future<bool> deleteUser({required String uuid}) async {
    return await dataSource.deleteUser(uuid);
  }

  @override
  Future<List<UserEntity?>?> listUser() async {
    List<UserModel>? result = await dataSource.listUser();
    if ((result?.length ?? 0) > 0) {
      return result?.map((UserModel element) => element.mapToEntity()).toList();
    }
    return null;
  }
}
