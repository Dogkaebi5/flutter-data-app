import 'package:data_project/data/question.dart';
import 'package:flutter/material.dart';

class UserBasicData extends ChangeNotifier {
  String _nickname = "홍길동";
  String _email = "example@example.com";
  
  String? _married, _childHas, _education, _occupation, _income, _residence, _area;
  String? _marriedDate, _childHasDate, _educationDate, _occupationDate, _incomeDate, _residenceDate;
  List _isPermitBasicDatas = List.filled(Questions().basicInfo.length + 2, false);
  String get nickname => _nickname;
  String get email => _email;
  List get selected => [ _married, _childHas, _education, _occupation, _income, _residence, _area];
  List get selectedDate => [_marriedDate, _childHasDate, _educationDate, _occupationDate, _incomeDate, _residenceDate];
  List get basicPermissions => _isPermitBasicDatas;

  void setNickname(String nickname){_nickname = nickname; notifyListeners();}
  void setEmail(String email){_email = email; notifyListeners();}
  void setBasicpermissions(list){_isPermitBasicDatas = List.from(list); notifyListeners();}
  
  void setMarried(String? value){
    _married = value; 
    if(value != null){_isPermitBasicDatas[0] = true;}
    notifyListeners();
  }
  void setChildHas(String? value){
    _childHas = value; 
    if(value != null) {_isPermitBasicDatas[1] = true;}
    notifyListeners();
  }
  void setEducation(String? value){
    _education = value; 
    if(value != null) {_isPermitBasicDatas[2] = true;}
    notifyListeners();
  }
  void setOccupation(String? value){
    _occupation = value; 
    if(value != null) {_isPermitBasicDatas[3] = true;}
    notifyListeners();
  }
  void setIncome(String? value){
    _income = value; 
    if(value != null) {_isPermitBasicDatas[4] = true;}
    notifyListeners();
  }
  void setResidence(String? value){
    _residence = value; 
    if(value != null) {_isPermitBasicDatas[5] = true;}
    notifyListeners();
  }
  void setArea(String? value) {
    _area = value;
    if(value != null) {_isPermitBasicDatas[6] = true;}
  }
}