import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarChartModel {
  String intake;
  int Nutritions;
  final charts.Color color;

  BarChartModel({
    required this.intake,
    required this.Nutritions,
    required this.color,
  });
}
