import 'package:budget_tracker/screens/home_page.dart';
import 'package:budget_tracker/widgets/colors.dart';
import 'package:budget_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

const List<String> options = <String>[
  "Hard Savings",
  "Moderate Savings",
  "Custom Savings"
];

class Que extends StatefulWidget {
  const Que({Key? key}) : super(key: key);

  @override
  State<Que> createState() => _QueState();
}

class _QueState extends State<Que> {
  String dropdownValue = options.first;
  final _pageController = PageController(initialPage: 0);

  TextEditingController _incomeText = TextEditingController();
  TextEditingController _choice = TextEditingController();
  TextEditingController _ = TextEditingController();

  final _FormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Form(
          key: _FormKey,
          child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              // onPageChanged: (index),
              children: [
                Container(
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
                          controller: _incomeText,
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
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                _pageController.nextPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                              })),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: screenHeight * 0.30,
                      ),
                      Container(
                        width: 300,
                        child: Center(
                          child: Text(
                            'Do you want to set a limit for your expenses?',
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
                          controller: _choice,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            hintText: "yes or no",
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
                                if (checkForChoice()) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _pageController.nextPage(
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeInOut);
                                } else {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/home', (route) => false);
                                }
                              })),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: screenHeight * 0.30,
                      ),
                      Container(
                        width: 300,
                        child: Center(
                          child: Text(
                            'Select below options of expense limitations',
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
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 8,
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: AppColors.secondaryColor,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.

                            setState(() {
                              dropdownValue = value!;
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
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      SizedBox(
                        child: Center(
                          child: CustomButton(
                              width: 300,
                              child: Text(
                                'Done',
                                style: TextStyle(fontSize: 17),
                              ),
                              onPressed: (() {})),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  checkForChoice() {
    if (_choice.text.toLowerCase() == "no") {
      return false;
    } else if (_choice.text.toLowerCase() == "yes") {
      return true;
    }
  }
}
