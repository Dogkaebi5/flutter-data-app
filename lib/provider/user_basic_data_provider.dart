import 'package:data_project/provider/setting_provider.dart';
import 'package:flutter/material.dart';

class UserBasicData extends ChangeNotifier {
  String? _nickname = "";
  String? _email = "example@example.com";
  
  String? _married, _childHas, _education, _occupation, _income, _residence, _area;
  String? _marriedDate, _childHasDate, _educationDate, _occupationDate, _incomeDate, _residenceDate, _areaDate;
  
  bool _isMarriedPermit = false;
  bool _isChildHasPermit = false;
  bool _isEducationPermit = false;
  bool _isOccupationPermit = false;
  bool _isIncomePermit = false;
  bool _isResidencePermit = false;
  bool _isAreaPermit = false;
  
  String get nickname => (_nickname == "")?SettingProvider().userName :_nickname;
  String get email => _email?? "example@example.com";
  List get selected => [ _married, _childHas, _education, _occupation, _income, _residence, _area];
  List get selectedDate => [_marriedDate, _childHasDate, _educationDate, _occupationDate, _incomeDate, _residenceDate, _areaDate];
  List get basicPermissions => [_isMarriedPermit, _isChildHasPermit, _isEducationPermit, _isOccupationPermit, _isIncomePermit, _isResidencePermit, _isAreaPermit];


  void setNickname(String? nickname){_nickname = nickname; notifyListeners();}
  void setEmail(String? email){_email = email; notifyListeners();}
  void setPermissions(permits){
    _isMarriedPermit = permits[0];
    _isChildHasPermit = permits[1];
    _isEducationPermit = permits[2];
    _isOccupationPermit = permits[3];
    _isIncomePermit = permits[4];
    _isResidencePermit = permits[5];
    _isAreaPermit = permits[6];
  }
  
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
    _isMarriedPermit = true;
  }
  void setChildHas(String? value){
    _childHas = value; 
    _childHasDate = DateTime.now().toString().split(" ")[0];
    _isChildHasPermit = true;
  }
  void setEducation(String? value){
    _education = value; 
    _educationDate = DateTime.now().toString().split(" ")[0];
    _isEducationPermit = true;
  }
  void setOccupation(String? value){
    _occupation = value; 
    _occupationDate = DateTime.now().toString().split(" ")[0];
    _isOccupationPermit = true;
  }
  void setIncome(String? value){
    _income = value; 
    _incomeDate = DateTime.now().toString().split(" ")[0];
    _isIncomePermit = true;
  }
  void setResidence(String? value){
    _residence = value; 
    _residenceDate = DateTime.now().toString().split(" ")[0];
    _isResidencePermit = true;
  }
  void setArea(String? value) {
    _area = value;
    _areaDate = _residenceDate;
    _isAreaPermit = true;
  }

  void reset(){
    _nickname = "";
    _email = "example@example.com";
  
    _married = null;
    _childHas = null;
    _education = null;
    _occupation = null;
    _income = null;
    _residence = null;
    _area = null;
    _marriedDate = null;
    _childHasDate = null;
    _educationDate = null;
    _occupationDate = null;
    _incomeDate = null;
    _residenceDate = null;
    _area = null;
    
    _isMarriedPermit = false;
    _isChildHasPermit = false;
    _isEducationPermit = false;
    _isOccupationPermit = false;
    _isIncomePermit = false;
    _isResidencePermit = false;
    _isAreaPermit = false;
  }
}