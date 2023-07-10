import 'dart:io';

import 'package:path_provider/path_provider.dart';

class UserBasicDataStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/userBasic.json');
  }
  Future<String> readData() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return e.toString();
    }
  }
  Future<File> writeData(String detail) async {
    final file = await _localFile;
    return file.writeAsString(detail);
  }
}

class UserInterestDataStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/userInterest.json');
  }
  Future<String> readData() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return e.toString();
    }
  }
  Future<File> writeData(String detail) async {
    final file = await _localFile;
    return file.writeAsString(detail);
  }
}

class UserAdditionalDataStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/userAddition.json');
  }
  Future<String> readData() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return e.toString();
    }
  }
  Future<File> writeData(String detail) async {
    final file = await _localFile;
    return file.writeAsString(detail);
  }
}