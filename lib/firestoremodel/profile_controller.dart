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
        originalUserProfile = UserModel(
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
          insurance: null,
          loan: null,
          deposit: null,
          immovables: null,
          stock: null,
          cryto: null,
          golf: null,
          tennis: null,
          fitness: null,
          yoga: null,
          dietary: null,
          educate: null,
          parental: null,
          automobile: null,
          localTrip: null,
          overseatrip: null,
          camp: null,
          fishing: null,
          pet: null,
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
    List basicQuestions = Questions().getBasicDataTitles.keys.toList();
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
}

