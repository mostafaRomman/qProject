import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:q_project/logic/dd1k_logic.dart';
import 'package:q_project/logic/xY.dart';

class DD1K extends StatefulWidget {
  const DD1K({Key? key}) : super(key: key);

  @override
  _DD1KState createState() => _DD1KState();
}

class _DD1KState extends State<DD1K> {
  List<Color> cList = [Colors.blue];

  late DD1KMinus1 d;

  List<XY> xY = [];

  _DD1KState() {
    d = DD1KMinus1(lambda: 1 / 3, mu: 1, M: 7, kMinus1: 4);
    for (double i = 0; i < 21; i += 1) {
      xY.add(XY(i, (d.calcNt(i - 1).toDouble())));
      xY.add(XY(i, (d.calcNt(i).toDouble())));
    }
    xY.forEach((element) {
      debugPrint('${element.x} = = ${element.y}');
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'D/D/1/K-1  Model',
            textScaleFactor: 1.2,
            style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LineChart(
            LineChartData(
                maxX: 20,
                maxY: 10,
                minX: 0,
                minY: 0,
                axisTitleData: FlAxisTitleData(
                  bottomTitle:
                      AxisTitle(titleText: 'time', showTitle: true, margin: 20),
                  leftTitle:
                      AxisTitle(titleText: 'n(t)', showTitle: true, margin: 2),
                ),
                lineBarsData: [
                  LineChartBarData(

                    spots: xY.map((e) => FlSpot(e.x, e.y)).toList(),
                    belowBarData: BarAreaData(show: true, colors: cList),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
