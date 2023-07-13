import 'package:flutter/material.dart';

class UserInterestData extends ChangeNotifier {
  List _selectedList = List.empty(growable: true);
  List _dateList = List.empty(growable: true);
  List<bool> _isSelectedList = List.filled(19, false);
  int _interestCount = 0;
  
  List get selectedList => _selectedList;
  List get dateList => _dateList;
  List get isSelectedList => _isSelectedList;
  int get interestCount => _interestCount;

  void setSelecedList(list){_selectedList = List.from(list); notifyListeners();}
  void setdateList(list){_dateList = List.from(list); notifyListeners();}
  void setIsSelectedList(list){_isSelectedList = List.from(list);notifyListeners();}
  void setCount(count){_interestCount = count; notifyListeners();}
}