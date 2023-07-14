import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier {
  bool _isNoticeService = false;
  bool _isNoticeMarketing = false;
  List _isPermitUserData  = List.filled(6, false);
  String? _permitTmDate;
  String _name = "홍길동";
  bool _isHasAcc = false;
  String? _bankName;
  String? _bankAccNum;
  String _mobile = "010-0000-0000";

  get isNotice => [_isNoticeService, _isNoticeMarketing];
  get userDataPermissions => _isPermitUserData;
  get permitTmDate => _permitTmDate;
  get mobile => _mobile.split("-")[2];
  
  get isHasAcc => _isHasAcc;
  get bankData => [_name, _bankName, _bankAccNum];

  void setNoticeService(bool isTrue) => _isNoticeService = isTrue;
  void setNoticeMarket(bool isTrue) => _isNoticeMarketing = isTrue;
  void setPermissions(list) => _isPermitUserData = List.from(list);  
  void setTmPermission(bool isTrue, date){
    _isPermitUserData[5] = isTrue;
    _permitTmDate = date;
    notifyListeners();
  }
  void changeMobile(String mobileNum) => _mobile = mobileNum;

  void setBank(bank, acc){
    _bankName = bank;
    _bankAccNum = acc;
    _isHasAcc = true;
  }
}