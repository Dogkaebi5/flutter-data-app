import 'package:flutter/material.dart';

class UserBasicData extends ChangeNotifier {
  String _nickname = "홍길동";
  String _email = "example@example.com";
  
  String? _married, _childHas, _education, _occupation, _income, _residence;
  String? _marriedDate, _childHasDate, _educationDate, _occupationDate, _incomeDate, _residenceDate;
  List _isPermitBasicDatas = List.filled(6, false);


  String get nickname => _nickname;
  String get email => _email;
  List get selected => [ _married, _childHas, _education, _occupation, _income, _residence];
  List get selectedDate => [_marriedDate, _childHasDate, _educationDate, _occupationDate, _incomeDate, _residenceDate];
  List get basicPermissions => _isPermitBasicDatas;


  void setNickname(String nickname){_nickname = nickname; notifyListeners();}
  void setEmail(String email){_email = email; notifyListeners();}
  void setBasicpermissions(list){_isPermitBasicDatas = List.from(list); notifyListeners();}
  
  void setMarried(String? value, String? date){
    _married = value; 
    _marriedDate = date;
    if(value != null){_isPermitBasicDatas[0] = true;}
    notifyListeners();
  }
  void setChildHas(String? value, String? date){
    _childHas = value; 
    _childHasDate = date;
    if(value != null) {_isPermitBasicDatas[1] = true;}
    notifyListeners();
  }
  void setEducation(String? value, String? date){
    _education = value; 
    _educationDate = date;
    if(value != null) {_isPermitBasicDatas[2] = true;}
    notifyListeners();
  }
  void setOccupation(String? value, String? date){
    _occupation = value; 
    _occupationDate = date;
    if(value != null) {_isPermitBasicDatas[3] = true;}
    notifyListeners();
  }
  void setIncome(String? value, String? date){
    _income = value; 
    _incomeDate = date;
    if(value != null) {_isPermitBasicDatas[4] = true;}
    notifyListeners();
  }
  void setResidence(String? value, String? date){
    _residence = value; 
    _residenceDate = date;
    if(value != null) {_isPermitBasicDatas[5] = true;}
    notifyListeners();
  }
  
 
}