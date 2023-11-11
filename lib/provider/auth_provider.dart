import 'package:flutter/material.dart';
import 'package:lite_jobs/models/user_model.dart';

import '../server/auth/auth_functions.dart';

class AuthProvider extends ChangeNotifier {
  String? uid;

  final AuthenticationMethods _authMeth = AuthenticationMethods();
  UserModel? _userModel;
  UserModel get getUserModel => _userModel!;

  Future<void> refreshUser() async {
    UserModel user = await _authMeth.getUserDetails();
    _userModel = user;
    notifyListeners();
  }

  setUid(newUid) {
    uid = newUid;
    notifyListeners();
  }
}
