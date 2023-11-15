import 'package:second_brain/domain/entities/user_entities.dart';

abstract class UserRepository {
  Future<int?> createUser({required UserEntity user});
  Future<UserEntity?> getUser({required String uuid});
  Future<UserEntity?> getLastUser();
  Future<int?> updateUser({required UserEntity user});
  Future<bool> deleteUser({required String uuid});
  Future<List<UserEntity?>?> listUser();
}
