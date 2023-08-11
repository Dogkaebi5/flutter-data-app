import 'package:data_project/data/question.dart';
import 'package:data_project/firestoremodel/firebase_user_repository.dart';
import 'package:data_project/firestoremodel/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController{
  UserDataController get to => Get.find();
  UserModel originalUserProfile = UserModel();
  Rx<UserModel> myProfile = UserModel().obs;

  List basicQuestions = Questions().getBasicDataTitles.keys.toList();
  BasicData newBasic = BasicData(null, null, false);

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
          married: newBasic,
          children: newBasic,
          education: newBasic,
          occupation: newBasic,
          income: newBasic,
          residence: newBasic,
          area: newBasic,
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
          isPermitTeleMarketing: false,
        );
        String docId = await FirebaseUserRepository.signup(originalUserProfile);
        originalUserProfile.docId = docId;
      }
    }
    myProfile(UserModel.clone(originalUserProfile));
  }
  
  setNickname(String? nickname){
    if (nickname != null && nickname != ""){
      FirebaseUserRepository.updateNickname(originalUserProfile.docId, nickname);
    }
  }
  setEmail(String? email){
    if (email != null && email != ""){
      FirebaseUserRepository.updateNickname(originalUserProfile.docId, email);
    }
  }


  setBasicData(List basicData)async{
    for(int i = 0; i < basicData.length; i++) {
      if(basicData[i] != null && basicData[i] != ""){
        String question = basicQuestions[i];
        FirebaseUserRepository.updateBasicData(originalUserProfile.docId, question, basicData[i], DateTime.now());
      }
    }
  }
}

