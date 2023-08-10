class UserModel {
  final String? uid;
  String? docId;
  String name;
  String? mobile;
  String email;
  final DateTime? createdTime;
  DateTime? lastLoginTime;
  List? loginLog;

  UserModel({
    this.uid,
    this.docId,
    this.name = "홍길동",
    this.mobile ="010-1234-5678",
    this.email = "example@example.com",
    this.createdTime,
    this.lastLoginTime,
    this.loginLog
  });

  UserModel.clone(UserModel user)
    : this(
      uid: user.uid,
      docId: user.docId,
      name: user.name,
      mobile: user.mobile,
      email: user.email,
      createdTime: user.createdTime,
      lastLoginTime: user.lastLoginTime,
      loginLog: user.loginLog
    );

  UserModel.fromJson(json, String doc)
    : uid = json["uid"],
      docId = doc,
      name = json["name"],
      mobile = json["mobile"],
      email = json["email"],
      createdTime = json["created_time"].toDate(),
      lastLoginTime = json["last_login_time"].toDate(),
      loginLog = json["login_log"];

  Map <String, dynamic>toMap(){
    return {
      "uid": uid, 
      "name": name,
      "email": email,
      "mobile": mobile,
      "created_time": createdTime,
      "last_login_time": lastLoginTime,
      "login_log": loginLog
    };
  }
}