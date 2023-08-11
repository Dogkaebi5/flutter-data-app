class BasicData{
  String? selected; DateTime? selectedDate; bool isPermit = false;
  BasicData(
    String? selected, 
    DateTime? selectedDate, 
    bool isPermit);
  BasicData.fromJson(json) : 
    selected = json["selected"],
    selectedDate = (json["selectedDate"] != null)? json["selectedDate"].toDate(): null,
    isPermit = (json["isPermit"]== "true")?true:false;
  
  Map<String, dynamic> basicToMap(){
    return {
      "selected" : selected, 
      "selectedDate" : selectedDate, 
      "isPermit" : isPermit
    };
  }
}

class InterestData{ String? title; bool? isSelecteds = false; DateTime? selectedDate; List? selecteds; bool? isPermit = false;}




class UserModel{
  String? uid, docId, name, mobile, gmail;
  DateTime? createdTime, lastLoginTime;
  List? loginLog;
  String? nickname, email;
  BasicData? married, children, education, occupation, income, residence, area;
  InterestData? insurance, loan, deposit, immovables, stock, cryto, golf, tennis, fitness, yoga, dietary, educate, parental, automobile, localTrip, overseatrip, camp, fishing, pet;
  String? password;
  String? bankName;
  String? bankAccount;
  int? point;
  bool? isNoticeService;
  bool? isNoticeMarketing;
  bool? isPermitTeleMarketing;


  UserModel({
    this.uid,
    this.docId,
    this.name,
    this.mobile,
    this.gmail,
    this.createdTime,
    this.lastLoginTime,
    this.loginLog,
    this.nickname,
    this.email,
    this.married, 
    this.children, 
    this.education, 
    this.occupation, 
    this.income, 
    this.residence, 
    this.area,
    this.insurance, 
    this.loan, 
    this.deposit, 
    this.immovables, 
    this.stock, 
    this.cryto, 
    this.golf, 
    this.tennis, 
    this.fitness, 
    this.yoga, 
    this.dietary, 
    this.educate, 
    this.parental, 
    this.automobile, 
    this.localTrip, 
    this.overseatrip, 
    this.camp, 
    this.fishing, 
    this.pet,
    this.password,
    this.bankName,
    this.bankAccount,
    this.point,
    this.isNoticeService,
    this.isNoticeMarketing,
    this.isPermitTeleMarketing,
  });

  UserModel.clone(UserModel user)
    : this(
      uid: user.uid,
      docId: user.docId,
      name: user.name,
      mobile: user.mobile,
      gmail: user.gmail,
      createdTime: user.createdTime,
      lastLoginTime: user.lastLoginTime,
      loginLog: user.loginLog,
      nickname: user.nickname,
      email: user.email,
      married: user.married,
      children: user.children,
      education: user.education,
      occupation: user.occupation,
      income: user.income,
      residence: user.residence,
      area: user.area,
      insurance: user.insurance,
      loan: user.loan,
      deposit: user.deposit,
      immovables: user.immovables,
      stock: user.stock,
      cryto: user.cryto,
      golf: user.golf,
      tennis: user.tennis,
      fitness: user.fitness,
      yoga: user.yoga,
      dietary: user.dietary,
      educate: user.educate,
      parental: user.parental,
      automobile: user.automobile,
      localTrip: user.localTrip,
      overseatrip: user.overseatrip,
      camp: user.camp,
      fishing: user.fishing,
      pet: user.pet,
      password: user.password,
      bankName: user.bankName,
      bankAccount: user.bankAccount,
      point: user.point,
      isNoticeService: user.isNoticeService,
      isNoticeMarketing: user.isNoticeMarketing,
      isPermitTeleMarketing: user.isPermitTeleMarketing,
    );

  UserModel.fromJson(json, String doc)
    : uid = json["uid"],
      docId = doc,
      name = json["name"],
      mobile = json["mobile"],
      gmail = json["gmail"],
      createdTime = json["created_time"].toDate(),
      lastLoginTime = json["last_login_time"].toDate(),
      loginLog = json["login_log"],
      nickname = json["nickname"],
      email = json["email"],
      married = BasicData.fromJson(json["married"]),
      children = BasicData.fromJson(json["children"]),
      education = BasicData.fromJson(json["education"]),
      occupation = BasicData.fromJson(json["occupation"]),
      income = BasicData.fromJson(json["income"]),
      residence = BasicData.fromJson(json["residence"]),
      area = BasicData.fromJson(json["area"]),
      insurance = json["insurance"],
      loan = json["loan"],
      deposit = json["deposit"],
      immovables = json["immovables"],
      stock = json["stock"],
      cryto = json["cryto"],
      golf = json["golf"],
      tennis = json["tennis"],
      fitness = json["fitness"],
      yoga = json["yoga"],
      dietary = json["dietary"],
      educate = json["educate"],
      parental = json["parental"],
      automobile = json["automobile"],
      localTrip = json["localTrip"],
      overseatrip = json["overseatrip"],
      camp = json["camp"],
      fishing = json["fishing"],
      pet = json["pet"],
      password = json["password"],
      bankName = json["bankName"],
      bankAccount = json["bankAccount"],
      point = json["point"],
      isNoticeService = json["isNoticeService"],
      isNoticeMarketing = json["isNoticeMarketing"],
      isPermitTeleMarketing = json["isPermitTeleMarketing"];

  Map<String, dynamic> toMap(){
    return {
      "uid": uid, 
      "name": name,
      "gmail": gmail,
      "mobile": mobile,
      "created_time": createdTime,
      "last_login_time": lastLoginTime,
      "login_log": loginLog,
      "nickname": nickname,
      "email": email,
      "married": married?.basicToMap(),
      "children": children?.basicToMap(),
      "education": education?.basicToMap(),
      "occupation": occupation?.basicToMap(),
      "income": income?.basicToMap(),
      "residence": residence?.basicToMap(),
      "area": area?.basicToMap(),
      "insurance": insurance,
      "loan": loan,
      "deposit": deposit,
      "immovables": immovables,
      "stock": stock,
      "cryto": cryto,
      "golf": golf,
      "tennis": tennis,
      "fitness": fitness,
      "yoga": yoga,
      "dietary": dietary,
      "educate": educate,
      "parental": parental,
      "automobile": automobile,
      "localTrip": localTrip,
      "overseatrip": overseatrip,
      "camp": camp,
      "fishing": fishing,
      "pet": pet,
      "password": password,
      "bankName": bankName,
      "bankAccount": bankAccount,
      "point": point,
      "isNoticeService": isNoticeService,
      "isNoticeMarketing": isNoticeMarketing,
      "isPermitTeleMarketing": isPermitTeleMarketing,
    };
  }
}