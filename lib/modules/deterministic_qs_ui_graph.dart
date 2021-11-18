// import 'dart:html';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_project/shared/cubit.dart';

class DD1KGraph extends StatefulWidget {
  var lambda, mu;

  DD1KGraph(this.lambda, this.mu);

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
          elevation: 4,
          title: const Text(
            'D/D/1/K  Details ',
            textScaleFactor: 1.2,
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: null,
                      child: Text(
                        'Ti = ${QCubit.get(context).d.getTi().toString()}',
                        textScaleFactor: 1.5,
                        style: const TextStyle(
                            color: Colors.black, fontStyle: FontStyle.italic),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text(
                        'λ =${widget.lambda} ',
                        textScaleFactor: 1.5,
                        style: const TextStyle(
                            color: Colors.black, fontStyle: FontStyle.italic),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text(
                        'μ = ${widget.mu}',
                        textScaleFactor: 1.5,
                        style: const TextStyle(
                            color: Colors.black, fontStyle: FontStyle.italic),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text(
                        'K = ${QCubit.get(context).d.systemCapacity.toString()}',
                        textScaleFactor: 1.5,
                        style: const TextStyle(
                            color: Colors.black, fontStyle: FontStyle.italic),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text(
                        'M = ${QCubit.get(context).d.M.toString()}',
                        textScaleFactor: 1.5,
                        style: const TextStyle(
                            color: Colors.black, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                        clipData: FlClipData.all(),
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
                                .nOfTxyList
                                .map((e) => FlSpot(e.x, e.y))
                                .toList(),
                            belowBarData:
                                BarAreaData(show: true, colors: cList),
                          ),
                        ]),
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                        clipData: FlClipData.all(),
                        maxX: QCubit.get(context).xRange,
                        maxY: QCubit.get(context).getWqYRange(),
                        minX: 0,
                        minY: 0,
                        axisTitleData: FlAxisTitleData(
                          bottomTitle: AxisTitle(
                              titleText: 'n', showTitle: true, margin: 20),
                          leftTitle: AxisTitle(
                              titleText: 'Wq(n)', showTitle: true, margin: 2),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: QCubit.get(context)
                                .wQxyList
                                .map((e) => FlSpot(e.x, e.y))
                                .toList(),
                            belowBarData:
                                BarAreaData(show: true, colors: cList),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      listener: (context, state) {},
    );
  }
}
