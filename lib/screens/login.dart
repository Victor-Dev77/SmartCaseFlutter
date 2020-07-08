import 'package:smartcaseflutter/components/custom_textfield.dart';
import 'package:smartcaseflutter/components/round_btn.dart';
import 'package:smartcaseflutter/controllers/auth_controller.dart';
import 'package:smartcaseflutter/routes.dart';
import 'package:smartcaseflutter/utils/constant.dart';
import 'package:smartcaseflutter/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_validator/the_validator.dart';


class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            // enleve clavier si clique ailleurs
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: EdgeInsets.only(top: 0, left: 30.0, right: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.0),
                      child: Image.asset(Constant.pathLogoImage),
                    ),
                    _buildEmailField(),
                    SizedBox(height: 20.0),
                    _buildPasswordField(),
                    _buildSignInBtn(),
                    _buildChangeToSignUpFormBtn(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      controller: AuthController.to.emailController,
      suffixIcon: Icon(Icons.email),
      hintText: 'Votre Email',
      validator: FieldValidator.email(message: "Adresse email incorrect"),
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      obscureText: true,
      controller: AuthController.to.passwordController,
      suffixIcon: Icon(Icons.lock),
      hintText: 'Mot de passe',
      validator: FieldValidator.password(
        minLength: 6,
        errorMessage: "Le mot de passe doit contenir 6 caractères minimum",
      ),
    );
  }

  Widget _buildSignInBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: RoundBtn(
        text: 'Se Connecter',
        onPressed: () {
          if (_formKey.currentState.validate()) {
            AuthController.to.signIn();
          }
        },
      ),
    );
  }

  Widget _buildChangeToSignUpFormBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: GestureDetector(
        onTap: () => Get.toNamed(Router.signUpRoute),
        child: Container(
          height: 50,
          child: Center(
            child: Text(
              "S'inscrire",
              style: TextStyle(
                color: ConstantColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}