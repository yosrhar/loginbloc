import 'package:flutter/material.dart';
import 'package:loginbloc/Authentification/repositories/auth/auth_repository.dart';
import 'package:loginbloc/user_model.dart';



class UserProvider with ChangeNotifier {
  User _user= User.defaultUser();
  final AuthRepository _authRepository = AuthRepository();

  User get getUser => _user;

  Future<void> refreshUser({User? user}) async {
   if (user != null) {
      _user = user;
      print('User updated from external source: ${_user?.username}');
    } else {
      _user = await _authRepository.getUserDetails();
      print('User fetched from Firebase: ${_user?.username}');
    }
    notifyListeners();
  }
}


