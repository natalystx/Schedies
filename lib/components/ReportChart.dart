import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:schedule_app/model/EventReporter.dart';

class ReportChart extends StatelessWidget {
  final List<charts.Series<EventReporter, String>> seriesList;

  ReportChart(
    this.seriesList,
  );

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: false,
      defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: 40,
          arcRendererDecorators: [
            new charts.ArcLabelDecorator(
                labelPosition: charts.ArcLabelPosition.inside)
          ]),
    );
  }
}
