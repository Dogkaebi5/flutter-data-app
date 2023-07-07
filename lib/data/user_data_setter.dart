import 'dart:io';

import 'package:path_provider/path_provider.dart';

class UserDataStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user.json');
  }
  Future<String> readUserData() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeUserData(String detail) async {
    final file = await _localFile;
    return file.writeAsString(detail);
  }
}