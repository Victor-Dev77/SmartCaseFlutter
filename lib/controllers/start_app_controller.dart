import 'package:smartcaseflutter/controllers/user_controller.dart';
import 'package:smartcaseflutter/repositorys/firebase_auth_repository.dart';
import 'package:smartcaseflutter/repositorys/firebase_firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StartAppController extends GetController {

  FirebaseAuthRepository _authRepo;
  FirebaseFirestoreRepository _bddRepo;
  FirebaseUser _currentUser;
  AuthStatus _authStatus;

  FirebaseUser get currentUser => this._currentUser;
  AuthStatus get authStatus => this._authStatus;

  @override
  void onInit() {
    // Appelé a la creation et appeler qu'une fois
    super.onInit();
    _authStatus = AuthStatus.loading;
    update();
    _authRepo = FirebaseAuthRepository.to;
    _bddRepo = FirebaseFirestoreRepository.to;
    _initUser();
  }

  _initUser() async {
    _currentUser = await _authRepo.getCurrentUser();
    if (_currentUser != null) {
      var user = await _bddRepo.getUser(_currentUser.uid);
      if (user != null) {
        _authStatus = AuthStatus.connected;
        UserController.to.user = user;
      }
      else 
        _authStatus = AuthStatus.disconnected;
    }
    else
      _authStatus = AuthStatus.disconnected;
    update();
  }
  
}

//TOOD: changer en observable (stream ==> RxController ? Obx ? GetX ?)
enum AuthStatus {
  loading,
  connected,
  disconnected
}