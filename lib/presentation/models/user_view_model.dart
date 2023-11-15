import 'dart:async';

import 'package:flutter/material.dart';
import 'package:second_brain/core/base_components/base_params_usecase.dart';
import 'package:second_brain/domain/entities/user_entities.dart';
import 'package:second_brain/domain/usecases/user_usecases.dart';

class UserViewModel extends ChangeNotifier {
  final GetLastUser getLastUserData;

  UserViewModel({
    required this.getLastUserData,
  });

  final StreamController<UserEntity?> _userResult =
      StreamController<UserEntity?>.broadcast();

  StreamController<UserEntity?> get userResult => _userResult;

  Future<void> getLastUser() async {
    _userResult.add(await getLastUserData.call(NoParams()));
  }

  @override
  void dispose() {
    _userResult.close();
    super.dispose();
  }
}
