import 'package:flutter/material.dart';

class NewUserProvider extends ChangeNotifier {
  bool _isNewUser = true;
  bool get isNewUser => _isNewUser; 
  void notNewUser(){
    _isNewUser = false;
    notifyListeners();
  }
  void setNewUser(){
    _isNewUser = true;
    notifyListeners();
  }
}

