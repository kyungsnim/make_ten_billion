import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_ten_billion/controller/auth_controller.dart';
import 'package:make_ten_billion/views/sign_up.dart';
import 'package:make_ten_billion/widgets/form_input_field.dart';
import 'package:make_ten_billion/widgets/form_vertical_spacing.dart';
import 'package:make_ten_billion/widgets/label_button.dart';
import 'package:make_ten_billion/widgets/primary_button.dart';
import 'package:make_ten_billion/widgets/sns_login_button.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController.to;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // LogoGraphicHeader(),
                    // SizedBox(height: 48.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    FormInputFieldWithIcon(
                      controller: authController.emailController,
                      iconPrefix: Icons.email,
                      labelText: '회사 메일주소',
                      // validator: Validator().email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                      onSaved: (value) =>
                          authController.emailController.text = value!,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: authController.passwordController,
                      iconPrefix: Icons.lock,
                      labelText: '비밀번호',
                      // validator: Validator().password,
                      obscureText: true,
                      onChanged: (value) => null,
                      onSaved: (value) =>
                          authController.passwordController.text = value!,
                      maxLines: 1,
                    ),
                    FormVerticalSpace(),
                    PrimaryButton(
                        labelText: '로그인',
                        buttonColor: Colors.amber,
                        onPressed: () async {
                          // if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any
                          authController.signInWithEmailAndPassword(context);
                          // }
                        }),
                    SizedBox(height: 10),
                    PrimaryButton(
                        labelText: '회원가입',
                        buttonColor: Colors.lightBlue,
                        onPressed: () async {
                          Get.to(() => SignUp());
                        }),
                    FormVerticalSpace(),
                    SnsLoginButton(
                        backgroundColor: Colors.white,
                        textColor: Colors.black87,
                        labelText: 'Sign in with google',
                        onPressed: authController.signInWithGoogle),
                    SizedBox(height: 10),
                    SnsLoginButton(
                        backgroundColor: Colors.yellow,
                        textColor: Colors.black87,
                        labelText: 'Sign in with Kakao',
                        onPressed: authController.signInWithGoogle),
                    SizedBox(height: 10),
                    SnsLoginButton(
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        labelText: 'Sign in with Apple',
                        onPressed: authController.signInWithGoogle),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
