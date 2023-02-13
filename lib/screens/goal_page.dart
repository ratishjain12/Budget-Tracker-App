import 'dart:ffi';

import 'package:budget_tracker/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({Key? key}) : super(key: key);

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(left: 37, top: 20),
                // alignment: Alignment.center,
                width: screenWidth * 0.8,
                height: screenHeight * 0.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ]),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.025,
                    ),
                    Text('Your Goal'),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    LinearPercentIndicator(
                      animation: true,
                      animationDuration: 1000,
                      width: screenWidth * 0.8,
                      progressColor: AppColors.secondaryColor,
                      backgroundColor: AppColors.primaryColor,
                      percent: 0.4,
                      lineHeight: 30,
                      barRadius: Radius.circular(20),
                      center: Text('percent'),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      children: [
                        SizedBox(width: screenWidth * 0.5),
                        Text("Saved / Goal", textAlign: TextAlign.end),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
