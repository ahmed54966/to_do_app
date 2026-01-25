import 'package:flutter/material.dart';
import 'package:to_do_app/model/my_user.dart';

class AuthUserProvider extends ChangeNotifier{
  MyUser? currentUser;

  void updateUser (MyUser newUser){
  currentUser = newUser ;
  notifyListeners();
  }



}