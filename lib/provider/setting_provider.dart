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
  final List _details = Details().details;
  final List _notices = Details().notices;
  bool _hasNewNotice = false;
  int _newNoticesCount = 0;
  
  get userName => name;
  get isNotice => [_isNoticeService, _isNoticeMarketing];
  get userDataPermissions => _isPermitUserData;
  get permitTmDate => _permitTmDate;
  get mobile => _mobile.split("-")[2];
  get point => _point;
  get details => _details;
  get notices => _notices;
  get hasNewNotice => _hasNewNotice;
  get newNoticesCount => _newNoticesCount;

  get isHasAcc => _isHasAcc;
  get bankData => [name, _bankName, _bankAccNum];

  void setNoticeService(bool isTrue) => _isNoticeService = isTrue;
  void setNoticeMarket(bool isTrue) => _isNoticeMarketing = isTrue;
  void setPermissions(list) => _isPermitUserData = List.from(list);  
  void setTmPermission(bool isTrue){
    _isPermitUserData[3] = isTrue;
    _isPermitUserData[4] = isTrue;
    _permitTmDate = DateTime.now().toString().split(' ')[0];
    notifyListeners();
  }
  void changeMobile(String mobileNum){
    _mobile = mobileNum;
    notifyListeners();
  } 
  void setBank(bank, acc){
    _bankName = bank;
    _bankAccNum = acc;
    _isHasAcc = true;
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
  void clearDetail() => _details.clear();
  void addNotice(notice) => _notices.add(notice);
  void clearNotice() => _notices.clear();
  void setHasNewNotice(bool a) => _hasNewNotice = a;
  void countNewNotice(bool a) => (a)? _newNoticesCount++ : _newNoticesCount = 0;



  void pointTest(List pointList){
    Map newdetail;
    Map newNotice;
    if(pointList[0] > -1) {
      newdetail = _createSaleDetail(pointList);
      newNotice = _createSaleNotice();
    }else {
      newdetail = _createWithdrawDetail(pointList);
      newNotice = _createWithdrawNotice();
    }
    addPoint(pointList[0]);
    addDetail(newdetail);
    addNotice(newNotice);
    setHasNewNotice(true);
    countNewNotice(true);
  }
  int _saleDetailID = 10000;
  int _withDrawDetailID = 30000;

  _createSaleDetail(List pointList){
    return {
      "title": "데이터 판매",
      "id": (++_saleDetailID).toString(),
      "type": "리워드",
      "date": DateTime.now().toString().split(".")[0],
      "point": "+ ${f.format(pointList[0])} P",
      "buyer": "(주)테스트회사",
      "info": ["닉네임", "연령층", "이메일", "성함", "휴대폰", "관심사 1"]
    };
  }
  _createWithdrawDetail(List pointList){
    return {
      "title": "출금",
      "id": (++_withDrawDetailID).toString(),
      "type": "출금",
      "date": DateTime.now().toString().split(".")[0],
      "point": "- ${f.format(pointList[0]*-1)} P",
      "withdraw": "${f.format(pointList[0]*-1)} P",
      "fee": "${pointList[1].toString()} 원",
      "tax": "${pointList[2].toString()} 원",
      "amount": "${pointList[3].toString()} 원",
      "account": [name, "$_bankName $_bankAccNum"],
      "status" : "접수"
    };
  }

  _createSaleNotice(){
    return {
      "id": _saleDetailID.toString(),
      "type": "normal", 
      "title": "[데이플러스] 리워드 안내",
      "content": "판매 접수된 정보가 구매 확정되어 포인트가 적립되었습니다!",
      "date": DateTime.now().toString().split(".")[0],
    };
  }
  _createWithdrawNotice(){
    return {
      "id": _withDrawDetailID.toString(),
      "type": "normal", 
      "title": "[데이플러스] 출금 성공",
      "content": "신청하신 포인트가 정상 출금되었습니다.",
      "date": DateTime.now().toString().split(".")[0],
    };
  }

  void reset(){
    _isNoticeService = false;
    _isNoticeMarketing = false;
    _isPermitUserData  = List.filled(6, false);
    _permitTmDate = null;
    _isHasAcc = false;
    _bankName = null;
    _bankAccNum = null;
    _mobile = "010-1234-5678";
    _point = 0;

    _hasNewNotice = false;
    _newNoticesCount = 0;
    clearDetail();
    clearNotice();
  }
}