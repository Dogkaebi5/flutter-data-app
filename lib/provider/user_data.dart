import 'dart:js_interop';

import 'package:data_project/data/question.dart';
import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  //personal
  String name = "홍길동";
  String sex = "남";
  String bitrhY = "2000";
  String _mobile = "010-1234-5678";
  //account
  int _password = 1;
  String? _bank;
  String? _account;
  bool _isHasAcc = false;
  int _point = 0;
  get bank => [_isHasAcc, name, _bank, _account];
  void setBank(bank, account) {
    _bank = bank;
    _account = account;
    _isHasAcc = true;
  }
    //permissions
  List _permissions = [false, false, false, false];
  bool _tmPermission = false;
  List _basicPermission = List.filled(Questions().basicInfo.length, false);
  List _interestPermissions = [true, true, true];
  get permissions => [_permissions, _tmPermission, ..._basicPermission,  ..._interestPermissions];
  void setPermissions(list){
    _permissions = list.sublsit(0, 4);
    _tmPermission = list[4];
    _basicPermission = list.sublsit(5, 12);
    _interestPermissions = list.sublsit(12);
  }
  //flexible basic
  String? _nickname;
  String? _email;
  get flexBasicData => [(_nickname == "")?name:_nickname, _email];
  void setFlexBasicData(nickname, email) {
    _nickname = nickname;
    _email = email;
  }
  //basic
  List _marriedData = ["", ""];
  List _childData = ["", ""];
  List _educationData = ["", ""];
  List _occupationData = ["", ""];
  List _incomeData = ["", ""];
  List _residenceData = ["", ""];
  List _areaData = ["", ""];
  get basicData => [_marriedData, _childData, _educationData, _occupationData, _incomeData, _residenceData, _areaData];
  void setBasicData(data){
    String date = DateTime.now().toString().split(" ")[0];
    if(data[0] != _marriedData[2]){_marriedData = [date, data[0]];} 
    if(data[1] != _childData[2]){_childData = [date, data[1]];} 
    if(data[2] != _educationData[2]){_educationData = [date, data[2]];} 
    if(data[3] != _occupationData[2]){_occupationData = [date, data[3]];} 
    if(data[4] != _incomeData[2]){_incomeData = [date, data[4]];} 
    if(data[5] != _residenceData[2]){_residenceData = [date, data[5]];} 
    if(data[6] != _areaData[2]){_areaData = [date, data[6]];} 
  }
  //interest
  List _interestSelecteds = ["","",""];
  List _interestSelectedDates = ["","",""];
  get interests => [_interestSelecteds, _interestSelectedDates];
  void setInterest(List data){
    String date = DateTime.now().toString().split(" ")[0];
    for(int i = 0; i < data.length; i++){
      _interestSelecteds[i] = data[i];
      _interestSelectedDates[i] = date;
      _interestPermissions[i] = true;
    }
  }
  //additional
  List? _insurance = List.filled(0, "");
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
  
  get additionals {
    List add = [
      _insurance, _loan, _deposit, 
      _immovables, _stock, _cryto, 
      _golf, _tennis, _fitness, 
      _yoga, _dietary, _educate,
      _parental, _automobile, _localTrip,
      _overseatrip, _camp, _fishing,
      _pet];
    int select1 = _interestSelecteds[0]??-1;
    int select2 = _interestSelecteds[1]??-1;
    int select3 = _interestSelecteds[2]??-1;

    if(select1 == -1){
      return null;
    }else if (select2 == -1){
      return [add[select1]];
    }else if (select3 == -1){
      return [add[select1], add[select2]];
    }else {
      return [add[select1], add[select2], add[select3]];
    }
  }

  
}