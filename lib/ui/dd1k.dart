import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DD1K extends StatefulWidget {
  const DD1K({Key? key}) : super(key: key);

  @override
  _DD1KState createState() => _DD1KState();
}

class _DD1KState extends State<DD1K> {
  List<Color> cList = [Colors.blue];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Queueing Theory',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LineChart(
            LineChartData(maxX: 10, maxY: 10, minX: 0, minY: 0, lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(0, 1),
                  const FlSpot(1, 1),
                  const FlSpot(2, 1),
                  const FlSpot(2, 2),
                  const FlSpot(3, 2),
                ],
                belowBarData: BarAreaData(show: true, colors: cList),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
