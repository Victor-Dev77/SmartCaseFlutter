import 'package:smartcaseflutter/api/firebase_firestore_api.dart';
import 'package:get/get.dart';
import 'package:smartcaseflutter/models/destination.dart';
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

  Future<List<Destination>> getListDestination(String idUser) async {
    return await _firestoreAPI.getListDestination(idUser);
  }

  addDestination(String idUser, Map<String, dynamic> destination) async {
    await _firestoreAPI.addDestination(idUser, destination);
  }

  Future<List<double>> getListPoids(String idUser) async {
    return await _firestoreAPI.getListPoids(idUser);
  }

  setPoidsToCloud(String idUser, Map<String, dynamic> mapPoids) async {
    await _firestoreAPI.setPoidsToCloud(idUser, mapPoids);
  }

}
