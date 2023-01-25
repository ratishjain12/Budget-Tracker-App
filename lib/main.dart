import 'package:budget_tracker/screens/login_options/login_opt.dart';
import 'package:budget_tracker/screens/login_options/questions.dart';
import 'package:budget_tracker/screens/registeration/sign_in.dart';
import 'package:budget_tracker/screens/registeration/sign_up.dart';
import 'package:budget_tracker/widgets/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.light().copyWith(primary: AppColors.secondaryColor),
      ),
      home: Login_opt(),
      initialRoute: '/login_opt',
      routes: {
        '/login_opt': (context) => Login_opt(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/questions': (context) => Que(),
      },
    );
  }
}
