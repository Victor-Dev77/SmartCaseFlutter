import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartcaseflutter/controllers/auth_controller.dart';
import 'package:smartcaseflutter/models/user.dart';
import 'package:smartcaseflutter/routes.dart';
import 'package:smartcaseflutter/utils/constant.dart';
import 'package:smartcaseflutter/utils/constant_color.dart';
import 'package:smartcaseflutter/utils/constant_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //final _auth = FirebaseAuth.instance;
  String email, password, pseudo;

  /*Future<void> signUserIn() async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        await _registerUser(newUser.user);
        Get.toNamed(Router.squeletonRoute, arguments: Constant.currentUser.isOrganizer);
       // Navigator.pushNamedAndRemoveUntil(context, Router.squeletonRoute, ModalRoute.withName(Router.signUpRoute), arguments: Constant.currentUser.isOrganizer);
      }
    } catch (e) {
      print(e);
    }
  }*/

  /*_registerUser(FirebaseUser user) async {
    Map<String, dynamic> data = {
      "userId": user.uid,
      "pseudo": pseudo,
      "mail": email,
      "isOrganizer": isChecked,
    };
    print("avant ");
    await Firestore.instance
        .collection(ConstantFirestore.collectionUser)
        .document(user.uid)
        .setData(data, merge: true);
    print("apres");
    Constant.currentUser = User(
      id: data["userId"],
      pseudo: data["pseudo"],
      mail: data["mail"],
      isOrganizer: data["isOrganizer"],
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: GestureDetector(
          onTap: () => FocusScope.of(context)
              .unfocus(), // enleve clavier si clique ailleurs
          child: Container(
            padding: EdgeInsets.only(top: 0, left: 30.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Image.asset(Constant.pathLogoImage)),
                TextField(
                    style: TextStyle(fontWeight: FontWeight.w500),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email),
                        hintText: 'Votre Email',
                        labelText: 'Votre Email',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400))),
                SizedBox(height: 10.0),
                TextField(
                    style: TextStyle(fontWeight: FontWeight.w500),
                    onChanged: (value) {
                      pseudo = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person),
                        hintText: 'Pseudo',
                        labelText: 'Pseudo',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400))),
                SizedBox(height: 10.0),
                TextField(
                    obscureText: true,
                    style: TextStyle(fontWeight: FontWeight.w500),
                    onChanged: (value) {
                      password = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.lock),
                        hintText: 'Mot de passe',
                        labelText: 'Mot de passe',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400))),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      //TODO: gerer champs dans controller, ensuite pas envoyer en
                    // param email, pwd etc.. car sera deja dans controller
                      AuthController.to.signUp(email, pseudo, password);
                     // signUserIn();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                    elevation: 6.0,
                    fillColor: ConstantColor.primaryColor,
                    shape: StadiumBorder(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 50),
                  child: GestureDetector(
                    onTap: () => Get.back(),//Navigator.pop(context),
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          "Se Connecter",
                          style: TextStyle(
                            color: ConstantColor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
