class UserModel {
  final String? uid;
  String? docId;
  String name;
  String? mobile;
  String email;
  final DateTime? createdTime;
  DateTime? lastLoginTime;

  UserModel({
    this.uid,
    this.docId,
    this.name = "홍길동",
    this.mobile ="010-1234-5678",
    this.email = "example@example.com",
    this.createdTime,
    this.lastLoginTime,
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
    );

  UserModel.fromJson(json, String docId)
    : uid = json["uid"] as String,
      docId = docId,
      name = json["name"] as String,
      mobile = json["mobile"] as String,
      email = json["email"] as String,
      createdTime = json["created_time"].toDate(),
      lastLoginTime = json["last_login_time"].toDate();

  Map <String, dynamic>toMap(){
    return {
      "uid": this.uid, 
      "name": this.name,
      "email": this.email,
      "mobile": this.mobile,
      "created_time": this.createdTime,
      "last_login_time": this.lastLoginTime,
    };
  }
}