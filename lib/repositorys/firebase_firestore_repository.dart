import 'package:smartcaseflutter/api/firebase_firestore_api.dart';
import 'package:get/get.dart';
import 'package:smartcaseflutter/models/user.dart';

class FirebaseFirestoreRepository {

  static FirebaseFirestoreRepository get to => Get.put(FirebaseFirestoreRepository());

  final FirebaseFirestoreAPI _firestoreAPI = FirebaseFirestoreAPI();

  Future<User> getUser(String uid) async {
    return await _firestoreAPI.getUser(uid);
  }

  setUser(Map<String, dynamic> user) async {
    await _firestoreAPI.setUser(user);
  }

}
