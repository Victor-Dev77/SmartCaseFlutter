import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartcaseflutter/models/destination.dart';
import 'package:smartcaseflutter/models/user.dart';

class FirebaseFirestoreAPI {
  final CollectionReference _collectionUser = Firestore.instance.collection("users");
  final CollectionReference _collectionDestination = Firestore.instance.collection("destination");
  final CollectionReference _collectionPoids = Firestore.instance.collection("poids");

  Future<User> getUser(String uid) async {
    try {
      var doc = await _collectionUser.document(uid).get();
      if (doc.data != null) {
        return User.fromDocument(doc);
      }
      return null;
    } catch (_) {
      print("ERROR: Firebase Firestore API: GetUser()");
      return null;
    }
    return null;
  }

  setUser(Map<String, dynamic> user) async {
    await _collectionUser
        .document(user["userId"])
        .setData(user, merge: true);
  }

  Future<List<Destination>> getListDestination(String idUser) async {
    try {
      var doc = await _collectionDestination.document(idUser).collection("places").getDocuments();
      List<Destination> _list = [];
      doc.documents.forEach((data) {
        _list.add(Destination.fromDocument(data));
      });
      return _list;
    } catch (_) {
      print("ERROR: Firebase Firestore API: GetUser()");
      return null;
    }
    return null;
  }

  addDestination(String idUser, Map<String, dynamic> destination) async {
    await _collectionDestination
        .document(idUser)
        .collection("places")
        .document(destination["id"])
        .setData(destination);
  }

  Future<List<double>> getListPoids(String idUser) async {
    try {
      var doc = await _collectionPoids.document(idUser).get();
      List<double> _list = [];
      if (doc.data != null) {
        _list.add(doc.data["poids1"]);
        _list.add(doc.data["poids2"]);
      }
      return _list;
    } catch (_) {
      print("ERROR: Firebase Firestore API: GetUser()");
      return null;
    }
    return null;
  }

  setPoidsToCloud(String idUser, Map<String, dynamic> mapPoids)async {
    await _collectionPoids
        .document(idUser)
        .setData(mapPoids, merge: true);
  }
}
