import 'package:budget_tracker/widgets/category_tile.dart';
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
      ChartData('Food', 10000),
      ChartData('Shopping', 3000),
      ChartData('Housing', 100),
      ChartData('Life', 2000),
      ChartData('investment', 2000),
      ChartData('vehicle', 3000),
      ChartData('Other', 2000),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 18, top: 10),
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
                margin: EdgeInsets.only(left: 19),
                child: Row(
                  children: [
                    TileWidget(
                      name: 'Food',
                    ),
                    SizedBox(
                      width: screenWidth * 0.07,
                    ),
                    TileWidget(name: 'Shopping'),
                    SizedBox(
                      width: screenWidth * 0.07,
                    ),
                    TileWidget(name: 'housing'),
                    SizedBox(
                      width: screenWidth * 0.07,
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
                      name: 'Food',
                    ),
                    SizedBox(
                      width: screenWidth * 0.07,
                    ),
                    TileWidget(name: 'Shopping'),
                    SizedBox(
                      width: screenWidth * 0.07,
                    ),
                    TileWidget(name: 'housing'),
                    SizedBox(
                      width: screenWidth * 0.07,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Container(
                margin: EdgeInsets.only(left: 19),
                child: Row(
                  children: [
                    TileWidget(
                      name: 'Food',
                    ),
                    SizedBox(
                      width: screenWidth * 0.07,
                    ),
                    TileWidget(name: 'Shopping'),
                    SizedBox(
                      width: screenWidth * 0.07,
                    ),
                    TileWidget(name: 'housing'),
                    SizedBox(
                      width: screenWidth * 0.07,
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
  final int data;
  final Color? chartColor;
}
