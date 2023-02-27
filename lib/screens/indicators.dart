import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:frs/screens/style/aap_style.dart';
import 'bar_chart_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Indicator extends StatefulWidget {
  const Indicator({Key? key}) : super(key: key);

  @override
  State<Indicator> createState() => _IndicatorState();
}

var totalCalIntake = 600.0;
var calIntake;
var remaCal = 1000.0;
var fixCal = 1600.0;

class _IndicatorState extends State<Indicator> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  final List<BarChartModel> data = [
    BarChartModel(
      intake: "Consumption",
      Nutritions: totalCalIntake.toInt(),
      color: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    BarChartModel(
      intake: "Remaining Calories",
      Nutritions: remaCal.toInt(),
      color: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    BarChartModel(
      intake: "Required Calories",
      Nutritions: fixCal.toInt(),
      color: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
  ];
  DateTime now = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime date = new DateTime(now.year, now.month, now.day);
    int day, month, year;
    day = date.day;
    month = date.month;
    year = date.year;
    String formattedDate =
        day.toString() + '-' + month.toString() + '-' + year.toString();

    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "Nutritions",
        data: data,
        domainFn: (BarChartModel series, _) => series.intake,
        measureFn: (BarChartModel series, _) => series.Nutritions,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: const Text("Indicators"),
          centerTitle: true,
          backgroundColor: AppStyle.kPrimaryColor,
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users/$uid/userActivity')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var length = snapshot.data!.docs.length;
                totalCalIntake = 0;
                for (var i = 0; i < length; i++) {
                  var items = snapshot.data!.docs[i];
                  calIntake = items['CaloriesIntake'];
                  var day = items['createdDay'];
                  var hardCodeCal = items['FixCal'];

                  if (day == formattedDate) {
                    totalCalIntake += double.parse(calIntake);
                    fixCal = double.parse(hardCodeCal);
                  }
                  remaCal = fixCal - totalCalIntake;

                  // int currentCal = totalCalIntake.toInt();
                  // int remCal = remaCal.toInt();
                  // int finalCal = fixCal.toInt();
                }
              }
              return Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 30),
                child: charts.BarChart(
                  series,
                  animate: true,
                  barGroupingType: charts.BarGroupingType.grouped,
                  defaultRenderer: new charts.BarRendererConfig(
                      cornerStrategy: const charts.ConstCornerStrategy(30),
                      maxBarWidthPx: 10),
                ),
              );
            }));
  }
}
