import 'package:budget_tracker/screens/helper/helper_function.dart';
import 'package:budget_tracker/screens/home_page.dart';
import 'package:budget_tracker/screens/login_options/questions.dart';
import 'package:budget_tracker/services/auth_service.dart';
import 'package:budget_tracker/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/widgets/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login_opt extends StatefulWidget {
  const Login_opt({Key? key}) : super(key: key);

  @override
  State<Login_opt> createState() => _Login_optState();
}

class _Login_optState extends State<Login_opt> {
  bool _isLoading = false;
  AuthService authservice = AuthService();
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: screenHeight * 0.07,
                    ),
                    Center(
                      child: Text(
                        'Budget Tracker',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.08,
                    ),
                    Center(
                      child: Container(
                        width: screenWidth * 0.65,
                        height: screenHeight * 0.25,
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
                      height: screenHeight * 0.35,
                      width: screenWidth * 0.7,
                      child: Column(
                        children: <Widget>[
                          CustomButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signin');
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.mail,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 75,
                                ),
                                Text(
                                  'E-mail',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Container(
                            child: Text(
                                '------------------- OR -------------------'),
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          CustomButton(
                            child: Row(
                              children: [
                                new Tab(
                                  icon: new Image.asset(
                                      'assets/images/google.jpg'),
                                  height: 24,
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                Text(
                                  'Sign in with google',
                                  style: TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                            onPressed: (() {
                              setState(() {
                                _isLoading = true;
                              });
                              authservice.googleSignin().whenComplete(() async {
                                await helper_function
                                    .getUserOnboaringInstance()
                                    .then((value) async {
                                  if (value == true) {
                                    await helper_function
                                        .saveUserLoggedInStatus(true);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  } else {
                                    _isLoading = false;
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => Que()));
                                  }
                                });
                              });
                            }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
