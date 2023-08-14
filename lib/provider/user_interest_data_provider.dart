import 'package:data_project/data/question.dart';
import 'package:flutter/material.dart';

String? _tempString;
const String insurance = "보험설계";
const String loan = "대출";
const String deposit = "예금/적금";
const String immovables = "부동산";
const String stock = "주식";
const String cryto = "가상자산";
const String golf = "골프";
const String tennis = "테니스";
const String fitness = "피트니스";
const String yoga = "요가";
const String dietary = "건강식품";
const String educate = "교육";
const String parental = "육아용품";
const String automobile = "자동차";
const String localTrip = "국내여행";
const String overseatrip = "해외여행";
const String camp = "캠핑";
const String fishing = "낚시";
const String pet = "반려동물";

class UserInterestData extends ChangeNotifier {
  Map questions = Questions().interestQuestions;
  List interests = Questions().interestQuestions.keys.toList();
  List _selecteds = List.empty(growable: true);
  List _selectedDates = List.empty(growable: true);
  List<bool> _isPermissions = List.empty(growable: true);
  List<bool> _isSelecteds = List.filled(Questions().interestQuestions.keys.toList().length, false);
  
  List _insurance = List.filled(Questions().interestQuestions["보험설계"]!.length, _tempString);
  List _loan = List.filled(Questions().interestQuestions["대출"]!.length, _tempString);
  List _deposit = List.filled(Questions().interestQuestions["예금/적금"]!.length, _tempString);
  List _immovables = List.filled(Questions().interestQuestions["부동산"]!.length, _tempString);
  List _stock = List.filled(Questions().interestQuestions["주식"]!.length, _tempString);
  List _cryto = List.filled(Questions().interestQuestions["가상자산"]!.length, _tempString);
  List _golf = List.filled(Questions().interestQuestions["골프"]!.length, _tempString);
  List _tennis = List.filled(Questions().interestQuestions["테니스"]!.length, _tempString);
  List _fitness = List.filled(Questions().interestQuestions["피트니스"]!.length, _tempString);
  List _yoga = List.filled(Questions().interestQuestions["요가"]!.length, _tempString);
  List _dietary = List.filled(Questions().interestQuestions["건강식품"]!.length, _tempString);
  List _educate = List.filled(Questions().interestQuestions["교육"]!.length, _tempString);
  List _parental = List.filled(Questions().interestQuestions["육아용품"]!.length, _tempString);
  List _automobile = List.filled(Questions().interestQuestions["자동차"]!.length, _tempString);
  List _localTrip = List.filled(Questions().interestQuestions["국내여행"]!.length, _tempString);
  List _overseatrip = List.filled(Questions().interestQuestions["해외여행"]!.length, _tempString);
  List _camp = List.filled(Questions().interestQuestions["캠핑"]!.length, _tempString);
  List _fishing = List.filled(Questions().interestQuestions["낚시"]!.length, _tempString);
  List _pet = List.filled(Questions().interestQuestions["반려동물"]!.length, _tempString);

  Map<String, List> get additionalData => {
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
  List get permissions => _isPermissions;

  void setSeleceds(list){_selecteds = List.from(list);}
  void setDates(list){_selectedDates = List.from(list);}
  void setIsSelecteds(list){_isSelecteds = List.from(list);}
  void setPermissions(list) => _isPermissions = List.from(list); 

  void setData(list){
    
  }

  void setInsurance(answers) => _insurance = List.from(answers);
  void setLoan(answers) => _loan = List.from(answers);
  void setDeposit(answers) => _deposit = List.from(answers);
  void setImmovables(answers) => _immovables = List.from(answers);
  void setStock(answers) => _stock = List.from(answers);
  void setCryto(answers) => _cryto = List.from(answers);
  void setGolf(answers) => _golf = List.from(answers);
  void setTennis(answers) => _tennis = List.from(answers);
  void setFitness(answers) => _fitness = List.from(answers);
  void setYoga(answers) => _yoga = List.from(answers);
  void setDietary(answers) => _dietary = List.from(answers);
  void setEducate(answers) => _educate = List.from(answers);
  void setParental(answers) => _parental = List.from(answers);
  void setAutomobile(answers) => _automobile = List.from(answers);
  void setLocalTrip(answers) => _localTrip = List.from(answers);
  void setOverseatrip(answers) => _overseatrip = List.from(answers);
  void setCamp(answers) => _camp = List.from(answers);
  void setFishing(answers) => _fishing = List.from(answers);
  void setPet(answers) => _pet = List.from(answers);

  void reset() {
    _selecteds = List.empty(growable: true);
    _selectedDates = List.empty(growable: true);
    _isPermissions = List.empty(growable: true);
    _isSelecteds = List.filled(Questions().interestQuestions.keys.toList().length, false);
    
    _insurance = List.filled(Questions().interestQuestions["보험설계"]!.length, _tempString);
    _loan = List.filled(Questions().interestQuestions["대출"]!.length, _tempString);
    _deposit = List.filled(Questions().interestQuestions["예금/적금"]!.length, _tempString);
    _immovables = List.filled(Questions().interestQuestions["부동산"]!.length, _tempString);
    _stock = List.filled(Questions().interestQuestions["주식"]!.length, _tempString);
    _cryto = List.filled(Questions().interestQuestions["가상자산"]!.length, _tempString);
    _golf = List.filled(Questions().interestQuestions["골프"]!.length, _tempString);
    _tennis = List.filled(Questions().interestQuestions["테니스"]!.length, _tempString);
    _fitness = List.filled(Questions().interestQuestions["피트니스"]!.length, _tempString);
    _yoga = List.filled(Questions().interestQuestions["요가"]!.length, _tempString);
    _dietary = List.filled(Questions().interestQuestions["건강식품"]!.length, _tempString);
    _educate = List.filled(Questions().interestQuestions["교육"]!.length, _tempString);
    _parental = List.filled(Questions().interestQuestions["육아용품"]!.length, _tempString);
    _automobile = List.filled(Questions().interestQuestions["자동차"]!.length, _tempString);
    _localTrip = List.filled(Questions().interestQuestions["국내여행"]!.length, _tempString);
    _overseatrip = List.filled(Questions().interestQuestions["해외여행"]!.length, _tempString);
    _camp = List.filled(Questions().interestQuestions["캠핑"]!.length, _tempString);
    _fishing = List.filled(Questions().interestQuestions["낚시"]!.length, _tempString);
    _pet = List.filled(Questions().interestQuestions["반려동물"]!.length, _tempString);
  }
}