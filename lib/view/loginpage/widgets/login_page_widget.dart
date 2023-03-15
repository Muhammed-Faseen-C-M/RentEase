import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/main.dart';
import 'package:rentease/model/loginmodel/login_model.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/textformfield.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/controller/signin/login_functions.dart';
import 'package:rentease/controller/signin/signin_google.dart';
import 'package:rentease/view/loginpage/widgets/forgotpswd_screen.dart';
import 'package:rentease/view/loginpage/widgets/google_widget.dart';
import 'package:rentease/view/signuppage/signup_screen.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                StringConsts.logintext,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                    color: kwhiteColor),
              ),
              Text(
                StringConsts.welcomeBack,
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                    color: kwhiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginSection extends StatelessWidget {
  const LoginSection({super.key});
  static final loginFormKey = GlobalKey<FormState>();
  static LoginModel loginmodel = Get.put(LoginModel());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: kwhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.0),
            topRight: Radius.circular(60.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextFieldWidget(
                  hintText: StringConsts.emailText,
                  controller: loginmodel.emailController,
                  radiusBottomLeft: 0.0,
                  radiusBottomRight: 0.0,
                  keyboardType: TextInputType.emailAddress,
                  isEmail: true,
                ),
                TextFieldWidget(
                  hintText: StringConsts.passwordText,
                  controller: loginmodel.passwordController,
                  radiusRight: 0.0,
                  radiusleft: 0.0,
                  obscureText: !loginmodel.passwordVisible,
                  suffixIcon: true,
                  isPswd: true,
                  prefixIcon: Icons.lock,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "\t\tEnter password\n";
                    } else if (value.length < 6) {
                      return "\t\tEnter a valid password";
                    }
                  },
                ),
                kheight20,
                kheight20,
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ));
                    },
                    child: Text(
                      StringConsts.forgotpassText,
                      style: TextStyle(
                          fontSize: 15.0,
                          decorationColor: kBlue900,
                          decoration: TextDecoration.underline),
                    )),
                kheight20,
                ButtonWidget(
                  text: StringConsts.logintext,
                  onpressed: (context) {
                    final isValid = loginFormKey.currentState!.validate();
                    if (!isValid) return;
                    signIn(
                        context: context,
                        email: loginmodel.emailController.text.trim(),
                        password: loginmodel.passwordController.text.trim());
                  },
                ),
                kheight20,
                const Text(StringConsts.signinWithText),
                kheight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          siginInWithGoogle(context: context);
                        },
                        child: const SignInContainer())
                  ],
                ),
                kheight20,
                const Text(StringConsts.noAccountText),
                ButtonWidget(
                  text: StringConsts.signUpText,
                  onpressed: (context) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
