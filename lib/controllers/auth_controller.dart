import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartcaseflutter/controllers/user_controller.dart';
import 'package:smartcaseflutter/repositorys/firebase_auth_repository.dart';
import 'package:smartcaseflutter/repositorys/firebase_firestore_repository.dart';
import 'package:get/get.dart';
import 'package:smartcaseflutter/routes.dart';
import 'package:smartcaseflutter/models/user.dart';

class AuthController extends GetxController {

  // sert a acceder a ce controller partout
  static AuthController get to => Get.find();

  Stream<FirebaseUser> _onAuthStateChanged;

  FirebaseAuthRepository _authRepo = FirebaseAuthRepository.to;
  FirebaseFirestoreRepository _bddRepo = FirebaseFirestoreRepository.to;

  @override
  void onInit() async {
    super.onInit();
    //_currentUser = Rx(await _authRepo.getCurrentUser());
    _onAuthStateChanged = _authRepo.onAuthStateChanged;
    _onAuthStateChanged.listen((event) async {
      if (event == null) {
        //_currentUser.value = null;
        Get.offAllNamed(Router.loginRoute);
      } else {
        FirebaseUser _currentUser = await _authRepo.getCurrentUser();
        User user = await _bddRepo.getUser(_currentUser.uid);
        if (user == null) {
          user = await _registerUser(_currentUser.uid, _emailController.text.trim(), _pseudoController.text.trim(), _passwordController.text.trim());
        }
        if (user != null) {
          UserController.to.initUser(user);
          Get.offAllNamed(Router.homeRoute);
        } else {
          Get.offAllNamed(Router.loginRoute);
        }
      }
    });
  }


  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => this._emailController;

  final TextEditingController _pseudoController = TextEditingController();
  TextEditingController get pseudoController => this._pseudoController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => this._passwordController;

  signIn() async {
    try {
      await _authRepo.signIn(_emailController.text.trim(), _passwordController.text.trim());
    } catch (err) {
      print("ERROR: AuthController: signin()");
    }
  }

  signUp() async {
    try {
      await _authRepo.signUp(_emailController.text.trim(), _passwordController.text.trim());
    } catch (err) {
      print("ERROR: AuthController: signUp() - $err");
    }
  }

  Future<User> _registerUser(String id, String email, String pseudo,
      String password) async {
    User user = User(id: id, mail: email, pseudo: pseudo);
    UserController.to.initUser(user);
    await _bddRepo.setUser(user.toMap());
    return user;
  }

  signOut() async {
    await _authRepo.signOut();
  }
}
