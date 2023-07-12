import 'package:flutter/material.dart';

class NewUserProvider extends ChangeNotifier {
  bool _isNewUser = true;
  bool get isNewUser => _isNewUser; 
  void notNewUser(){
    _isNewUser = false;
    notifyListeners();
  }
  void setNewUser(String newPassword){
    _isNewUser = true;
    notifyListeners();
  }
}

class UserData extends ChangeNotifier {
  String _nickname = "홍길동";
  String _email = "example@example.com";
  String? _married, _childHas, _education, _occupation, _income, _residence;
  String? _marriedDate, _childHasDate, _educationDate, _occupationDate, _incomeDate, _residenceDate;

  String get nickname => _nickname;
  String get email => _email;
  List get selected => [ _married, _childHas, _education, _occupation, _income, _residence];
  List get selectedDate => [_marriedDate, _childHasDate, _educationDate, _occupationDate, _incomeDate, _residenceDate];

  void setNickname(String nickname){_nickname = nickname; notifyListeners();}
  void setEmail(String email){_email = email; notifyListeners();}
  void setMarried(String married){_married = married; notifyListeners();}
  void setChildHas(String childHas){_childHas = childHas; notifyListeners();}
  void setEducation(String education){_education = education; notifyListeners();}
  void setOccupation(String occupation){_occupation = occupation; notifyListeners();}
  void setIncome(String income){_income = income; notifyListeners();}
  void setResidence(String residence){_residence = residence; notifyListeners();}
  void setMarriedDate(String marriedDate){_marriedDate = marriedDate; notifyListeners();}
  void setChildHasDate(String childHasDate){_childHasDate = childHasDate; notifyListeners();}
  void setEducationDate(String educationDate){_educationDate = educationDate; notifyListeners();}
  void setOccupationDate(String occupationDate){_occupationDate = occupationDate; notifyListeners();}
  void setIncomeDate(String incomeDate){_incomeDate = incomeDate; notifyListeners();}
  void setResidenceDate(String residenceDate){_residenceDate = residenceDate; notifyListeners();}
}