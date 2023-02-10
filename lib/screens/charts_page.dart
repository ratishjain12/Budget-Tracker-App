import 'package:budget_tracker/widgets/category_tile.dart';
import 'package:budget_tracker/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final List<ChartData> chartData = [
      ChartData('Food & Beverages', 10000),
      ChartData('Shopping', 3000),
      ChartData('Housing', 1000),
      ChartData('Health', 2000),
      ChartData('Investment', 2000),
      ChartData('Vehicle', 3000),
      ChartData('Entertainment', 2000),
      ChartData('Others', 2000),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text('Budget Tracker'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
                            isVisible: true, overflowMode: OverflowMode.shift)),
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
                      name: 'Shopping',
                      ic: Icon(
                        Icons.shopping_bag,
                        color: AppColors.secondaryColor,
                      )),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  TileWidget(
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
              margin: EdgeInsets.only(left: 19),
              child: Row(
                children: [
                  TileWidget(
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
    );
  }
}

class ChartData {
  ChartData(this.name, this.data, [this.chartColor]);
  final String name;
  final int data;
  final Color? chartColor;
}
