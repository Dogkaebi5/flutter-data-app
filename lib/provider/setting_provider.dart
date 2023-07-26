import 'package:data_project/data/details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingProvider extends ChangeNotifier {

  NumberFormat f = NumberFormat('###,###,###,###');

  bool _isNoticeService = false;
  bool _isNoticeMarketing = false;
  List _isPermitUserData  = List.filled(6, false);
  String? _permitTmDate;
  String name = "홍길동";
  bool _isHasAcc = false;
  String? _bankName;
  String? _bankAccNum;
  String _mobile = "010-1234-5678";
  int _point = 25000;
  List _details = Details().details;
  
  get userName => name;
  get isNotice => [_isNoticeService, _isNoticeMarketing];
  get userDataPermissions => _isPermitUserData;
  get permitTmDate => _permitTmDate;
  get mobile => _mobile.split("-")[2];
  get point => _point;
  get details => _details;

  get isHasAcc => _isHasAcc;
  get bankData => [name, _bankName, _bankAccNum];

  void setNoticeService(bool isTrue) => _isNoticeService = isTrue;
  void setNoticeMarket(bool isTrue) => _isNoticeMarketing = isTrue;
  void setPermissions(list) => _isPermitUserData = List.from(list);  
  void setTmPermission(bool isTrue, date){
    _isPermitUserData[3] = isTrue;
    _isPermitUserData[4] = isTrue;
    _permitTmDate = date;
    notifyListeners();
  }
  void changeMobile(String mobileNum){
    _mobile = mobileNum;
    notifyListeners();
  } 
  
  void addPoint(int point){
    _point = _point + point;
    notifyListeners();
  }
  void addDetail(Map detail){
    _details.add(detail);
    notifyListeners();
  }
  void addDetailTest(int point){
    Map newdetail;
    if(point > -1) {
      newdetail = addSaleDetail(point);
      addDetail(newdetail);
    }else {
      newdetail = addWithdrawDetail(point);
      addDetail(newdetail);
    }
    addPoint(point);
  }
  void setBank(bank, acc){
    _bankName = bank;
    _bankAccNum = acc;
    _isHasAcc = true;
    notifyListeners();
  }

  addSaleDetail(point){
    return {
      "title": "데이터 판매",
      "id": "10000",
      "type": "리워드",
      "date": "2023-01-01 23:59:59",
      "point": "+ ${f.format(point)} P",
      "buyer": "(주)테스트회사",
      "info": ["닉네임", "연령층", "이메일", "성함", "휴대폰", "관심사 1"]
    };
  }
  addWithdrawDetail(point){
    return {
      "title": "출금",
      "id": "30000",
      "type": "출금",
      "date": "2023-01-01 23:59:59",
      "point": "- ${f.format(point)} P",
      "withdraw": "${f.format(point)} P",
      "fee": "${(point < 10000)?"1,000": "0"} P",
      "tax": "660 원",
      "amount": "9,340 원",
      "account": ["홍길동", "카카오뱅크 3333123456789"],
      "status" : "접수"
    };
  }
}