import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({Key? key}) : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  late List<ChartData> _chartData;
  late TooltipBehavior _tooltipBehaviour;

  @override
  void initState() {
    // TODO: implement initState
    _chartData = getData();
    _tooltipBehaviour = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfCircularChart(
        title: ChartTitle(text: "Your this month's expenses \n (in RS)"),
        tooltipBehavior: _tooltipBehaviour,
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (ChartData data, _) => data.name,
            yValueMapper: (ChartData data, _) => data.expense,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true,
          ),
        ],
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      ),
    ));
  }

  List<ChartData> getData() {
    List<ChartData> data = [
      ChartData(name: 'Shopping', expense: 10000),
      ChartData(name: 'Food', expense: 3000),
      ChartData(name: 'Entertainment', expense: 1000),
      ChartData(name: 'Bills', expense: 3300),
      ChartData(name: 'Investment', expense: 2500),
      ChartData(name: 'Others', expense: 1500),
    ];
    return data;
  }
}

class ChartData {
  String? name;
  int? expense;
  ChartData({required this.name, required this.expense});
}
