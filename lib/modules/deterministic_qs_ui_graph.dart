// import 'dart:html';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_project/shared/cubit.dart';

class DD1KGraph extends StatefulWidget {
  @override
  State<DD1KGraph> createState() => _DD1KGraphState();
}

class _DD1KGraphState extends State<DD1KGraph> {
  List<Color> cList = [Colors.teal.shade300];

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QCubit, QStates>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'D/D/1/K  Graph',
              textScaleFactor: 1.2,
              style:
                  TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                  maxX: QCubit.get(context).xRange,
                  maxY: QCubit.get(context).yRange,
                  minX: 0,
                  minY: 0,
                  axisTitleData: FlAxisTitleData(
                    bottomTitle: AxisTitle(
                        titleText: 'time', showTitle: true, margin: 20),
                    leftTitle: AxisTitle(
                        titleText: 'n(t)', showTitle: true, margin: 2),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: QCubit.get(context)
                          .xyList
                          .map((e) => FlSpot(e.x, e.y))
                          .toList(),
                      belowBarData: BarAreaData(show: true, colors: cList),
                    ),
                  ]),
            ),
          ),
        ),
      ),
      listener: (context, state) {},
    );
  }
}
