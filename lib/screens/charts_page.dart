import 'package:budget_tracker/screens/category.dart';
import 'package:budget_tracker/screens/helper/helper_function.dart';
import 'package:budget_tracker/widgets/category_tile.dart';
import 'package:budget_tracker/widgets/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../services/database.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  bool _isLoading = false;
  String userid = "1";
  QuerySnapshot? food;
  QuerySnapshot? shopping;
  QuerySnapshot? housing;
  QuerySnapshot? lifeHealth;
  QuerySnapshot? investment;
  QuerySnapshot? vehicle;
  QuerySnapshot? entertainment;
  QuerySnapshot? groceries;
  QuerySnapshot? others;

  num totalFood = 0;
  num totalShopping = 0;
  num totalHousing = 0;
  num totalLifeHealth = 0;
  num totalInvestment = 0;
  num totalVehicle = 0;
  num totalOthers = 0;
  num totalEntertainment = 0;
  num totalGroceries = 0;

  @override
  void initState() {
    // TODO: implement initState
    getUserUid();

    fetchTotal();
    super.initState();
  }

  Future getUserUid() async {
    await helper_function.getUserUid().then((value) {
      if (value != null) {
        setState(() {
          userid = value;
          print(userid);
        });
      }
    });
  }

  Future fetchData() async {
    await getUserUid().whenComplete(() async {
      setState(() {
        _isLoading = true;
      });
      await Database(uid: userid).investmentCategory(userid).then((value) {
        setState(() {
          investment = value;
          print(investment);
        });
      });

      await Database(uid: userid).shoppingCategory(userid).then((value) {
        if (value != null) {
          setState(() {
            shopping = value;
          });
        }
      });
      await Database(uid: userid).foodCategory(userid).then((value) {
        if (value != null) {
          setState(() {
            food = value;
          });
        }
      });
      await Database(uid: userid).lifehealthCategory(userid).then((value) {
        if (value != null) {
          setState(() {
            lifeHealth = value;
          });
        }
      });
      await Database(uid: userid).vehicleCategory(userid).then((value) {
        if (value != null) {
          setState(() {
            vehicle = value;
          });
        }
      });

      await Database(uid: userid).otherCategory(userid).then((value) {
        if (value != null) {
          setState(() {
            others = value;
          });
        }
      });
      await Database(uid: userid).entertainCategory(userid).then((value) {
        if (value != null) {
          setState(() {
            entertainment = value;
          });
        }
      });

      await Database(uid: userid).housingCategory(userid).then((value) {
        if (value != null) {
          setState(() {
            housing = value;
          });
        }
      });
      await Database(uid: userid).groceriesCategory(userid).then((value) {
        if (value != null) {
          setState(() {
            groceries = value;
          });
        }
      });
    });
  }

  void fetchTotal() {
    fetchData().whenComplete(() {
      if (housing != null) {
        for (int i = 0; i < housing!.docs.length; i++) {
          setState(() {
            totalHousing += housing!.docs[i]['amount'];
          });
        }
      }
      if (entertainment != null) {
        for (int i = 0; i < entertainment!.docs.length; i++) {
          setState(() {
            totalEntertainment += entertainment!.docs[i]['amount'];
          });
        }
      }
      if (others != null) {
        for (int i = 0; i < others!.docs.length; i++) {
          setState(() {
            totalOthers += others!.docs[i]['amount'];
          });
        }
      }

      if (lifeHealth != null) {
        for (int i = 0; i < lifeHealth!.docs.length; i++) {
          setState(() {
            totalLifeHealth += lifeHealth!.docs[i]['amount'];
          });
        }
      }
      if (groceries != null) {
        for (int i = 0; i < groceries!.docs.length; i++) {
          setState(() {
            totalGroceries += groceries!.docs[i]['amount'];
          });
        }
      }

      if (investment != null) {
        print("length=" + investment!.docs.length.toString());
        for (int i = 0; i < investment!.docs.length; i++) {
          setState(() {
            totalInvestment += investment!.docs[i]['amount'];
          });
        }
      }
      print(totalInvestment);

      // print(investment!.docs.length);

      if (vehicle != null) {
        for (int i = 0; i < vehicle!.docs.length; i++) {
          setState(() {
            totalVehicle += vehicle!.docs[i]['amount'];
          });
        }
      }
      if (shopping != null) {
        for (int i = 0; i < shopping!.docs.length; i++) {
          setState(() {
            totalShopping += shopping!.docs[i]['amount'];
          });
        }
      }
      if (food != null) {
        for (int i = 0; i < food!.docs.length; i++) {
          setState(() {
            totalFood += food!.docs[i]['amount'];
          });
        }
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    List<ChartData> chartData = [
      ChartData('Food & Beverages', totalFood),
      ChartData('Shopping', totalShopping),
      ChartData('Housing', totalHousing),
      ChartData('Health', totalLifeHealth),
      ChartData('Investment', totalInvestment),
      ChartData('Vehicle', totalVehicle),
      ChartData('Entertainment', totalEntertainment),
      ChartData('Groceries', totalGroceries),
      ChartData('Others', totalOthers),
    ];

    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                blurRadius: 3,
                                spreadRadius: 2)
                          ]),
                      child: SfCircularChart(
                          tooltipBehavior: TooltipBehavior(enable: true),
                          legend: Legend(isResponsive: true, isVisible: true),
                          series: <CircularSeries>[
                            PieSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.name,
                                yValueMapper: (ChartData data, _) => data.data,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    overflowMode: OverflowMode.shift)),
                          ]),
                    ),
                    SizedBox(
                      height: screenHeight * 0.15,
                      child: Center(
                        child: Text(
                          'Categories',
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          TileWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Category(
                                        CategoryTitle: "Food & Drinks",
                                        userId: userid,
                                      )));
                            },
                            name: 'Food',
                            ic: Icon(
                              Icons.dining,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.05,
                          ),
                          TileWidget(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Category(
                                          userId: userid,
                                          CategoryTitle: "Shopping",
                                        )));
                              },
                              name: 'Shopping',
                              ic: Icon(
                                Icons.shopping_bag,
                                color: AppColors.secondaryColor,
                              )),
                          SizedBox(
                            width: screenWidth * 0.05,
                          ),
                          TileWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Category(
                                        userId: userid,
                                        CategoryTitle: "Housing",
                                      )));
                            },
                            name: 'Housing',
                            ic: Icon(
                              Icons.house_rounded,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          TileWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Category(
                                        userId: userid,
                                        CategoryTitle: "Life & Health",
                                      )));
                            },
                            name: 'Life',
                            ic: Icon(
                              Icons.health_and_safety_rounded,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.05,
                          ),
                          TileWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Category(
                                        userId: userid,
                                        CategoryTitle: "Investments",
                                      )));
                            },
                            name: 'Investment',
                            ic: Icon(
                              Icons.monetization_on_rounded,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.05,
                          ),
                          TileWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Category(
                                        userId: userid,
                                        CategoryTitle:
                                            "Vehicle & Transportation",
                                      )));
                            },
                            name: 'Vehicle',
                            ic: Icon(
                              Icons.motorcycle_sharp,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          TileWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Category(
                                        userId: userid,
                                        CategoryTitle: "Entertainment",
                                      )));
                            },
                            name: 'Entertainment',
                            ic: Icon(
                              Icons.theater_comedy_rounded,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.05,
                          ),
                          TileWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Category(
                                        userId: userid,
                                        CategoryTitle: "Groceries",
                                      )));
                            },
                            name: 'Groceries',
                            ic: Icon(
                              Icons.local_grocery_store_rounded,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.07,
                          ),
                          TileWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Category(
                                        userId: userid,
                                        CategoryTitle: "Others",
                                      )));
                            },
                            name: 'Others',
                            ic: Icon(
                              Icons.device_unknown,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ChartData {
  ChartData(this.name, this.data, [this.chartColor]);
  final String name;
  final num data;
  final Color? chartColor;
}
