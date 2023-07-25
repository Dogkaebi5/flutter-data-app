import 'package:data_project/data/question.dart';
import 'package:flutter/material.dart';

class UserInterestData extends ChangeNotifier {
  Map questions = Questions().interests;
  List interests = Questions().interests.keys.toList();
  
  List _selecteds = List.empty(growable: true);
  List _selectedDates = List.empty(growable: true);

  List<bool> _isSelecteds = List.filled(Questions().interests.keys.toList().length, false);
  List<bool> _isPermissions = List.filled(Questions().interests.keys.toList().length, true);

  List? _insurance = List.empty(growable: true);
  List? _loan = List.empty(growable: true);
  List? _deposit = List.empty(growable: true);
  List? _immovables = List.empty(growable: true);
  List? _stock = List.empty(growable: true);
  List? _cryto = List.empty(growable: true);
  List? _golf = List.empty(growable: true);
  List? _tennis = List.empty(growable: true);
  List? _fitness = List.empty(growable: true);
  List? _yoga = List.empty(growable: true);
  List? _dietary = List.empty(growable: true);
  List? _educate = List.empty(growable: true);
  List? _parental = List.empty(growable: true);
  List? _automobile = List.empty(growable: true);
  List? _localTrip = List.empty(growable: true);
  List? _overseatrip = List.empty(growable: true);
  List? _camp = List.empty(growable: true);
  List? _fishing = List.empty(growable: true);
  List? _pet = List.empty(growable: true);

  get additionalData => {
    "보험설계": _insurance,
    "대출": _loan,
    "예금/적금": _deposit, 
    "부동산": _immovables, 
    "주식": _stock, 
    "가상자산": _cryto, 
    "골프": _golf, 
    "테니스": _tennis, 
    "피트니스": _fitness, 
    "요가": _yoga, 
    "건강식품": _dietary, 
    "교육": _educate, 
    "육아용품": _parental, 
    "자동차": _automobile, 
    "국내여행": _localTrip, 
    "해외여행": _overseatrip, 
    "캠핑": _camp, 
    "낚시": _fishing, 
    "반려동물": _pet
  };

  List get selecteds => _selecteds;
  List get isSelecteds => _isSelecteds;
  List get selectedDates => _selectedDates;

  setInsurance(answers){
    _insurance = List.from(answers);
  }
  setLoan(answers){
    _loan = List.from(answers);
  }
  setDeposit(answers){
    _deposit = List.from(answers);
  }
  setImmovables(answers){
    _immovables = List.from(answers);
  }
  setStock(answers){
    _stock = List.from(answers);
  }
  setCryto(answers){
    _cryto = List.from(answers);
  }
  setGolf(answers){
    _golf = List.from(answers);
  }
  setTennis(answers){
    _tennis = List.from(answers);
  }
  setFitness(answers){
    _fitness = List.from(answers);
  }
  setYoga(answers){
    _yoga = List.from(answers);
  }
  setDietary(answers){
    _dietary = List.from(answers);
  }
  setEducate(answers){
    _educate = List.from(answers);
  }
  setParental(answers){
    _parental = List.from(answers);
  }
  setAutomobile(answers){
    _automobile = List.from(answers);
  }
  setLocalTrip(answers){
    _localTrip = List.from(answers);
  }
  setOverseatrip(answers){
    _overseatrip = List.from(answers);
  }
  setCamp(answers){
    _camp = List.from(answers);
  }
  setFishing(answers){
    _fishing = List.from(answers);
  }
  setPet(answers){
    _pet = List.from(answers);
  }



  
  List _addData = [List.empty(growable: true), List.empty(growable: true), List.empty(growable: true)];
  //temporary list//create class
  


  List get interestPermissions => _isPermissions;

  List get addData => _addData;

  void setSeleceds(list){_selecteds = List.from(list);}
  void setDates(list){_selectedDates = List.from(list);}
  void setIsSelecteds(list){_isSelecteds = List.from(list);}
  void setAdd(list){_addData = List.from(list);}
  void setPermissions(list) => _isPermissions = List.from(list); 
}