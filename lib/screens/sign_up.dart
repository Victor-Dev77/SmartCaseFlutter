import 'package:smartcaseflutter/components/custom_textfield.dart';
import 'package:smartcaseflutter/components/round_btn.dart';
import 'package:smartcaseflutter/controllers/auth_controller.dart';
import 'package:smartcaseflutter/utils/constant.dart';
import 'package:smartcaseflutter/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_validator/the_validator.dart';
import 'package:lottie/lottie.dart';


class SignUp extends StatelessWidget {
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
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildLogo(),
                    _buildEmailField(),
                    SizedBox(height: 10.0),
                    _buildPseudoField(),
                    SizedBox(height: 10.0),
                    _buildPasswordField(),
                    _buildSignUpBtn(),
                    _buildChangeToSignInFormBtn(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Lottie.asset(
          Constant.pathLottie,
            width: 100,
            height: 250
        ),
        Text(
          "BLUE\nSMART",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30
          )
        )
      ],
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      controller: AuthController.to.emailController,
      suffixIcon: Icon(Icons.email, color: ConstantColor.white),
      hintText: 'Votre Email',
      validator: FieldValidator.email(message: "Adresse email incorrect"),
    );
  }

  Widget _buildPseudoField() {
    return CustomTextField(
      controller: AuthController.to.pseudoController,
      suffixIcon: Icon(Icons.person, color: ConstantColor.white),
      hintText: "Votre Pseudo",
      validator:
          FieldValidator.minLength(3, message: "Le pseudo doit contenir 3 caractères minimum"),
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      obscureText: true,
      controller: AuthController.to.passwordController,
      suffixIcon: Icon(Icons.lock, color: ConstantColor.white),
      hintText: 'Mot de passe', 
      validator: FieldValidator.password(
        minLength: 6,
        errorMessage: "Le mot de passe doit contenir 6 caractères minimum",
      ),
    );
  }

  Widget _buildSignUpBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: RoundBtn(
        text:  "S'inscrire",
        onPressed: () {
          if (_formKey.currentState.validate()) AuthController.to.signUp();
        },
      ),
    );
  }

  Widget _buildChangeToSignInFormBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 50),
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          height: 50,
          child: Center(
            child: Text(
              "Se Connecter",
              style: TextStyle(
                color: ConstantColor.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}