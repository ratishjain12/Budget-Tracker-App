import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'colors.dart';

class GoalWidget extends StatelessWidget {
  String title;
  int goal, saved;
  GoalWidget(
      {Key? key, required this.title, required this.goal, required this.saved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    double filledBar = saved / goal;
    double percent = filledBar * 100;
    String perCent = percent.toStringAsPrecision(4);
    String Goal = goal.toString();
    String Saved = saved.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(top: 20),
            // alignment: Alignment.center,
            width: screenWidth * 0.9,
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
                  height: screenHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(title),
                    ),
                    Container(
                      height: 24,
                      width: 24,
                      margin: EdgeInsets.only(right: 10, top: 15),
                      child: IconButton(
                          onPressed: (() {}),
                          icon: Icon(
                            Icons.edit,
                            size: 15,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearPercentIndicator(
                      animation: true,
                      animationDuration: 1000,
                      width: screenWidth * 0.8,
                      progressColor: AppColors.secondaryColor,
                      backgroundColor: AppColors.primaryColor,
                      percent: filledBar,
                      lineHeight: 30,
                      barRadius: Radius.circular(20),
                      center: Text('$perCent %'),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.65),
                    Text("$Saved / $Goal", textAlign: TextAlign.end),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
