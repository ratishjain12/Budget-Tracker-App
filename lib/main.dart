import 'package:budget_tracker/screens/base.dart';
import 'package:budget_tracker/screens/registeration/forgot_pwd.dart';

import 'package:budget_tracker/screens/helper/helper_function.dart';
import 'package:budget_tracker/screens/home_page.dart';
import 'package:budget_tracker/screens/login_options/login_opt.dart';
import 'package:budget_tracker/screens/login_options/questions.dart';
import 'package:budget_tracker/screens/registeration/sign_in.dart';
import 'package:budget_tracker/screens/registeration/sign_up.dart';
import 'package:budget_tracker/widgets/colors.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    getUserSignedInStatus();
    super.initState();
  }

  getUserSignedInStatus() async {
    await helper_function.getUserLoggedInInstance().then((value) {
      if (value == true) {
        setState(() {
          _isSignedIn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cera Pro',
        colorScheme: const ColorScheme.light()
            .copyWith(primary: AppColors.secondaryColor),
        useMaterial3: true,
      ),
      home: _isSignedIn ? const Base() : const Login_opt(),
      routes: {
        // '/graph': (context) => ChartWidget(),
        '/base': (context) => Base(),
        '/login_opt': (context) => Login_opt(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/questions': (context) => Que(),
        '/home': (context) => HomePage(),
        '/forget_pwd': (context) => ForgotPwdPage(),
      },
    );
  }
}
