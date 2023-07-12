import 'package:flutter/material.dart';

class UserInterestData extends ChangeNotifier {
  String? _interest1, _interest2, _interest3;
  String? _interest1Date, _interest2Date, _interest3Date;

  List get interest => [_interest1, _interest2, _interest3];
  List get interestDate => [_interest1Date, _interest2Date, _interest3Date];

  
  void setInterest1(interest1){_interest1 = interest1; notifyListeners();}
  void setInterest2(interest2){_interest2 = interest2; notifyListeners();}
  void setInterest3(interest3){_interest3 = interest3; notifyListeners();}

  void setInterest1Date(interest1Date){_interest1Date = interest1Date; notifyListeners();}
  void setInterest2Date(interest2Date){_interest2Date = interest2Date; notifyListeners();}
  void setInterest3Date(interest3Date){_interest3Date = interest3Date; notifyListeners();}
}