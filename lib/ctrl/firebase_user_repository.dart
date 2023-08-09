import 'package:data_project/ctrl/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserRepository {
  static Future<String> signup(UserModel user) async{
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    DocumentReference drf = await users.add(user.toMap());
    return drf.id;
  }

  static Future<UserModel?> findUserByUid(String uid) async{
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    QuerySnapshot data = await users.where("uid", isEqualTo: uid).get();
    if (data.size == 0){
      return null;
    }else{
      return UserModel.fromJson(data.docs[0].data(), data.docs[0].id);
    }

  }
}