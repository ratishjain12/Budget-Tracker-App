import 'package:budget_tracker/screens/login_options/login_opt.dart';
import 'package:budget_tracker/services/auth_service.dart';
import 'package:budget_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
            child: Text("Sign out"),
            onPressed: () {
              signOut(context);
            }),
      ),
    );
  }
}

signOut(BuildContext context) async {
  await AuthService().signOut().whenComplete(() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login_opt()));
  });
}
