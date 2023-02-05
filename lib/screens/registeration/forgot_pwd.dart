import 'package:budget_tracker/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPwdPage extends StatefulWidget {
  const ForgotPwdPage({Key? key}) : super(key: key);

  @override
  State<ForgotPwdPage> createState() => _ForgotPwdPageState();
}

class _ForgotPwdPageState extends State<ForgotPwdPage> {
  final _forgetpwd = TextEditingController();
  @override
  void dispose() {
    _forgetpwd.dispose();
    super.dispose();
  }

  Future passWordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _forgetpwd.text.trim());
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              content: Text("Email has been sent to your email id"),
            );
          }));
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                e.message.toString(),
              ),
            );
          });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter your email for change the password '),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _forgetpwd,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    hintText: "Enter email",
                  ),
                ),
              ),
            ),
            CustomButton(
              child: Text('Submit'),
              onPressed: () => passWordReset(),
            )
          ],
        ),
      ),
    );
  }
}
