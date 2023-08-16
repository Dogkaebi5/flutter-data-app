class BasicData{
  String? selected; 
  DateTime? selectedDate; 
  bool isPermit = false;
  BasicData(this.selected, this.selectedDate, isPermit){
    this.isPermit = false;
  }
  BasicData.fromJson(json) : 
    selected = json["selected"],
    selectedDate = (json["selected_date"] != null)? json["selected_date"].toDate(): null,
    isPermit = (json["is_permit"]== "true")?true:false;
  Map<String, dynamic> basicToMap(){
    return {
      "selected" : selected, 
      "selectedDate" : selectedDate, 
      "isPermit" : isPermit
    };
  }
}

class InterestData{ 
  String? title; 
  bool isSelected = false; 
  DateTime? selectedDate; 
  List? answers; 
  bool isPermit = false;
  InterestData(this.title, isSelected, this.selectedDate, this.answers, isPermit){
    this.isSelected = false;
    this.isPermit = false;
  }
  InterestData.fromJson(json) :
    title = json["title"],
    isSelected = json["is_selected"] ?? false,
    selectedDate = (json["selected_date"] != null)? json["selected_date"].toDate(): null,
    answers = json["answers"],
    isPermit = json["is_permit"] ?? false;
  Map<String, dynamic> interestToMap(){
    return {
      "title": title,
      "is_selected": isSelected,
      "selected_date": selectedDate,
      "answers": answers,
      "is_permit": isPermit
    };
  }
}

class UserModel{
  bool isNewUser;
  String? uid, docId, name, mobile, gmail;
  DateTime? createdTime, lastLoginTime;
  List? loginLog;
  String? nickname, email;
  BasicData? married, children, education, occupation, income, residence, area;
  InterestData? insurance, loan, deposit, immovables, stock, cryto, golf, tennis, fitness, yoga, dietary, educate, parental, automobile, localTrip, overseatrip, camp, fishing, pet;
  List? userInterests;
  String? password;
  String? bankName;
  String? bankAccount;
  int? point;
  bool? isNoticeService;
  bool? isNoticeMarketing;
  bool? isPermitTelemarketing;
  DateTime? permitTelemarketingDate;


  UserModel({
    this.isNewUser = true,
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
    this.userInterests,
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
    this.isPermitTelemarketing,
    this.permitTelemarketingDate
  });

  UserModel.clone(UserModel user)
    : this(
      isNewUser: user.isNewUser,
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
      userInterests: user.userInterests,
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
      isPermitTelemarketing: user.isPermitTelemarketing,
      permitTelemarketingDate: user.permitTelemarketingDate,
    );

  UserModel.fromJson(json, String doc)
    : isNewUser = json["is_new_user"],
      uid = json["uid"],
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
      userInterests = json["user_interests"],
      insurance = InterestData.fromJson(json["insurance"]),
      loan = InterestData.fromJson(json["loan"]),
      deposit = InterestData.fromJson(json["deposit"]),
      immovables = InterestData.fromJson(json["immovables"]),
      stock = InterestData.fromJson(json["stock"]),
      cryto = InterestData.fromJson(json["cryto"]),
      golf = InterestData.fromJson(json["golf"]),
      tennis = InterestData.fromJson(json["tennis"]),
      fitness = InterestData.fromJson(json["fitness"]),
      yoga = InterestData.fromJson(json["yoga"]),
      dietary = InterestData.fromJson(json["dietary"]),
      educate = InterestData.fromJson(json["educate"]),
      parental = InterestData.fromJson(json["parental"]),
      automobile = InterestData.fromJson(json["automobile"]),
      localTrip = InterestData.fromJson(json["localTrip"]),
      overseatrip = InterestData.fromJson(json["overseatrip"]),
      camp = InterestData.fromJson(json["camp"]),
      fishing = InterestData.fromJson(json["fishing"]),
      pet = InterestData.fromJson(json["pet"]),
      password = json["password"],
      bankName = json["bank_name"],
      bankAccount = json["bank_account"],
      point = json["point"],
      isNoticeService = json["is_notice_service"],
      isNoticeMarketing = json["is_notice_marketing"],
      isPermitTelemarketing = json["is_permit_telemarketing"],
      permitTelemarketingDate = (json["permit_telemarketing_date"]!=null)?
        DateTime.fromMicrosecondsSinceEpoch(json["permit_telemarketing_date"].microsecondsSinceEpoch)
        :null;

  Map<String, dynamic> toMap(){
    return {
      "is_new_user": isNewUser,
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
      "user_interests": userInterests,
      "insurance": insurance?.interestToMap(),
      "loan": loan?.interestToMap(),
      "deposit": deposit?.interestToMap(),
      "immovables": immovables?.interestToMap(),
      "stock": stock?.interestToMap(),
      "cryto": cryto?.interestToMap(),
      "golf": golf?.interestToMap(),
      "tennis": tennis?.interestToMap(),
      "fitness": fitness?.interestToMap(),
      "yoga": yoga?.interestToMap(),
      "dietary": dietary?.interestToMap(),
      "educate": educate?.interestToMap(),
      "parental": parental?.interestToMap(),
      "automobile": automobile?.interestToMap(),
      "localTrip": localTrip?.interestToMap(),
      "overseatrip": overseatrip?.interestToMap(),
      "camp": camp?.interestToMap(),
      "fishing": fishing?.interestToMap(),
      "pet": pet?.interestToMap(),
      "password": password,//del
      "bank_name": bankName,
      "bank_account": bankAccount,
      "point": point,
      "is_notice_service": isNoticeService,
      "is_notice_marketing": isNoticeMarketing,
      "is_permit_telemarketing": isPermitTelemarketing,
      "permit_telemarketing_date": permitTelemarketingDate
    };
  }
}