import 'package:budget_tracker/widgets/colors.dart';
import 'package:budget_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({Key? key}) : super(key: key);

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  final _goalnameController = TextEditingController();
  final _goalController = TextEditingController();

  @override
  bool get wantKeepAlive => true;
  @override
  void dispose() {
    // TODO: implement dispose
    _goalnameController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text("Budget Tracker"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          popupDialog(context);
        },
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

  popupDialog(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return Center(
              child: AlertDialog(
                title: Text(
                  "Add goal",
                  textAlign: TextAlign.center,
                ),
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _goalnameController,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please enter value";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.secondaryColor),
                            ),
                            border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.secondaryColor),
                            ),
                            hintText: 'Goal name',
                          ),
                        ),
                        SizedBox(
                          height: screenWidth * 0.02,
                        ),
                        TextFormField(
                          controller: _goalController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Value";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.secondaryColor),
                            ),
                            border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.secondaryColor),
                            ),
                            hintText: 'Amount',
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        CustomButton(
                            child: Text("Submit"), onPressed: () async {})
                      ],
                    ),
                  ),
                ),
              ),
            );
          }));
        });
  }
}
