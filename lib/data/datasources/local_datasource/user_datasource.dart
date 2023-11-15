import 'package:second_brain/data/datasources/local_datasource/local_database.dart';
import 'package:second_brain/data/models/user_model.dart';
import 'package:second_brain/objectbox.g.dart';

class UserDataSource {
  final AppLocalDatabase appDB;
  UserDataSource(this.appDB);

  Future<int?> createUser(UserModel data) async {
    return appDB.insert<UserModel>(data);
  }

  Future<UserModel?> getUser(String uuid) async {
    return appDB.store
        .box<UserModel>()
        .query(UserModel_.uuid.equals(uuid))
        .build()
        .findUnique();
  }

  Future<UserModel?> getLastUser() async {
    return appDB.getLast();
  }

  Future<int?> updateUser(UserModel userData) async {
    // print('New user: ${userData.name!}');
    // List<UserModel>? list = await listUser();
    // if (list != null) {
    //   for (var user in list) {
    //     if (user.name != null) {
    //       print('Get user ${user.name} with uuid ${user.uuid}');
    //     }
    //   }
    // } else {
    //   print('No user on DB');
    // }
    // UserModel? oldUser = await getUser(userData.uuid);
    return appDB.insert<UserModel>(userData);
    // print('old user: ${oldUser!.name}');
    // if (oldUser == null) {
    //   return appDB.insert<UserModel>(userData);
    // } else {
    //   return appDB.insert<UserModel>(oldUser);
    // }
  }

  Future<bool> deleteUser(String uuid) async {
    // TODO: Change using Unique ID from objectbox to not get the user
    UserModel? userData = await getUser(uuid);
    if (userData != null) {
      return appDB.remove<UserModel>(userData.id!);
    }
    return false;
  }

  Future<List<UserModel>?> listUser() {
    return appDB.getAll<UserModel>();
  }
}
