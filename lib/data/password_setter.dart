import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PasswordStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user.txt');
  }

  Future<String> readPassword() async {
    try {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> writePassword(String password) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString(password);
  }
}

class DataStorage {
  // String nickname;
  // String email;
  // final _marriedList = ['미기입', '미혼', '기혼'];
  // final _haveChild = ['미기입', '없음', '있음'];
  // final _education = ['미기입', '고졸 및 이하', '전문대', '대학', '대학원'];
  // final _occupation = ['미기입', '관리직', '사무직'];
  // final _income = ['미기입', '3000만 이하','3000만~5000만','5000만~1억', '1억 이상'];
  // final _residence = ['미기입', '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충청남', '충청북', '전라북', '전라남', '경상북', '경상남', '제주'];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/userdata.json');
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> writeData(data) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString(data);
  }
}