import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

String detailsJson = ''' 
  { "details": 
    [{
      "id": "10000",
      "title": "데이터 판매",
      "type": "리워드",
      "date": "2023-01-01 23:59:59",
      "point": "+ 20,000 P",
      "buyer": "(주)테스트회사",
      "info": ["닉네임", "연령층",  "이메일", "성함", "휴대폰", "성별","출생연도","결혼정보","자녀정보","최종학력","직업","소득수준","거주지역","관심사 1","관심사 2","관심사 3"]
    },
    {
      "id": "20000",
      "title": "텔레마케팅 판매",
      "type": "리워드",
      "date": "2023-01-01 23:59:59",
      "point": "+ 20,000 P",
      "buyer": "(주)테스트회사",
      "info": ["닉네임", "연령층",  "이메일", "성함", "휴대폰","텔레마케팅","성별","출생연도","결혼정보","자녀정보","최종학력","직업","소득수준","거주지역","관심사 1"]
    }],
    "bank": {
      "username": "홍길동",
      "accountNum": "3333161234567",
      "bank": "카카오뱅크"
    },
    "point": "40000"
  }
''';

class DetailStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/detail.json');
  }
  Future<String> readDetail() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeDetail(String detail) async {
    final file = await _localFile;
    return file.writeAsString(detail);
  }
}

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));
String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
    List<Detail> details;

    Details({
        required this.details,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
    };
}

class Detail {
    String id;
    String title;
    String type;
    String date;
    String point;
    String buyer;
    List<String> info;

    Detail({
        required this.id,
        required this.title,
        required this.type,
        required this.date,
        required this.point,
        required this.buyer,
        required this.info,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        date: json["date"],
        point: json["point"],
        buyer: json["buyer"],
        info: List<String>.from(json["info"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "date": date,
        "point": point,
        "buyer": buyer,
        "info": List<dynamic>.from(info.map((x) => x)),
    };
}
