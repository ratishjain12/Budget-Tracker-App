import 'package:budget_tracker/screens/helper/helper_function.dart';
import 'package:budget_tracker/widgets/colors.dart';
import 'package:budget_tracker/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/auth_service.dart';
import 'forgot_pwd.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  AuthService authService = AuthService();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.secondaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.051,
                      ),
                      Center(
                        child: Text(
                          "Budget Tracker",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Center(
                        child: Container(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.18,
                          child: Image.asset(
                            "assets/images/banner_img.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.07,
                      ),
                      Container(
                        width: screenWidth * 0.75,
                        child: Column(
                          children: [
                            Center(
                                child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            SizedBox(
                              height: screenHeight * 0.05,
                            ),
                            TextFormField(
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "please enter email";
                                }
                                return null;
                              },
                              controller: _email,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                hintText: "Enter Email",
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                letterSpacing: 2,
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "please enter password";
                                }
                                return null;
                              },
                              controller: _password,
                              obscureText: _isObscured,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_isObscured
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscured = !_isObscured;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                hintText: "Enter Password",
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 2),
                              alignment: Alignment.topRight,
                              child: TextButton(
                                child: Text('Forget password?'),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/forget_pwd')
                                      .whenComplete(() => Navigator.pushNamed(
                                          context, '/signin'));
                                },
                              ),
                            ),
                            CustomButton(
                              onPressed: () {
                                login(context);
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: const Text("Dont have a account? Sign up"),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .emailPasswordSignIn(_email.text, _password.text, context)
          .then((value) async {
        if (value == true) {
          await helper_function.saveUserLoggedInStatus(true);
          await helper_function
              .saveUserUid(FirebaseAuth.instance.currentUser!.uid);
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/base', (route) => false);
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
