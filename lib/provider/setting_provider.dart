import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier {
  bool _isNoticeService = false;
  bool _isNoticeMarketing = false;
  List _isPermitUserData  = List.filled(6, false);
  String? _permitTmDate;

  get isNotice => [_isNoticeService, _isNoticeMarketing];
  get userDataPermissions => _isPermitUserData;
  get permitTmDate => _permitTmDate;

  void setNoticeService(bool isTrue) => _isNoticeService = isTrue;
  void setNoticeMarket(bool isTrue) => _isNoticeMarketing = isTrue;
  void setPermissions(list) => _isPermitUserData = List.from(list);

  void setTmPermission(bool isTrue, date){
    _isPermitUserData[5] = isTrue;
    _permitTmDate = date;
    notifyListeners();
  }
}