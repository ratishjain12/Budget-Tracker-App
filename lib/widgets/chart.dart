import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatefulWidget {
  final bool isLegend;
  final int expenses;
  final int savings;
  final List<Color> chartColor;
  const ChartWidget(
      {Key? key,
      required this.isLegend,
      this.expenses = 0,
      this.savings = 0,
      required this.chartColor})
      : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  List<ChartData>? _chartData;
  TooltipBehavior? _tooltipBehaviour;

  @override
  void initState() {
    // TODO: implement initState
    // _chartData = getData();

    super.initState();
  }

  getData() {
    List<ChartData> data = [
      ChartData(name: 'Expenses', expense: widget.expenses),
      ChartData(name: 'Savings', expense: widget.savings),
    ];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    _tooltipBehaviour = TooltipBehavior(enable: true);
    _chartData = getData();
    return SfCircularChart(
      palette: widget.chartColor,
      // title: ChartTitle(text: "Your this month's expenses \n (in RS)"),
      tooltipBehavior: TooltipBehavior(canShowMarker: true, enable: true),
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: _chartData,
          xValueMapper: (ChartData data, _) => data.name,
          yValueMapper: (ChartData data, _) => data.expense,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              overflowMode: OverflowMode.shift,
              labelAlignment: ChartDataLabelAlignment.outer),
          enableTooltip: true,
        ),
      ],
      legend: Legend(
        isVisible: widget.isLegend,
        iconHeight: 20,
        iconWidth: 20,
      ),
    );
  }
}

class ChartData {
  String? name;
  num? expense;
  ChartData({required this.name, required this.expense});
}
