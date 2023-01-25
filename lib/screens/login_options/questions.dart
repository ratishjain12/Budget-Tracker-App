import 'package:budget_tracker/widgets/colors.dart';
import 'package:budget_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Que extends StatefulWidget {
  const Que({Key? key}) : super(key: key);

  @override
  State<Que> createState() => _QueState();
}

class _QueState extends State<Que> {
  final _FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _FormKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 0.30,
                ),
                Container(
                  width: 300,
                  child: Center(
                    child: Text(
                      'Monthly Income',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.07,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      hintText: "Salary",
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                SizedBox(
                  child: Center(
                    child: CustomButton(
                        width: 300,
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 17),
                        ),
                        onPressed: (() {
                          print('Pressed');
                        })),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
