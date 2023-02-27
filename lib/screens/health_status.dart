import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frs/screens/calorie.dart';
import 'package:frs/screens/colorcodes.dart';
import 'package:frs/screens/model/chart_data.dart';
import 'package:frs/screens/style/aap_style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'indicators.dart';

class HealthStatus extends StatefulWidget {
  const HealthStatus({Key? key}) : super(key: key);

  @override
  State<HealthStatus> createState() => _HealthStatusState();
}

class _HealthStatusState extends State<HealthStatus> {
  late List<ChartData> data;

  @override
  void initState() {
    super.initState();

    data = [
      ChartData(-13, 21344),
      ChartData(-12, 22345),
      ChartData(-19, 21346),
      ChartData(20, 24347),
      ChartData(21, 25348),
      ChartData(22, 23499),
      ChartData(24, 21323),
      ChartData(26, 20365),
      ChartData(29, 19378),
      ChartData(30, 20399),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bg_color,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppStyle.bg_color,
        //elevation: 0.0,
        title: Text("Health Analysis"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Status",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80"),
            radius: 45.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "(You eat, we think)",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 24,
                fontStyle: FontStyle.italic),
          ),
          Center(
            child: SfCartesianChart(
              margin: EdgeInsets.all(0),
              borderWidth: 0,
              borderColor: Colors.transparent,
              plotAreaBorderWidth: 0,
              primaryXAxis: NumericAxis(
                minimum: 17,
                maximum: 26,
                isVisible: false,
                interval: 1,
                borderColor: Colors.transparent,
                borderWidth: 0,
              ),
              primaryYAxis: NumericAxis(
                minimum: 1000,
                maximum: 30000,
                interval: 1000,
                isVisible: false,
                borderWidth: 0,
                borderColor: Colors.transparent,
              ),
              series: <ChartSeries<ChartData, int>>[
                SplineAreaSeries(
                  dataSource: data,
                  xValueMapper: (ChartData data, _) => data.day,
                  yValueMapper: (ChartData data, _) => data.calories,
                  splineType: SplineType.natural,
                  gradient: LinearGradient(
                    colors: [
                      AppStyle.spline_color,
                      AppStyle.bg_color.withAlpha(150),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                SplineSeries(
                  dataSource: data,
                  color: AppStyle.accent_color,
                  width: 4,
                  markerSettings: MarkerSettings(
                    color: AppStyle.spline_color,
                    borderWidth: 3,
                    shape: DataMarkerType.circle,
                    isVisible: true,
                    borderColor: AppStyle.spline_color,
                  ),
                  xValueMapper: (ChartData data, _) => data.day,
                  yValueMapper: (ChartData data, _) => data.calories,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/Dashboard');
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                  side: BorderSide(
                    color: AppStyle.accent_color,
                  ),
                ),
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: Text(
                  "Home",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(16),
                  backgroundColor: AppStyle.accent_color,
                ),
                icon: Icon(
                  Icons.download,
                  color: Colors.white,
                ),
                label: Text(
                  "Report",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
