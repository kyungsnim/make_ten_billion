import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_ten_billion/controller/auth_controller.dart';
import 'package:make_ten_billion/helpers/validator.dart';
import 'package:make_ten_billion/widgets/form_input_field.dart';
import 'package:make_ten_billion/widgets/form_vertical_spacing.dart';
import 'package:make_ten_billion/widgets/primary_button.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // LogoGraphicHeader(),
                  // SizedBox(height: 48.0),
                  SizedBox(height: Get.height * 0.1),
                  Text('매일 부자 습관', style: TextStyle(fontSize: Get.height * 0.05, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  Container(width: Get.width * 0.4, height: Get.width * 0.4, child: Image.asset('assets/icon/icon.jpg')),
                  FormInputFieldWithIcon(
                    controller: authController.nameController,
                    iconPrefix: Icons.person,
                    labelText: '닉네임(별명)',
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.nameController.text = value!,
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: '메일주소',
                    validator: Validator().email,
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
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      labelText: '가입하기',
                      buttonColor: Colors.blueAccent,
                      onPressed: () async {
                        // if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any
                          authController
                              .registerWithEmailAndPassword(context);
                        // }
                      }),
                  SizedBox(height: 10),
                  PrimaryButton(
                      labelText: '로그인',
                      buttonColor: Colors.redAccent,
                      onPressed: () async {
                        Get.back();
                      }),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
