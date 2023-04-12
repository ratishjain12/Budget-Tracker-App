import 'dart:core';

import 'package:budget_tracker/screens/helper/helper_function.dart';
import 'package:budget_tracker/services/database.dart';
import 'package:budget_tracker/widgets/colors.dart';
import 'package:budget_tracker/widgets/custom_button.dart';
import 'package:budget_tracker/widgets/goals_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  final _savingController = TextEditingController();
  String userid = "1";
  bool _isalive = false;
  Stream<QuerySnapshot>? userGoals;

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    getUserDetails();
    fetchUserGoals();
    super.initState();
  }

  Future getUserDetails() async {
    await helper_function.getUserUid().then((value) {
      if (value != null) {
        setState(() {
          userid = value;
          print("userid" + userid);
        });
      }
    });
  }

  Future DeleteGoal(int GoalAmount, String GoalName) async {
    await Database(uid: userid).delGoals(userid, GoalName, GoalAmount);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(GoalName + " Goal completed"),
    ));
    print("delete function executed");
  }

  Future fetchUserGoals() async {
    await getUserDetails().whenComplete(() async {
      await Database(uid: userid).fetchGoals(userid).then((value) {
        if (value != null) {
          setState(() {
            userGoals = value;
          });
        }
      });
    });
  }

  void dispose() {
    _savingController.dispose();
    _goalnameController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    goalsList() {
      return StreamBuilder(
          stream: userGoals,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length != 0) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: ((context, index) {
                      if (snapshot.data.docs[index]['saved'] >=
                          snapshot.data.docs[index]['goal']) {
                        DeleteGoal(snapshot.data.docs[index]['goal'],
                            snapshot.data.docs[index]['title']);
                      }
                      return GoalWidget(
                          title: snapshot.data.docs[index]['title'],
                          goal: snapshot.data.docs[index]['goal'],
                          saved: snapshot.data.docs[index]['saved']);
                    }));
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                      child: MaterialButton(
                    onPressed: () {
                      popupDialog(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle,
                          size: 60,
                          color: Colors.grey[700],
                        ),
                        Padding(padding: EdgeInsets.all(8)),
                        Text(
                          "No Goals were added",
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  )),
                );
              }
            } else {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            }
          });
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text("Goals",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          popupDialog(context);
        },
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical, child: goalsList()),
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
                              return "Please enter goal title";
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
                              return "Please Enter Amount";
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
                            hintText: 'Goal Amount',
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        TextFormField(
                          controller: _savingController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null) {
                              return "Please enter amount";
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
                            hintText: 'Goal Invest Amount',
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        CustomButton(
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              bool res = await addGoal(
                                  context,
                                  userid,
                                  _goalnameController.text,
                                  int.parse(_goalController.text),
                                  int.parse(_savingController.text));
                              if (res) {
                                Navigator.of(context).pop();
                              }
                            }),
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

Future<bool> addGoal(BuildContext context, String userid, String name,
    int goal_amount, int saved) async {
  if (saved > goal_amount) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Saved amount cannot be greater than Goal amount!!")));
    return false;
  } else if (saved <= saved) {
    await Database(uid: userid)
        .addGoal(userid, name, goal_amount, saved)
        .then((value) {
      if (value != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Goal added.")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Goal addition failed.")));
      }
    });
  }
  return true;
}
