import 'package:budget_tracker/services/database.dart';
import 'package:budget_tracker/widgets/chart.dart';
import 'package:budget_tracker/screens/login_options/login_opt.dart';
import 'package:budget_tracker/services/auth_service.dart';
import 'package:budget_tracker/widgets/colors.dart';
import 'package:budget_tracker/widgets/custom_button.dart';
import 'package:budget_tracker/widgets/expense_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const List<String> options = <String>[
  "Food & Drinks",
  "Shopping",
  "Housing",
  "Life & Entertainment",
  "Investments",
  "Vehicle & Transportation",
  "Other",
];

const List<Map<String, dynamic>> expenseData = [
  {
    'title': "Shopping",
    'date': "6 January 2023",
    'logo': "",
    'money': 50,
  },
  {
    'title': "Entertainment",
    'date': "6 January 2023",
    'logo': "",
    'money': 50,
  },
  {
    'title': "Transport",
    'date': "6 January 2023",
    'logo': "",
    'money': 50,
  },
  {
    'title': "Food & Drinks",
    'date': "6 January 2023",
    'logo': "",
    'money': 50,
  },
  {
    'title': "Bills",
    'date': "6 January 2023",
    'logo': "",
    'money': 50,
  },
];

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _expenseController = TextEditingController();
  int _expense = 0;
  int _savings = 0;
  QuerySnapshot? data;
  Stream<QuerySnapshot>? expenseUsers;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    fetching();
    fetchUserExpenses();
  }

  fetchUserExpenses() async {
    await Database(uid: FirebaseAuth.instance.currentUser!.uid)
        .fetchUserExpenses(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      if (value != null) {
        setState(() {
          expenseUsers = value;
          print(expenseUsers);
        });
      }
    });
  }

  fetching() async {
    setState(() {
      _isLoading = true;
    });
    if (FirebaseAuth.instance.currentUser!.email != null) {
      await Database()
          .fetchUserDetails(FirebaseAuth.instance.currentUser!.email)
          .then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
            data = value;

            print(data);
          });
        }
      });
    } else {
      await Database()
          .fetchUserDetailsUser(FirebaseAuth.instance.currentUser!.displayName)
          .then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
            data = value;

            print(data);
          });
        }
      });
    }
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Budget Tracker",
        ),
        centerTitle: true,
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
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: AppColors.secondaryColor,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 20,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, size: 20),
              label: "Charts",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box, size: 20),
              label: "Goals",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month, size: 20),
              label: "Bills",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 20),
              label: "Settings",
            ),
          ]),
      backgroundColor: AppColors.primaryColor,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                                expenses: data!.docs[0]['totalExpense'],
                                savings: data!.docs[0]['monthlyincome'] -
                                    data!.docs[0]['totalExpense'],
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

                                await addExpense(
                                    context,
                                    FirebaseAuth.instance.currentUser!.uid,
                                    int.parse(_expenseController.text),
                                    opt!);
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
}

addExpense(
    BuildContext context, String userid, int expense, String category) async {
  await Database(uid: FirebaseAuth.instance.currentUser!.uid)
      .addExpense(userid, expense, category)
      .then((value) {
    if (value != null) {
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
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login_opt()));
  });
}
