import 'package:data_project/firestoremodel/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserRepository {
  static Future<String> signup(UserModel user) async{
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    CollectionReference details = FirebaseFirestore.instance.collection("details");
    DocumentReference drf = await users.add(user.toMap());
    details.doc(user.uid).set({"details": [], "notices": []});
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

  static void updateIsPermitUserData(String? docId, String key, bool isPermit){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({ key: isPermit });
  }

  static void updateIsPermitTeleMarketing (String? docId, bool isPermit, DateTime? date){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({
      "is_permit_telemarketing": isPermit,
      "permit_telemarketing_date": date
    });
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

  static void updateBasicData(String? docId, String key, String? selected, bool isPermit, DateTime? date){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({key : 
      {"selected" : selected,
      "selected_date" : date,
      "is_permit" : isPermit}
    });
  }

  static void updateInterests(String? docId, List<String> newInterests) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.doc(docId).update({"user_interests" : newInterests});
  }
  static void updateInterestDates(String? docId, List dates) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.doc(docId).update({"user_interest_dates" : dates});
  }
  static void updateInterestPermit(String? docId, List permit) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.doc(docId).update({"user_interest_permits" : permit});
  }

  static void updateAnswers(String? docId, List keys, List answers,) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    for(int i = 0; i < keys.length; i++){
      await users.doc(docId).update({keys[i] : answers[i]});
    }
  }

  static void updateIsNewUser(String? docId, bool isNew){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({"is_new_user" : isNew});
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

  static void updatePoint(String? docId, int newPoint){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({"point": newPoint});
  }

  static void updateBank(String? docId, String bank, String acc){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({"bank_name": bank, "bank_account": acc});
  }

  static Future<int> getDetailId(key)async{
    CollectionReference details = FirebaseFirestore.instance.collection("details");
    Map data = await details.doc("ids").get().then((doc) => doc.data() as Map);
    int id = data[key];
    return id;
  }
  static void updateDetailId(key, id){
    CollectionReference details = FirebaseFirestore.instance.collection("details");
    details.doc("ids").update({key: id});
  }
  static Future<List> getDetails(uid) async{
    CollectionReference crf = FirebaseFirestore.instance.collection("details");
    Map data = await crf.doc(uid).get().then((doc) => doc.data() as Map);
    List details = data['details'];
    return details;
  }
  static void updateDetails(uid, Map detail){
    CollectionReference details = FirebaseFirestore.instance.collection("details");
    details.doc(uid).update({"details": FieldValue.arrayUnion([detail])});
  }

  // static getTeleSaleDetailId()async{
  //   CollectionReference details = FirebaseFirestore.instance.collection("details");
  //   var id = await details.doc("tele_sale_details_id").get().then((doc) => doc.data());
  //   return id;
  // }
  // static getWithdrawDetailId()async{
  //   CollectionReference details = FirebaseFirestore.instance.collection("details");
  //   var id = await details.doc("withdraw_details_id").get().then((doc) => doc.data());
  //   return id;
  // }

  static Future<List> getNotices(uid)async{
    CollectionReference crf = FirebaseFirestore.instance.collection("details");
    Map data = await crf.doc(uid).get().then((doc) => doc.data() as Map);
    List notices = data['notices'];
    return notices;
  }
  static void updateNotices(uid, Map notice){
    CollectionReference details = FirebaseFirestore.instance.collection("details");
    details.doc(uid).update({"notices": FieldValue.arrayUnion([notice])});
  }

  static resetUser(String? docId, UserModel empty){
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    CollectionReference details = FirebaseFirestore.instance.collection("details");
    Map emptyUser = empty.toMap();
    details.doc(empty.uid).update({"details": []});
    details.doc(empty.uid).update({"notices": []});
    users.doc(docId).update(emptyUser as Map<Object, Object?>);
  }
}