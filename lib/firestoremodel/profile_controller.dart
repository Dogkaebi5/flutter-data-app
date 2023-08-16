import 'package:data_project/data/question.dart';
import 'package:data_project/firestoremodel/firebase_user_repository.dart';
import 'package:data_project/firestoremodel/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController{
  UserDataController get to => Get.find();
  UserModel originalUserProfile = UserModel();
  Rx<UserModel> myProfile = UserModel().obs;
  
  authStateChanges(User? firebaseUser) async {
    if(firebaseUser != null){
      UserModel? userModel = await FirebaseUserRepository.findUserByUid(firebaseUser.uid);
      if (userModel != null){
        originalUserProfile = userModel;
        FirebaseUserRepository.updateLastLoginDate(userModel.docId, DateTime.now());
      } else {
        List<String> interestTitles = Questions.interests.keys.toList();
        originalUserProfile = UserModel(
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
          isPermitTelemarketing: false,
          permitTelemarketingDate: null,
        );
        String docId = await FirebaseUserRepository.signup(originalUserProfile);
        originalUserProfile.docId = docId;
      }
    }
    myProfile(UserModel.clone(originalUserProfile));
  }

  bool checkHasPassword(){
    return FirebaseUserRepository.checkPassword(originalUserProfile.docId);
  }
  bool checkIsNewUser(){
    return FirebaseUserRepository.checkIsNewUser(originalUserProfile.docId);
  }

  changePermitTeleMarketing(bool isPermit){
    originalUserProfile.isPermitTelemarketing = isPermit;
    originalUserProfile.permitTelemarketingDate = (isPermit) ? DateTime.now() : null;
    FirebaseUserRepository.updateIsPermitTeleMarketing(
      originalUserProfile.docId, 
      originalUserProfile.isPermitTelemarketing!,
      originalUserProfile.permitTelemarketingDate
    );
  }
  changeNoticeService(){
    if(originalUserProfile.isNoticeService != null){
      originalUserProfile.isNoticeService = !originalUserProfile.isNoticeService!;
      FirebaseUserRepository.updateIsNoticeService(originalUserProfile.docId, originalUserProfile.isNoticeService!);
    }
  }
  changeNoticeMarketing(){
    if(originalUserProfile.isNoticeMarketing != null){
      originalUserProfile.isNoticeMarketing = !originalUserProfile.isNoticeMarketing!;
      FirebaseUserRepository.updateIsNoticeMarketing(originalUserProfile.docId, originalUserProfile.isNoticeMarketing!);
    }
  }
  setNewPassword(String pw){
    if (pw.length == 4){
      FirebaseUserRepository.updatePassword(originalUserProfile.docId, pw);
    }
  }
  setNickname(String? nickname){
    if (nickname != null && nickname != ""){
      FirebaseUserRepository.updateNickname(originalUserProfile.docId, nickname);
      originalUserProfile.nickname = nickname;
      myProfile(UserModel.clone(originalUserProfile));
    }
  }
  setEmail(String? email){
    if (email != null && email != ""){
      FirebaseUserRepository.updateEmail(originalUserProfile.docId, email);
      originalUserProfile.email = email;
      myProfile(UserModel.clone(originalUserProfile));
    }
  }
  setBasicData(List basicData, List dates)async{
    bool isUpdated = false;
    List basicQuestions = Questions.basicDataTitles.keys.toList();
    for(int i = 0; i < basicData.length; i++){
      if(basicData[i] != null && dates[i] == null){
        String question = basicQuestions[i];
        FirebaseUserRepository.updateBasicData(originalUserProfile.docId, question, basicData[i], DateTime.now());
        isUpdated = true;
      }
    }
    if(isUpdated){
      UserModel? userModel = await FirebaseUserRepository.findUserByUid(originalUserProfile.uid!);
      originalUserProfile = userModel!;
      myProfile(UserModel.clone(originalUserProfile));
      isUpdated = false;
    }
  }

  List<bool> getSelectedsList(){
    return [
      originalUserProfile.insurance!.isSelected, 
      originalUserProfile.loan!.isSelected, 
      originalUserProfile.deposit!.isSelected, 
      originalUserProfile.immovables!.isSelected, 
      originalUserProfile.stock!.isSelected, 
      originalUserProfile.cryto!.isSelected, 
      originalUserProfile.golf!.isSelected, 
      originalUserProfile.tennis!.isSelected, 
      originalUserProfile.fitness!.isSelected, 
      originalUserProfile.yoga!.isSelected, 
      originalUserProfile.dietary!.isSelected, 
      originalUserProfile.educate!.isSelected, 
      originalUserProfile.parental!.isSelected, 
      originalUserProfile.automobile!.isSelected, 
      originalUserProfile.localTrip!.isSelected, 
      originalUserProfile.overseatrip!.isSelected, 
      originalUserProfile.camp!.isSelected, 
      originalUserProfile.fishing!.isSelected, 
      originalUserProfile.pet!.isSelected
    ];
  }
  Map<String,List?> getAdditionalAnswersMap(){
    List<String> interestTitles = Questions.interestsDataTitles.values.toList();
    return {
      interestTitles[0]: originalUserProfile.insurance?.answers,
      interestTitles[1]: originalUserProfile.loan?.answers,
      interestTitles[2]: originalUserProfile.deposit?.answers,
      interestTitles[3]: originalUserProfile.immovables?.answers,
      interestTitles[4]: originalUserProfile.stock?.answers,
      interestTitles[5]: originalUserProfile.cryto?.answers,
      interestTitles[6]: originalUserProfile.golf?.answers,
      interestTitles[7]: originalUserProfile.tennis?.answers,
      interestTitles[8]: originalUserProfile.fitness?.answers,
      interestTitles[9]: originalUserProfile.yoga?.answers,
      interestTitles[10]: originalUserProfile.dietary?.answers,
      interestTitles[11]: originalUserProfile.educate?.answers,
      interestTitles[12]: originalUserProfile.parental?.answers,
      interestTitles[13]: originalUserProfile.automobile?.answers,
      interestTitles[14]: originalUserProfile.localTrip?.answers,
      interestTitles[15]: originalUserProfile.overseatrip?.answers,
      interestTitles[16]: originalUserProfile.camp?.answers,
      interestTitles[17]: originalUserProfile.fishing?.answers,
      interestTitles[18]: originalUserProfile.pet?.answers,
    };
  }
  
  List<DateTime?> getInterestDates(){
    return [
      originalUserProfile.insurance?.selectedDate,
      originalUserProfile.loan?.selectedDate,
      originalUserProfile.deposit?.selectedDate,
      originalUserProfile.immovables?.selectedDate,
      originalUserProfile.stock?.selectedDate,
      originalUserProfile.cryto?.selectedDate,
      originalUserProfile.golf?.selectedDate,
      originalUserProfile.tennis?.selectedDate,
      originalUserProfile.fitness?.selectedDate,
      originalUserProfile.yoga?.selectedDate,
      originalUserProfile.dietary?.selectedDate,
      originalUserProfile.educate?.selectedDate,
      originalUserProfile.parental?.selectedDate,
      originalUserProfile.automobile?.selectedDate,
      originalUserProfile.localTrip?.selectedDate,
      originalUserProfile.overseatrip?.selectedDate,
      originalUserProfile.camp?.selectedDate,
      originalUserProfile.fishing?.selectedDate,
      originalUserProfile.pet?.selectedDate];
  }
  
  List<String> createInterestKeysList(List interests){
    List<String> list = [];
    for (int i = 0; i < interests.length; i++) {
      String key = Questions.interestsDataTitles.keys.firstWhere((k) => 
        Questions.interestsDataTitles[k] == interests[i]);
        list.add(key);
    }
    return list;
  }
  
  DateTime durationDate() =>  DateTime.now().add(Duration(days: 1));

  void setInterests(List<String> values) async{
    List<String> keys = createInterestKeysList(values);
    Map answersMap = getAdditionalAnswersMap();
    List<List> answers = [];
    List<DateTime?> dates = [];
    for (int i = 0; i < values.length; i++) {
      answers.add(answersMap[values[i]]);
      dates.add(durationDate());
    }
    if(values.isNotEmpty){
      FirebaseUserRepository.updateUserInterests(originalUserProfile.docId, keys, values, dates, answers);
      UserModel? userModel = await FirebaseUserRepository.findUserByUid(originalUserProfile.uid!);
      originalUserProfile = userModel!;
      myProfile(UserModel.clone(originalUserProfile));
    }
  }
}

