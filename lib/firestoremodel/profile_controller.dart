import 'package:data_project/data/question.dart';
import 'package:data_project/firestoremodel/firebase_user_repository.dart';
import 'package:data_project/firestoremodel/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController{
  UserDataController get to => Get.find();
  UserModel originData = UserModel();
  Rx<UserModel> myProfile = UserModel().obs;
  
  authStateChanges(User? firebaseUser) async {
    if(firebaseUser != null){
      UserModel? userModel = await FirebaseUserRepository.findUserByUid(firebaseUser.uid);
      if (userModel != null){
        originData = userModel;
        FirebaseUserRepository.updateLastLoginDate(userModel.docId, DateTime.now());
      } else {
        List<String> interestTitles = Questions.interests.keys.toList();
        originData = UserModel(
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
          insurance: InterestData(interestTitles[0], false, null, List.filled(Questions.interests[interestTitles[0]]!.length, null) , false),
          loan: InterestData(interestTitles[1], false, null, List.filled(Questions.interests[interestTitles[1]]!.length, null) , false),
          deposit: InterestData(interestTitles[2], false, null, List.filled(Questions.interests[interestTitles[2]]!.length, null) , false),
          immovables: InterestData(interestTitles[3], false, null, List.filled(Questions.interests[interestTitles[3]]!.length, null) , false),
          stock: InterestData(interestTitles[4], false, null, List.filled(Questions.interests[interestTitles[4]]!.length, null) , false),
          cryto: InterestData(interestTitles[5], false, null, List.filled(Questions.interests[interestTitles[5]]!.length, null) , false),
          golf: InterestData(interestTitles[6], false, null, List.filled(Questions.interests[interestTitles[6]]!.length, null) , false),
          tennis: InterestData(interestTitles[7], false, null, List.filled(Questions.interests[interestTitles[7]]!.length, null) , false),
          fitness: InterestData(interestTitles[8], false, null, List.filled(Questions.interests[interestTitles[8]]!.length, null) , false),
          yoga: InterestData(interestTitles[9], false, null, List.filled(Questions.interests[interestTitles[9]]!.length, null) , false),
          dietary: InterestData(interestTitles[10], false, null, List.filled(Questions.interests[interestTitles[10]]!.length, null) , false),
          educate: InterestData(interestTitles[11], false, null, List.filled(Questions.interests[interestTitles[11]]!.length, null) , false),
          parental: InterestData(interestTitles[12], false, null, List.filled(Questions.interests[interestTitles[12]]!.length, null) , false),
          automobile: InterestData(interestTitles[13], false, null, List.filled(Questions.interests[interestTitles[13]]!.length, null) , false),
          localTrip: InterestData(interestTitles[14], false, null, List.filled(Questions.interests[interestTitles[14]]!.length, null) , false),
          overseatrip: InterestData(interestTitles[15], false, null, List.filled(Questions.interests[interestTitles[15]]!.length, null) , false),
          camp: InterestData(interestTitles[16], false, null, List.filled(Questions.interests[interestTitles[16]]!.length, null) , false),
          fishing: InterestData(interestTitles[17], false, null, List.filled(Questions.interests[interestTitles[17]]!.length, null) , false),
          pet: InterestData(interestTitles[18], false, null, List.filled(Questions.interests[interestTitles[18]]!.length, null) , false),
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
          permitTelemarketingDate: null,
        );
        String docId = await FirebaseUserRepository.signup(originData);
        originData.docId = docId;
      }
    }
    myProfile(UserModel.clone(originData));
  }

  bool checkHasPassword(){
    return FirebaseUserRepository.checkPassword(originData.docId);
  }
  bool checkIsNewUser(){
    return FirebaseUserRepository.checkIsNewUser(originData.docId);
  }

  void setUserPermit(int i, bool isPermit){
    String key = "";
    if(i != 4){
      switch(i){
        case 0 : key = "is_permit_name"; originData.isPermitName = isPermit; break;
        case 1 : key = "is_permit_gender"; originData.isPermitGender = isPermit; break;
        case 2 : key = "is_permit_birth"; originData.isPermitBirth = isPermit; break;
        case 3 : key = "is_permit_mobile"; originData.isPermitMobile = isPermit; break;
      }
      FirebaseUserRepository.updateIsPermitUserData(originData.docId, key, isPermit);
    }else{
      originData.isPermitTelemarketing = isPermit;
      originData.permitTelemarketingDate = (isPermit) ? DateTime.now() : null;
      FirebaseUserRepository.updateIsPermitTeleMarketing(originData.docId, isPermit, originData.permitTelemarketingDate);
      if(isPermit) {
        originData.isPermitMobile = isPermit;
        FirebaseUserRepository.updateIsPermitUserData(originData.docId, "is_permit_mobile", isPermit);
      }
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
  void setNewPassword(String pw){
    if (pw.length == 4){
      FirebaseUserRepository.updatePassword(originData.docId, pw);
    }
  }
  void setBasic(nickname, email, selecteds){
    if(originData.nickname != nickname){setNickname(nickname);}
    if(originData.email != email){setEmail(email);}
    if(
      originData.married!.selected != selecteds[0] ||
      originData.children!.selected != selecteds[1] ||
      originData.education!.selected != selecteds[2] ||
      originData.occupation!.selected != selecteds[3] ||
      originData.income!.selected != selecteds[4] ||
      originData.residence!.selected != selecteds[5] ||
      originData.area!.selected != selecteds[6]){
        setBasicData(selecteds);
      }
  }
  void setNickname(String? nickname){
    if (nickname != null && nickname != ""){
      FirebaseUserRepository.updateNickname(originData.docId, nickname);
      originData.nickname = nickname;
      myProfile(UserModel.clone(originData));
    }
  }
  void setEmail(String? email){
    if (email != null && email != ""){
      FirebaseUserRepository.updateEmail(originData.docId, email);
      originData.email = email;
      myProfile(UserModel.clone(originData));
    }
  }
  void setBasicData(List basicData)async{
    bool isUpdated = false;
    List basicQuestions = Questions.basicDataTitles.keys.toList();
    List dates = getBasicDateTimes();
    for(int i = 0; i < basicData.length; i++){
      if(basicData[i] != null && dates[i] == null){
        FirebaseUserRepository.updateBasicData(
          originData.docId, basicQuestions[i], basicData[i], DateTime.now());
        isUpdated = true;
      }
    }
    if(isUpdated){
      UserModel? userModel = await FirebaseUserRepository.findUserByUid(originData.uid!);
      originData = userModel!;
      myProfile(UserModel.clone(originData));
      isUpdated = false;
    }
  }
  List<String?> getBasicSelecteds(){
    return [
      originData.married!.selected,
      originData.children!.selected,
      originData.education!.selected,
      originData.occupation!.selected,
      originData.income!.selected,
      originData.residence!.selected,
      originData.area!.selected
    ];
  }
  List<DateTime?> getBasicDateTimes(){
    return [
      originData.married!.selectedDate,
      originData.children!.selectedDate,
      originData.education!.selectedDate,
      originData.occupation!.selectedDate,
      originData.income!.selectedDate,
      originData.residence!.selectedDate,
      originData.area!.selectedDate
    ];
  }
  List<bool> getUserData(){
    return [
      originData.isPermitName,
      originData.isPermitGender,
      originData.isPermitBirth,
      originData.isPermitMobile,
      originData.isPermitTelemarketing
    ];
  }
  List<bool> getIsPermitBasics(){
    return [
      originData.married!.isPermit,
      originData.children!.isPermit,
      originData.education!.isPermit,
      originData.occupation!.isPermit,
      originData.income!.isPermit,
      originData.residence!.isPermit,
      originData.area!.isPermit
    ];
  }
  List<bool> getIsSelecteds(){
    return [
      originData.insurance!.isSelected, 
      originData.loan!.isSelected, 
      originData.deposit!.isSelected, 
      originData.immovables!.isSelected, 
      originData.stock!.isSelected, 
      originData.cryto!.isSelected, 
      originData.golf!.isSelected, 
      originData.tennis!.isSelected, 
      originData.fitness!.isSelected, 
      originData.yoga!.isSelected, 
      originData.dietary!.isSelected, 
      originData.educate!.isSelected, 
      originData.parental!.isSelected, 
      originData.automobile!.isSelected, 
      originData.localTrip!.isSelected, 
      originData.overseatrip!.isSelected, 
      originData.camp!.isSelected, 
      originData.fishing!.isSelected, 
      originData.pet!.isSelected
    ];
  }
  List<DateTime?> getInterestDates(){
    return [
      originData.insurance?.selectedDate,
      originData.loan?.selectedDate,
      originData.deposit?.selectedDate,
      originData.immovables?.selectedDate,
      originData.stock?.selectedDate,
      originData.cryto?.selectedDate,
      originData.golf?.selectedDate,
      originData.tennis?.selectedDate,
      originData.fitness?.selectedDate,
      originData.yoga?.selectedDate,
      originData.dietary?.selectedDate,
      originData.educate?.selectedDate,
      originData.parental?.selectedDate,
      originData.automobile?.selectedDate,
      originData.localTrip?.selectedDate,
      originData.overseatrip?.selectedDate,
      originData.camp?.selectedDate,
      originData.fishing?.selectedDate,
      originData.pet?.selectedDate];
  }
  List<DateTime?> getInterestDatesWithoutNull(){
    List<DateTime?> interestDates = getInterestDates();
    interestDates.removeWhere((item) => (item == null));
    return interestDates;
  }
  List<bool> getIsPermitInterestsWhichSelected(){
    List<String> interestTitles = Questions.interestsDataTitles.values.toList();
    Map map = {
      interestTitles[0]: originData.insurance?.isPermit,
      interestTitles[1]: originData.loan?.isPermit,
      interestTitles[2]: originData.deposit?.isPermit,
      interestTitles[3]: originData.immovables?.isPermit,
      interestTitles[4]: originData.stock?.isPermit,
      interestTitles[5]: originData.cryto?.isPermit,
      interestTitles[6]: originData.golf?.isPermit,
      interestTitles[7]: originData.tennis?.isPermit,
      interestTitles[8]: originData.fitness?.isPermit,
      interestTitles[9]: originData.yoga?.isPermit,
      interestTitles[10]: originData.dietary?.isPermit,
      interestTitles[11]: originData.educate?.isPermit,
      interestTitles[12]: originData.parental?.isPermit,
      interestTitles[13]: originData.automobile?.isPermit,
      interestTitles[14]: originData.localTrip?.isPermit,
      interestTitles[15]: originData.overseatrip?.isPermit,
      interestTitles[16]: originData.camp?.isPermit,
      interestTitles[17]: originData.fishing?.isPermit,
      interestTitles[18]: originData.pet?.isPermit,
    };
    List<bool> result =[];
    for (int i = 0; i < originData.userInterests!.length; i++){
      result.add(map[originData.userInterests![i]]);
    }
    return result;
  }

  Map<String,List?> getAdditionalAnswersMap(){
    List<String> interestTitles = Questions.interestsDataTitles.values.toList();
    return {
      interestTitles[0]: originData.insurance?.answers,
      interestTitles[1]: originData.loan?.answers,
      interestTitles[2]: originData.deposit?.answers,
      interestTitles[3]: originData.immovables?.answers,
      interestTitles[4]: originData.stock?.answers,
      interestTitles[5]: originData.cryto?.answers,
      interestTitles[6]: originData.golf?.answers,
      interestTitles[7]: originData.tennis?.answers,
      interestTitles[8]: originData.fitness?.answers,
      interestTitles[9]: originData.yoga?.answers,
      interestTitles[10]: originData.dietary?.answers,
      interestTitles[11]: originData.educate?.answers,
      interestTitles[12]: originData.parental?.answers,
      interestTitles[13]: originData.automobile?.answers,
      interestTitles[14]: originData.localTrip?.answers,
      interestTitles[15]: originData.overseatrip?.answers,
      interestTitles[16]: originData.camp?.answers,
      interestTitles[17]: originData.fishing?.answers,
      interestTitles[18]: originData.pet?.answers,
    };
  }
  DateTime durationDate() =>  DateTime.now().add(Duration(days: 1));
  void setInterests(isSelecteds) async{
    List<String> newSelecteds = createNewInterestSelecteds(isSelecteds);
    if(checkInterestHasUpdate(newSelecteds)){
      List<String> keys = createInterestKeysList(newSelecteds);
      Map answersMap = getAdditionalAnswersMap();
      List<List> answers = [];
      List<DateTime?> dates = [];
      List? userInterests = originData.userInterests;
      List checkList = [];
      if(userInterests  == null){
        checkList = [null, null, null];
      }else{
        switch (userInterests.length) {
          case 1 : checkList = [userInterests[0], null, null];break;
          case 2 : checkList = [userInterests[0], userInterests[1], null];break;
          case 3 : checkList = [userInterests[0], userInterests[1], userInterests[2]];break;
        }
      }
      for (int i = 0; i < newSelecteds.length; i++) {
        if(newSelecteds[i] != checkList[i]){
          answers.add(answersMap[newSelecteds[i]]);
          dates.add(durationDate());
        }
      }
      FirebaseUserRepository.updateUserInterests(originData.docId, keys, newSelecteds, dates, answers);
      originData.userInterests = newSelecteds;
      UserModel? userModel = await FirebaseUserRepository.findUserByUid(originData.uid!);
      originData = userModel!;
      myProfile(UserModel.clone(originData));
    }
  }

  List<String> createInterestKeysList(List interests){
    List<String> result = [];
    for (int i = 0; i < interests.length; i++) {
      String key = Questions.interestsDataTitles.keys.firstWhere((k) => 
        Questions.interestsDataTitles[k] == interests[i]);
        result.add(key);
    }
    return result;
  }

  bool checkInterestHasUpdate(List newSelecteds){
    bool result = false;
    if(originData.userInterests?.length != newSelecteds.length){
      result = true;
    }else{ for(int i = 0; i < newSelecteds.length; i++){
      if(originData.userInterests![i] != newSelecteds[i]){
        result = true;
        break;
      }
    }}
    return result;
  }

  List<String> createNewInterestSelecteds(isSelecteds){
    List<String> interestTitles = Questions.interestsDataTitles.values.toList();
    List<String> result = [];
    Map indexMap = isSelecteds.asMap();
    indexMap.forEach((key, value) { 
      if(value){
        result.add(interestTitles[key]);
      }
    });
    return result;
  }

  void setAdditionals(Map<String, List?> answersMap)async{
    List answersList = createAnwersList(answersMap);
    Map originalAnswer = getAdditionalAnswersMap();
    List dates = getInterestDatesWithoutNull();
    List interests = originData.userInterests!;
    List<String> keys = createInterestKeysList(interests);
    for(int i = 0; i < answersList.length; i++){
      for(int j = 0; j < answersList[i].length; j++){
        if (originalAnswer[interests[i]][j] != answersList[i][j]){
          FirebaseUserRepository.updateUserAnswers(
            originData.docId, keys[i], interests[i], dates[i], answersList[i]);
          originalAnswer[interests[i]] = answersList[i];
            break;
        }
      }
    }
    if(originData.isNewUser!){
      FirebaseUserRepository.notNewUser(originData.docId);
      originData.isNewUser = false;
    }
    UserModel? userModel = await FirebaseUserRepository.findUserByUid(originData.uid!);
    originData = userModel!;
    myProfile(UserModel.clone(originData));
  }
  
  List createAnwersList(Map answersMap){
    List<List> result = [];
    for (int i = 0; i < originData.userInterests!.length; i++){
      result.add(answersMap[originData.userInterests![i]]);
    }
    return result;
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
}