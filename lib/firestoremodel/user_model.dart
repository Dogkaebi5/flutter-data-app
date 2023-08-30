class BasicData{
  String? selected; 
  DateTime? selectedDate; 
  bool isPermit = false;
  BasicData(this.selected, this.selectedDate, this.isPermit);
  BasicData.fromJson(json) : 
    selected = json["selected"],
    selectedDate = (json["selected_date"] != null)? json["selected_date"].toDate(): null,
    isPermit = json["is_permit"];
  Map<String, dynamic> basicToMap(){
    return {
      "selected" : selected, 
      "selected_date" : selectedDate, 
      "is_permit" : isPermit
    };
  }
}

class UserModel{
  bool? isNewUser;
  String? uid, docId, name, mobile, gmail;
  DateTime? createdTime, lastLoginTime;
  List? loginLog;
  String? nickname, email;
  BasicData? married, children, education, occupation, income, residence, area;
  List? userInterests;
  List? userInterestDates;
  List? userInterestPermits;
  List? insurance, loan, deposit, immovables, stock, cryto, 
    golf, tennis, fitness, yoga, dietary, educate, 
    parental, automobile, domestic, abroad, camp, fishing, 
    pet;
  String? password;
  String? bankName;
  String? bankAccount;
  int? point;
  bool? isNoticeService, isNoticeMarketing;
  bool? isPermitName, isPermitGender, isPermitBirth, isPermitMobile, isPermitTelemarketing;
  DateTime? permitTelemarketingDate;

  UserModel({
    this.isNewUser,
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
    this.userInterestDates,
    this.userInterestPermits,
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
    this.domestic, 
    this.abroad, 
    this.camp, 
    this.fishing, 
    this.pet,
    this.password,
    this.bankName,
    this.bankAccount,
    this.point,
    this.isNoticeService,
    this.isNoticeMarketing,
    this.isPermitName,
    this.isPermitGender,
    this.isPermitBirth,
    this.isPermitMobile,
    this.isPermitTelemarketing,
    this.permitTelemarketingDate, 
  });

  UserModel.clone(UserModel user)
    : this(
      isNewUser : user.isNewUser,
      uid : user.uid,
      docId : user.docId,
      name : user.name,
      mobile : user.mobile,
      gmail : user.gmail,
      createdTime : user.createdTime,
      lastLoginTime : user.lastLoginTime,
      loginLog : user.loginLog,
      nickname : user.nickname,
      email : user.email,
      married : user.married,
      children : user.children,
      education : user.education,
      occupation : user.occupation,
      income : user.income,
      residence : user.residence,
      area : user.area,
      userInterests : user.userInterests,
      userInterestDates : user.userInterestDates,
      userInterestPermits : user.userInterestPermits,
      insurance : user.insurance,
      loan : user.loan,
      deposit : user.deposit,
      immovables : user.immovables,
      stock : user.stock,
      cryto : user.cryto,
      golf : user.golf,
      tennis : user.tennis,
      fitness : user.fitness,
      yoga : user.yoga,
      dietary : user.dietary,
      educate : user.educate,
      parental : user.parental,
      automobile : user.automobile,
      domestic : user.domestic,
      abroad : user.abroad,
      camp : user.camp,
      fishing : user.fishing,
      pet : user.pet,
      password : user.password,
      bankName : user.bankName,
      bankAccount : user.bankAccount,
      point : user.point,
      isNoticeService : user.isNoticeService,
      isNoticeMarketing : user.isNoticeMarketing,
      isPermitName : user.isPermitName,
      isPermitGender : user.isPermitGender,
      isPermitBirth : user.isPermitBirth,
      isPermitMobile : user.isPermitMobile,
      isPermitTelemarketing : user.isPermitTelemarketing,
      permitTelemarketingDate : user.permitTelemarketingDate,
    );

  static List? userInterestTimestampToDate(json){
    List? dates = [];
    if(json != null){
      for(int i = 0; i < json.length; i++){
        dates.add(json[i].toDate());
      }
    }
    return dates;
  }

  UserModel.fromJson(json, String doc)
    : 
      isNewUser = json["is_new_user"],
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
      userInterestDates = userInterestTimestampToDate(json["user_interest_dates"]),
      userInterestPermits = json["user_interest_permits"],
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
      domestic  = json["domestic"],
      abroad = json["abroad"],
      camp = json["camp"],
      fishing = json["fishing"],
      pet = json["pet"],
      password = json["password"],
      bankName = json["bank_name"],
      bankAccount = json["bank_account"],
      point = json["point"],
      isNoticeService = json["is_notice_service"],
      isNoticeMarketing = json["is_notice_marketing"],
      isPermitName = json["is_permit_name"],
      isPermitGender = json["is_permit_gender"],
      isPermitBirth = json["is_permit_birth"],
      isPermitMobile = json["is_permit_mobile"],
      isPermitTelemarketing = json["is_permit_telemarketing"],
      permitTelemarketingDate = (json["permit_telemarketing_date"]!=null)?
        DateTime.fromMicrosecondsSinceEpoch(json["permit_telemarketing_date"].microsecondsSinceEpoch)
        :null;

  Map<String, dynamic> toMap(){
    return {
      "is_new_user" : isNewUser,
      "uid" : uid,
      "doc_id" : docId,
      "name" : name,
      "mobile" : mobile,
      "gmail" : gmail,
      "created_time" : createdTime,
      "last_login_time" : lastLoginTime,
      "login_log" : loginLog,
      "nickname" : nickname,
      "email" : email,
      "married" : married!.basicToMap(),
      "children" : children!.basicToMap(),
      "education" : education!.basicToMap(),
      "occupation" : occupation!.basicToMap(),
      "income" : income!.basicToMap(),
      "residence" : residence!.basicToMap(),
      "area" : area!.basicToMap(),
      "user_interests" : userInterests,
      "user_interest_dates" : userInterestDates,
      "user_interest_permits" : userInterestPermits,
      "insurance" : insurance,
      "loan" : loan,
      "deposit" : deposit,
      "immovables" : immovables,
      "stock" : stock,
      "cryto" : cryto,
      "golf" : golf,
      "tennis" : tennis,
      "fitness" : fitness,
      "yoga" : yoga,
      "dietary" : dietary,
      "educate" : educate,
      "parental" : parental,
      "automobile" : automobile,
      "domestic" : domestic,
      "abroad" : abroad,
      "camp" : camp,
      "fishing" : fishing,
      "pet" : pet,
      "password" : password,
      "bank_name" : bankName,
      "bank_account" : bankAccount,
      "point" : point,
      "is_notice_service" : isNoticeService,
      "is_notice_marketing" : isNoticeMarketing,
      "is_permit_name" : isPermitName,
      "is_permit_gender" : isPermitGender,
      "is_permit_birth" : isPermitBirth,
      "is_permit_mobile" : isPermitMobile,
      "is_permit_telemarketing" : isPermitTelemarketing,
      "permit_telemarketing_date" : permitTelemarketingDate,
    };
  }
}