import 'package:flutter/material.dart';

class UserInterestData extends ChangeNotifier {
  List _selectedList = List.empty(growable: true);
  List _dateList = List.empty(growable: true);
  List<bool> _isSelectedList = List.filled(19, false);
  int _interestCount = 0;

  List _addData = [
    List.empty(growable: true), 
    List.empty(growable: true), 
    List.empty(growable: true)
  ];
  //임시 데이터, 실제 각 문제별 테이블 생성
  
  List get selectedList => _selectedList;
  List get dateList => _dateList;
  List get isSelectedList => _isSelectedList;
  int get interestCount => _interestCount;

  List get addData => _addData;

  void setSelecedList(list){_selectedList = List.from(list); notifyListeners();}
  void setdateList(list){_dateList = List.from(list); notifyListeners();}
  void setIsSelectedList(list){_isSelectedList = List.from(list); notifyListeners();}
  void setCount(count){_interestCount = count; notifyListeners();}

  void setAdd(list){_addData = List.from(list); notifyListeners();}
}