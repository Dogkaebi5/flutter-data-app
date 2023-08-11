import 'package:data_project/firestoremodel/user_model.dart';
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
  
  static void updateLastLoginDate(String? docId, DateTime time){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({"last_login_time": time});
    users.doc(docId).update({"login_log": FieldValue.arrayUnion([time])});
  }

  static void updatePassword(String? docId, String? password){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({"password": password});
  }

  static void updateNickname(String? docId, String? nickname){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({"nickname": nickname});
  }
  static void updateEmail(String? docId, String? email){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({"email": email});
  }

  static void updateBasicData(String? docId, String question, String selected, DateTime selectedDate){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({question : 
      {"selected" : selected,
      "selectedDate" : selectedDate,
      "isPermit" : true}
    });
  }
}