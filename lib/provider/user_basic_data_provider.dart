import 'package:data_project/data/question.dart';
import 'package:data_project/provider/setting_provider.dart';
import 'package:flutter/material.dart';

class UserBasicData extends ChangeNotifier {
  String _nickname = "";
  String _email = "example@example.com";
  
  String? _married, _childHas, _education, _occupation, _income, _residence, _area;
  String? _marriedDate, _childHasDate, _educationDate, _occupationDate, _incomeDate, _residenceDate;
  List _isPermitBasicDatas = List.filled(Questions().basicInfo.length + 2, false);
  
  String get nickname => (_nickname == "")?SettingProvider().userName :_nickname;
  String get email => _email;
  List get selected => [ _married, _childHas, _education, _occupation, _income, _residence, _area];
  List get selectedDate => [_marriedDate, _childHasDate, _educationDate, _occupationDate, _incomeDate, _residenceDate];
  List get basicPermissions => _isPermitBasicDatas;


  void setNickname(String nickname){_nickname = nickname; notifyListeners();}
  void setEmail(String email){_email = email; notifyListeners();}
  void setPermissions(list){_isPermitBasicDatas = List.from(list); notifyListeners();}
  
  void setData(data){
    if(data[0] != _married){setMarried(data[0]);}
    if(data[1] != _childHas){setChildHas(data[1]);}
    if(data[2] != _education){setEducation(data[2]);}
    if(data[3] != _occupation){setOccupation(data[3]);}
    if(data[4] != _income){setIncome(data[4]);}
    if(data[5] != _residence){setResidence(data[5]);}
    if(data[6] != _area){setArea(data[6]);}
    notifyListeners();
  }
  void setMarried(String? value){
    _married = value; 
    _marriedDate = DateTime.now().toString().split(" ")[0]; 
    _isPermitBasicDatas[0] = true;
  }
  void setChildHas(String? value){
    _childHas = value; 
    _childHasDate = DateTime.now().toString().split(" ")[0];
    _isPermitBasicDatas[1] = true;
  }
  void setEducation(String? value){
    _education = value; 
    _educationDate = DateTime.now().toString().split(" ")[0];
    _isPermitBasicDatas[2] = true;
  }
  void setOccupation(String? value){
    _occupation = value; 
    _occupationDate = DateTime.now().toString().split(" ")[0];
    _isPermitBasicDatas[3] = true;
  }
  void setIncome(String? value){
    _income = value; 
    _incomeDate = DateTime.now().toString().split(" ")[0];
    _isPermitBasicDatas[4] = true;
  }
  void setResidence(String? value){
    _residence = value; 
    _residenceDate = DateTime.now().toString().split(" ")[0];
    _isPermitBasicDatas[5] = true;
  }
  void setArea(String? value) {
    _area = value;
    _residenceDate = DateTime.now().toString().split(" ")[0];
    _isPermitBasicDatas[6] = true;
  }
}