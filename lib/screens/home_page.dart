// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_tracker/screens/helper/helper_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:budget_tracker/screens/login_options/login_opt.dart';
import 'package:budget_tracker/services/auth_service.dart';
import 'package:budget_tracker/services/database.dart';
import 'package:budget_tracker/widgets/chart.dart';
import 'package:budget_tracker/widgets/colors.dart';
import 'package:budget_tracker/widgets/custom_button.dart';
import 'package:budget_tracker/widgets/expense_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const List<String> options = <String>[
  "Food & Drinks",
  "Shopping",
  "Housing",
  "Life & Health",
  "Investments",
  "Vehicle & Transportation",
  "Entertainment",
  "Other",
];

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _expenseController = TextEditingController();
  int _expense = 0;
  int _savings = 0;
  String username = "1";
  QuerySnapshot? data;
  int totalExpense = 0;
  int monthlyIncome = 0;
  Stream<QuerySnapshot>? expenseUsers;

  String userid = "1";
  String email = "1";

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    getUserDetails();
    fetching();
    fetchUserExpenses();

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

  Future fetchUserExpenses() async {
    await getUserDetails().whenComplete(() async {
      await Database(uid: userid).fetchUserExpenses(userid).then((value) {
        if (value != null) {
          setState(() {
            expenseUsers = value;
          });
        }
      });
    });
  }

  Future fetching() async {
    setState(() {
      _isLoading = true;
    });

    await getUserDetails().whenComplete(() async {
      await Database(uid: userid).fetchUserEmail(userid).then((value) {
        if (value != null) {
          setState(() {
            email = value;
            print("email" + email);
          });
        } else {
          setState(() {
            email = "";
          });
        }
      });

      await Database(uid: userid).fetchUsername(userid).then((value) {
        if (value != null) {
          setState(() {
            username = value;
            print("username" + username);
          });
        } else {
          setState(() {
            username = "";
          });
        }
      });

      if (email != "") {
        await Database(uid: userid).fetchUserDetails(email).then((value) {
          if (value != null) {
            setState(() {
              _isLoading = false;
              data = value;
              username = data!.docs[0]['username'];
              totalExpense = data!.docs[0]['totalExpense'];
              monthlyIncome = data!.docs[0]['monthlyincome'];
            });
          } else {
            setState(() {
              _isLoading = false;
              data = null;
            });

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Error occured")));
          }
        });
      } else if (username != "") {
        await Database(uid: userid)
            .fetchUserDetailsUser(username)
            .then((value) {
          if (value != null) {
            setState(() {
              _isLoading = false;
              data = value;
              username = data!.docs[0]['username'];
              totalExpense = data!.docs[0]['totalExpense'];
              monthlyIncome = data!.docs[0]['monthlyincome'];
            });
          } else {
            setState(() {
              _isLoading = false;
              data = null;
            });

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Error occured")));
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _expenseController.dispose();
    super.dispose();
  }

  String? opt;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              }),
              title: Text(
                "Budget Tracker",
              ),
              centerTitle: true,
            ),
            drawer: Drawer(
              backgroundColor: AppColors.secondaryColor,
              child: Drawer(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: ListView(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 150,
                        color: AppColors.secondaryColor,
                      ),
                      Center(
                          child: Text(
                        username,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 30,
                      ),
                      Divider(
                        height: 2,
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text(
                          'Change Income',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        leading: Icon(
                          Icons.monetization_on,
                          color: AppColors.secondaryColor,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      ),
                      ListTile(
                        onTap: () {
                          signOut(context);
                        },
                        title: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        leading: Icon(
                          Icons.logout,
                          color: AppColors.secondaryColor,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: Container(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    opt = null;
                  });
                  popupDialog(context);
                },
                child: Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white,
                ),
                backgroundColor: AppColors.secondaryColor,
              ),
            ),
            backgroundColor: AppColors.primaryColor,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 14),
                      child: Container(
                        width: double.infinity,
                        height: screenHeight * 0.22,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                              spreadRadius: 1,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsets.all(18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChartWidget(
                                isLegend: true,
                                expenses: totalExpense,
                                savings: monthlyIncome - totalExpense,
                                chartColor: [Colors.blue, Colors.yellow],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      "Recent Expenses",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: expenseData.length,
                    //   itemBuilder: ((context, index) {
                    //     return Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    //       child: ExpenseTile(
                    //         title: expenseData[index]['title'],
                    //         money: expenseData[index]['money'],
                    //         date: expenseData[index]['date'],
                    //       ),
                    //     );
                    //   }),
                    // ),

                    expensesList(),

                    // CustomButton(
                    //     child: Text("Sign out"),
                    //     onPressed: () {
                    //       signOut(context);
                    //     }),

                    // Container(
                    //   width: 50,
                    //   child: ChartWidget(),
                    // ),
                  ],
                ),
              ),
            ),
          );
  }

  popupDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return Center(
              child: AlertDialog(
                title: Text(
                  "Add Expense",
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
                          controller: _expenseController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please enter expense";
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
                            hintText: 'Expense...',
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: Text("Select category"),
                          disabledHint: Text("Select category"),
                          value: opt,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 4,
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 1,
                            color: AppColors.secondaryColor,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              opt = value ?? "";
                            });
                          },
                          items: options
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (opt == null) {
                                  Fluttertoast.showToast(
                                      msg: "Please select a category",
                                      textColor: Colors.red,
                                      backgroundColor: Colors.red,
                                      fontSize: 20);
                                  return;
                                }

                                await addExpense(context, userid,
                                    int.parse(_expenseController.text), opt!);
                                Navigator.of(context).pop(fetching());
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

  expensesList() {
    return StreamBuilder(
        stream: expenseUsers,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length != 0) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: ExpenseTile(
                        title: snapshot.data.docs[index]['category'],
                        money: snapshot.data.docs[index]['amount'],
                        date: DateFormat.yMMMd()
                            .add_jm()
                            .format(snapshot.data.docs[index]['Date'].toDate()),
                      ),
                    );
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
                        size: 56,
                        color: Colors.grey[700],
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                      Text(
                        "No recent expenses",
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                )),
              );
            }
          } else {
            return Container(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  addExpense(
      BuildContext context, String userid, int expense, String category) async {
    await Database(uid: userid)
        .addExpense(userid, expense, category)
        .then((value) {
      if (value == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Expense added.")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Expense addition failed.")));
      }
    });
  }

  signOut(BuildContext context) async {
    await AuthService().signOut().whenComplete(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Login_opt()));
    });
  }
}
