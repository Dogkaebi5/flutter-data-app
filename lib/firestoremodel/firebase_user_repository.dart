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

  static bool checkPassword(String? docId){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    Map<String, dynamic> data = {};
    users.doc(docId).get().then(
      (doc) => data = doc.data() as Map<String, dynamic>,
      onError: (e) => {print("Error: $e")}
    );
    if(data["password"] != null){ return true;
    }else{ return false; }
  }

  static bool checkIsNewUser(String? docId){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    Map<String, dynamic> data = {};
    users.doc(docId).get().then(
      (doc) => data = doc.data() as Map<String, dynamic>,
      onError: (e) => {print("Error: $e")}
    );
    if(data["nickname"] == null){ return true;
    }else{ return false; }
  }

  static void updateLastLoginDate(String? docId, DateTime time) async{
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.doc(docId).update({
      "last_login_time": time,
      "login_log": FieldValue.arrayUnion([time])});
  }

  static void updatePassword(String? docId, String? password) async{
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.doc(docId).update({"password": password});
  }
  
  static void updateIsPermitTeleMarketing (String? docId, bool isPermit, DateTime? date) async{
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.doc(docId).update({
      "is_permit_telemarketing": isPermit,
      "permit_telemarketing_date": date
    });
  }

  static void updateIsPermitUserData(String? docId, String key, bool isPermit){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({ key: isPermit });
  }

  static void updateIsNoticeService (String? docId,bool isPermit) async{
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.doc(docId).update({"is_notice_service": isPermit});
  }
  static void updateIsNoticeMarketing (String? docId,bool isPermit) async{
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.doc(docId).update({"is_notice_marketing": isPermit});
  }

  static void updateNickname(String? docId, String? nickname) async{
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.doc(docId).update({"nickname": nickname});
  }
  static void updateEmail(String? docId, String? email) async{
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.doc(docId).update({"email": email});
  }

  static void updateBasicData(String? docId, String key, String selected, bool isPermit, DateTime? date){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({key : 
      {"selected" : selected,
      "selected_date" : date,
      "is_permit" : isPermit}
    });
  }

  static void updateUserInterests(String? docId, List<String> keys, List<String> values, List<DateTime?> date, List<List> answers) async{
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    for (int i = 0; i < values.length; i++){
      users.doc(docId).update({
        keys[i] : {
          "title" : values[i],
          "is_selected": true,
          "selected_date": date[i],
          "is_permit": true,
          "answers": answers[i]
        }
      });
    }
    await users.doc(docId).update({"user_interests" : values});
  }

  static void updateUserAnswers(String? docId, String keys, String interests, DateTime date, List answers){
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  users.doc(docId).update({keys: {
      "title" : interests, "is_selected": true, "selected_date": date,
      "is_permit": true, "answers": answers}});
  }

  static void notNewUser(String? docId){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({"is_new_user": false});
  }

  static Future<String?> getUserPassword(String? docId)async{
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    var data = await users.doc(docId).get().then((doc) => doc.data() as Map);
    return data["password"];
  }
}