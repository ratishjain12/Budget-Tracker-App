import 'package:budget_tracker/screens/helper/helper_function.dart';
import 'package:budget_tracker/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/colors.dart';
import '../../widgets/custom_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _username = TextEditingController();
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
      appBar: AppBar(
        surfaceTintColor: AppColors.secondaryColor,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      backgroundColor: AppColors.primaryColor,
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
                        height: screenHeight * 0.1,
                      ),
                      Container(
                        width: screenWidth * 0.75,
                        child: Column(
                          children: [
                            Center(
                                child: Text(
                              "Sign up",
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
                                  return "username cannot be empty";
                                }
                                return null;
                              },
                              controller: _username,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                hintText: "Enter Username",
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            TextFormField(
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "email cannot be empty";
                                }
                                return null;
                              },
                              controller: _email,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                prefixIcon: Icon(
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
                              controller: _password,
                              obscureText: _isObscured,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: (() {
                                      setState(() {
                                        _isObscured = !_isObscured;
                                      });
                                    }),
                                    icon: Icon(_isObscured
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                hintText: "Enter Password",
                              ),
                              validator: (val) {
                                if (val!.length < 8) {
                                  return "Password must be at least 8 characters long";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: screenHeight * 0.05,
                            ),
                            CustomButton(
                              onPressed: () {
                                register(context);
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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

  register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .emailPasswordSignUp(
              _email.text, _password.text, _username.text, context)
          .then((value) async {
        if (value == true) {
          await helper_function.saveUserLoggedInStatus(true);
          await helper_function
              .saveUserUid(FirebaseAuth.instance.currentUser!.uid);
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/questions', (route) => false);
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
