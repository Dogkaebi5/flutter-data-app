import 'package:data_project/data/question.dart';
import 'package:data_project/firestoremodel/firebase_user_repository.dart';
import 'package:data_project/firestoremodel/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController{
  UserDataController get to => Get.find();
  UserModel originalUserProfile = UserModel();
  Rx<UserModel> myProfile = UserModel().obs;
  List<String> interestTitles = Questions.interests.keys.toList();

  authStateChanges(User? firebaseUser) async {
    if(firebaseUser != null){
      UserModel? userModel = await FirebaseUserRepository.findUserByUid(firebaseUser.uid);
      if (userModel != null){
        originalUserProfile = userModel;
        FirebaseUserRepository.updateLastLoginDate(userModel.docId, DateTime.now());
      } else {
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
    List basicQuestions = Questions().getBasicTitles.keys.toList();
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
  setInterests(List interest, List dates) async{
    if(interest.isNotEmpty){
      FirebaseUserRepository.updateUserInterests(originalUserProfile.docId, interest, dates);
      UserModel? userModel = await FirebaseUserRepository.findUserByUid(originalUserProfile.uid!);
      originalUserProfile = userModel!;
      myProfile(UserModel.clone(originalUserProfile));
    }
  }
}

