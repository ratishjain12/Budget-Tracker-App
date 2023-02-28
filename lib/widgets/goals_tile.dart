import 'package:budget_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'colors.dart';

class GoalWidget extends StatefulWidget {
  String title;
  int goal, saved;
  GoalWidget(
      {Key? key, required this.title, required this.goal, required this.saved})
      : super(key: key);

  @override
  State<GoalWidget> createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  final _addingController = TextEditingController();
  @override
  bool get wantKeepAlive => true;
  @override
  void dispose() {
    // TODO: implement dispose
    _addingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    double filledBar = widget.saved / widget.goal;
    double percent = filledBar * 100;
    String perCent = percent.toStringAsPrecision(4);
    int saved = widget.saved;
    String Goal = widget.goal.toString();
    String Saved = widget.saved.toString();

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
                      child: Text(widget.title),
                    ),
                    Container(
                      height: 24,
                      width: 24,
                      margin: EdgeInsets.only(right: 10, top: 15),
                      child: IconButton(
                          onPressed: (() {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: ((context, setState) {
                                    return Center(
                                      child: AlertDialog(
                                        title: Text(
                                          widget.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: Container(
                                          height: screenHeight * 0.13,
                                          child: Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        _addingController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return "Please Enter Amount";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .secondaryColor),
                                                      ),
                                                      border:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                      ),
                                                      hintText: 'Saving Amount',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  CustomButton(
                                                      child: Text('Submit'),
                                                      onPressed: (() {
                                                        setState(
                                                          () {
                                                            saved = saved +
                                                                int.parse(
                                                                    _addingController
                                                                        .text);
                                                          },
                                                        );
                                                      }))
                                                ],
                                              )),
                                        ),
                                      ),
                                    );
                                  }));
                                });
                          }),
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
                      animationDuration: 1500,
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
                    Text("$Saved / $Goal"),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
