import 'package:data_project/ctrl/firebase_user_repository.dart';
import 'package:data_project/ctrl/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  RxBool isEditMyProfile = false.obs;
  ProfileController get to => Get.find();
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
          name: firebaseUser.displayName!,
          email: firebaseUser.email!,
          mobile: firebaseUser.phoneNumber,
          createdTime: DateTime.now(), 
          lastLoginTime:  DateTime.now()
        );
        String docId = await FirebaseUserRepository.signup(originalUserProfile);
        originalUserProfile.docId = docId;
      }
    }
    myProfile(UserModel.clone(originalUserProfile));
  }
}

