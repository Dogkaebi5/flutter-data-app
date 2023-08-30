import 'package:data_project/data/question.dart';
import 'package:data_project/firestoremodel/firebase_user_repository.dart';
import 'package:data_project/firestoremodel/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController{
  UserDataController get to => Get.find();
  UserModel originData = UserModel();
  Rx<UserModel> myProfile = UserModel().obs;
  
  List<String> basicTitles = Questions.basicDataTitles.values.toList();
  List<String> interestTitles = Questions.interestsDataTitles.values.toList();

  UserModel createEmptyUser(User firebaseUser) {
    return UserModel(
      isNewUser: true,
      uid: firebaseUser.uid, 
      name: firebaseUser.displayName?? "홍길동",
      gmail: firebaseUser.email?? "example@example.com",
      mobile: firebaseUser.phoneNumber?? "010-0000-0000",
      createdTime: DateTime.now(), 
      lastLoginTime: DateTime.now(),
      loginLog: [DateTime.now()],
      nickname: null,
      email: null,
      married: BasicData(null, null, false),
      children: BasicData(null, null, false),
      education: BasicData(null, null, false),
      occupation: BasicData(null, null, false),
      income: BasicData(null, null, false),
      residence: BasicData(null, null, false),
      area: BasicData(null, null, false),
      userInterests: null,
      userInterestDates: null,
      userInterestPermits: null,
      insurance: List.filled(Questions.interests[interestTitles[0]]!.length, null),
      loan: List.filled(Questions.interests[interestTitles[1]]!.length, null),
      deposit: List.filled(Questions.interests[interestTitles[2]]!.length, null),
      immovables: List.filled(Questions.interests[interestTitles[3]]!.length, null),
      stock: List.filled(Questions.interests[interestTitles[4]]!.length, null),
      cryto: List.filled(Questions.interests[interestTitles[5]]!.length, null),
      golf: List.filled(Questions.interests[interestTitles[6]]!.length, null),
      tennis: List.filled(Questions.interests[interestTitles[7]]!.length, null),
      fitness: List.filled(Questions.interests[interestTitles[8]]!.length, null),
      yoga: List.filled(Questions.interests[interestTitles[9]]!.length, null),
      dietary: List.filled(Questions.interests[interestTitles[10]]!.length, null),
      educate: List.filled(Questions.interests[interestTitles[11]]!.length, null),
      parental: List.filled(Questions.interests[interestTitles[12]]!.length, null),
      automobile: List.filled(Questions.interests[interestTitles[13]]!.length, null),
      domestic: List.filled(Questions.interests[interestTitles[14]]!.length, null),
      abroad: List.filled(Questions.interests[interestTitles[15]]!.length, null),
      camp: List.filled(Questions.interests[interestTitles[16]]!.length, null),
      fishing: List.filled(Questions.interests[interestTitles[17]]!.length, null),
      pet: List.filled(Questions.interests[interestTitles[18]]!.length, null),
      password: null,
      bankName: null,
      bankAccount: null,
      point: 0,
      isNoticeService: false,
      isNoticeMarketing: false,
      isPermitName: true,
      isPermitGender: true,
      isPermitBirth: true,
      isPermitMobile: true,
      isPermitTelemarketing: false,
      permitTelemarketingDate: null);
  }

  authStateChanges(User? firebaseUser) async {
    if(firebaseUser != null){
      UserModel? userModel = await FirebaseUserRepository.findUserByUid(firebaseUser.uid);
      if (userModel != null){
        originData = userModel;
        FirebaseUserRepository.updateLastLoginDate(userModel.docId, DateTime.now());
      }else{
        originData = createEmptyUser(firebaseUser); 
        String docId = await FirebaseUserRepository.signup(originData);
        originData.docId = docId;
      }
    }
    myProfile(UserModel.clone(originData));
  }

  DateTime durationDate() => DateTime.now().add(Duration(days: 1));
  
  bool isDurationSmallerThanNow(DateTime? dates){
    return (dates??DateTime.now()).microsecondsSinceEpoch <= DateTime.now().microsecondsSinceEpoch;
  } 
  
  void setUserPermit(int i, bool isPermit){
    String key = "";
    if (i <= 3){
      switch(i){
        case 0 : key = "is_permit_name"; originData.isPermitName = isPermit; break;
        case 1 : key = "is_permit_gender"; originData.isPermitGender = isPermit; break;
        case 2 : key = "is_permit_birth"; originData.isPermitBirth = isPermit; break;
        case 3 : key = "is_permit_mobile"; originData.isPermitMobile = isPermit; break;
        default: break;
      }
      FirebaseUserRepository.updateIsPermitUserData(originData.docId, key, isPermit);
    }
    if( i == 3 && !isPermit && originData.isPermitTelemarketing! ){
      FirebaseUserRepository.updateIsPermitTeleMarketing(originData.docId, isPermit, null);
      originData.isPermitTelemarketing = isPermit;
      originData.permitTelemarketingDate = null;
    }
    if( i == 4 ){
      originData.isPermitTelemarketing = isPermit;
      originData.permitTelemarketingDate = (isPermit) ? DateTime.now() : null;
      FirebaseUserRepository.updateIsPermitTeleMarketing(originData.docId, isPermit, originData.permitTelemarketingDate);
    }
    myProfile(UserModel.clone(originData));
  }

  List<bool> getUserDataPermits() => [ originData.isPermitName!, originData.isPermitGender!, originData.isPermitBirth!, originData.isPermitMobile!, originData.isPermitTelemarketing!];
  
  void setNewPassword(String pw){
    if (pw.length == 4){
      FirebaseUserRepository.updatePassword(originData.docId, pw);
    }
  }
  
  void changeNoticeService(){
    if(originData.isNoticeService != null){
      originData.isNoticeService = !originData.isNoticeService!;
      FirebaseUserRepository.updateIsNoticeService(originData.docId, originData.isNoticeService!);
    }
  }
  void changeNoticeMarketing(){
    if(originData.isNoticeMarketing != null){
      originData.isNoticeMarketing = !originData.isNoticeMarketing!;
      FirebaseUserRepository.updateIsNoticeMarketing(originData.docId, originData.isNoticeMarketing!);
    }
  }

  void setBasic(String nickname, String email, List<String?> selecteds){
    if(originData.nickname != nickname && nickname != ""){setNickname(nickname);}
    if(originData.email != email && email != ""){setEmail(email);}
    setBasicData(selecteds);
  }
  void setNickname(String nickname){
    FirebaseUserRepository.updateNickname(originData.docId, nickname);
    originData.nickname = nickname;
    myProfile(UserModel.clone(originData));
  }
  void setEmail(String email){
    FirebaseUserRepository.updateEmail(originData.docId, email);
    originData.email = email;
    myProfile(UserModel.clone(originData));
  }

  void setBasicData(List<String?> selecteds){
    List keys = Questions.basicDataTitles.keys.toList();
    List<DateTime?> dates = getBasicDateTimes();
    List originSeleted = getBasicSelecteds();
    for(int i=0; i<selecteds.length; i++){
      if(isDurationSmallerThanNow(dates[i]) && selecteds[i] != null){
        FirebaseUserRepository.updateBasicData(originData.docId, keys[i], selecteds[i], true, durationDate());
        originSeleted[i] = selecteds[i];
      }
    }
  }
  
  void setBasicPermits(int i, bool isPermit){
    String key = "", selected = "";
    DateTime? date;
    switch(i){
      case 0 : key = "married"; 
        selected = originData.married!.selected!;
        date = originData.married!.selectedDate!;
        originData.married!.isPermit = isPermit; break;
      case 1 : key = "children"; 
        selected = originData.children!.selected!;
        date = originData.children!.selectedDate!;
        originData.children!.isPermit = isPermit; break;
      case 2 : key = "education"; 
        selected = originData.education!.selected!;
        date = originData.education!.selectedDate!;
        originData.education!.isPermit = isPermit; break;
      case 3 : key = "occupation"; 
        selected = originData.occupation!.selected!;
        date = originData.occupation!.selectedDate!;
        originData.occupation!.isPermit = isPermit; break;
      case 4 : key = "income"; 
        selected = originData.income!.selected!;
        date = originData.income!.selectedDate!;
        originData.income!.isPermit = isPermit; break;
      case 5 : key = "residence"; 
        selected = originData.residence!.selected!;
        date = originData.residence!.selectedDate!;
        originData.residence!.isPermit = isPermit; break;
      case 6 : key = "area"; 
        selected = originData.area!.selected!;
        date = originData.area!.selectedDate!;
        originData.area!.isPermit = isPermit; break;
    }
    FirebaseUserRepository.updateBasicData(originData.docId, key, selected, isPermit, date);
  }

  List<String?> getBasicSelecteds() => [ originData.married!.selected, originData.children!.selected, originData.education!.selected, originData.occupation!.selected, originData.income!.selected, originData.residence!.selected, originData.area!.selected];
  List<DateTime?> getBasicDateTimes() => [ originData.married!.selectedDate, originData.children!.selectedDate, originData.education!.selectedDate, originData.occupation!.selectedDate, originData.income!.selectedDate, originData.residence!.selectedDate, originData.area!.selectedDate];
  List<bool> getIsPermitBasics() => [ originData.married!.isPermit, originData.children!.isPermit, originData.education!.isPermit, originData.occupation!.isPermit, originData.income!.isPermit, originData.residence!.isPermit, originData.area!.isPermit];

  void setInterests(List? selected) {
    Map<String, bool> isSelectedMap = createInterestIsSelectedsMap(selected);
    isSelectedMap.removeWhere((key, value) => !value);
    List<String> newSelecteds = isSelectedMap.keys.toList();
    List newDates = originData.userInterestDates??[];
    List newPermits = originData.userInterestPermits??[];
    List dates = [];
    print("test: $selected");
    print("test: $isSelectedMap");
    print("test: $newSelecteds");
    dates.addAll(originData.userInterestDates??[]);
    switch (dates.length){
      case 0 : dates = [null,null,null]; break;
      case 1 : dates.addAll([null,null]); break;
      case 2 : dates.add(null); break;
      case 3 : break;
    }
    for(int i = 0; i < newSelecteds.length; i++){
      if(isDurationSmallerThanNow(dates[i])){
        newDates.add(durationDate());
        newPermits.add(true);
      }
    }
    FirebaseUserRepository.updateInterests(originData.docId, newSelecteds);
    FirebaseUserRepository.updateInterestDates(originData.docId, newDates);
    FirebaseUserRepository.updateInterestPermit(originData.docId, newPermits);
    originData.userInterests = newSelecteds;
    originData.userInterestDates = newDates;
    originData.userInterestPermits = newPermits;
    myProfile(UserModel.clone(originData));
  }

  Map createInterestDatesMap(){
    Map result = {};
    for (int i = 0; i < interestTitles.length; i++){
      result[interestTitles[i]] = null;
    }
    if (originData.userInterestDates != null){
      for (int i = 0; i < originData.userInterestDates!.length; i++){
        result[originData.userInterests![i]] = originData.userInterestDates![i];
      }
    }
    return result;
  }

  Map<String, bool> createInterestIsSelectedsMap(List? selecteds){
    Map<String, bool> result = {};
    for (int i = 0; i < interestTitles.length; i++){
      result[interestTitles[i]] = false;
    }
    if (selecteds != null) {
      for (int i = 0; i < selecteds.length; i++) {
        result[selecteds[i]] = true;
      }
    }
    return result;
  }
  
  List getAdditionalAnswersList(){
    return [
      originData.insurance, originData.loan, originData.deposit, 
      originData.immovables, originData.stock, originData.cryto, 
      originData.golf, originData.tennis, originData.fitness, 
      originData.yoga, originData.dietary, originData.educate, 
      originData.parental, originData.automobile, originData.domestic, 
      originData.abroad, originData.camp, originData.fishing, 
      originData.pet];
  }

  Map getAdditionalAnswersMap(){
    Map result = {};
    List answers = getAdditionalAnswersList();
    for(int i = 0; i < interestTitles.length; i++){
      result[interestTitles[i]] = answers[i];
    }
    return result;
  }

  List createSelectedAnwers(Map answersMap){
    List<List> result = [];
    if(originData.userInterests != null){
      for (int i = 0; i < originData.userInterests!.length; i++){
        result.add(answersMap[originData.userInterests![i]]);
      }
    }
    return result;
  }

  void setAnswers(Map newAnswers){
    List answers = [];
    Map json = {};
    List keys = createInterestKeysList(Questions.interestsDataTitles, originData.userInterests!);
    for (int i = 0; i < originData.userInterests!.length; i++){
      answers.add(newAnswers[originData.userInterests![i]]);
      json[originData.userInterests![i]] = newAnswers[originData.userInterests![i]];
    }
    FirebaseUserRepository.updateAnswers(originData.docId, keys, answers);
    setAnswersToOriginData(answers);
  }

  void setIsNewUser(bool isNew){
    FirebaseUserRepository.updateIsNewUser(originData.docId, isNew);
    originData.isNewUser = isNew;
    myProfile(UserModel.clone(originData));
  }

  List<String> createInterestKeysList(Map originMap, List selecteds){
    List<String> result = [];
    for (int i = 0; i < selecteds.length; i++) {
      String key = originMap.keys.firstWhere((k) => 
        originMap[k] == selecteds[i]);
      result.add(key);
    }
    return result;
  }

  void setAnswersToOriginData(List answers){
    List index = createIndexList(interestTitles, originData.userInterests!);
    List originAnswers = getAdditionalAnswersList();
    for (int i = 0; i < index.length; i++){
      originAnswers[index[i]] = answers[i];
    }
  }

  List createIndexList(List list, List selecteds){
    List result = [];
    for(int i = 0; i< selecteds.length; i++){
      result.add(list.indexOf(selecteds[i]));
    }
    return result;
  }

  void setInterestPermits(List isPermits){
    FirebaseUserRepository.updateInterestPermit(originData.docId, isPermits);
  }
  
  Future<bool> checkPassword(pw) async{
    String? originPassword = await FirebaseUserRepository.getUserPassword(originData.docId);
    if(originPassword == null || originPassword.length < 4){
      return false;
    }else if(originPassword == pw){
      return true;
    }else {
      return false;
    }
  }

  void pointCtrl(int point){
    int sumPoint = (originData.point??0) + point;
    FirebaseUserRepository.updatePoint(originData.docId, sumPoint);
    originData.point = sumPoint;
    myProfile(UserModel.clone(originData));
  }
  
  getDetailId(typenum){
    int nowId = 0;
    switch (typenum) {
      case 1: nowId = FirebaseUserRepository.getSaleDetailId() + 1; break;
      case 2: nowId = FirebaseUserRepository.getTeleSaleDetailId() + 1; break;
      case 3: nowId = FirebaseUserRepository.getWithdrawDetailId() + 1; break;
    }
    return nowId;
  }
  
  testMakeDetail(){
    int id = getDetailId(1);
    Map detail = {
      "uid": originData.uid,
      "title": "데이터 판매",
      "id": id,
      "type": "리워드",
      "date": DateTime.now(),
      "point": 10000,
    };
    FirebaseUserRepository.updateDetails(originData.uid, detail);
    FirebaseUserRepository.updateDetailId(id);
  }

  void reset(){
    UserModel empty = createEmptyUser(FirebaseAuth.instance.currentUser!);
    FirebaseUserRepository.resetUser(originData.docId, empty);
    authStateChanges(FirebaseAuth.instance.currentUser!);
  }
}