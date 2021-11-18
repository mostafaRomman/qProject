// import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_project/models/deterministic_qs.dart';
import 'package:q_project/models/xY.dart';
import 'package:q_project/shared/cubit.dart';

import 'deterministic_qs_ui_graph.dart';

class DD1K extends StatefulWidget {
  const DD1K({Key? key}) : super(key: key);

  @override
  _DD1KState createState() => _DD1KState();
}

class _DD1KState extends State<DD1K> {
  var lambdaController = TextEditingController();
  var muController = TextEditingController();
  var kController = TextEditingController();
  var mController = TextEditingController();
  var xRangeController = TextEditingController();
  var yRangeController = TextEditingController();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  var fKey = GlobalKey<FormState>();

  myTextField({lable, controller, ctx}) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          if (lable.toString() == 'M' ||
              lable.toString() == 'K' ||
              lable.toString() == 'X Range' ||
              lable.toString() == 'Y Range') return null;
          return 'empty field!';
        } else {
          if (value.contains('/')) {
            int i = value.indexOf('/');
            if (double.tryParse(value.substring(0, i)) != null &&
                double.tryParse(value.substring(i + 1, value.length)) != null) {
              if (lable.toString() == 'μ') {
                QCubit.get(ctx).setMu(
                    m: (double.parse(value.substring(0, i)) /
                        double.parse(value.substring(i + 1, value.length))));
                return null;
                // debugPrint('mu ====== ${muController.text}');
              }
              if (lable.toString() == 'λ') {
                QCubit.get(ctx).setLambda(
                    l: (double.parse(value.substring(0, i)) /
                        double.parse(value.substring(i + 1, value.length))));
                return null;
              }
            }
          }
          if (double.tryParse(value) == null) {
            return 'not number!';
          }
          if (double.parse(value).isNegative) {
            return 'negative number not allowed!';
          }
        }
      },
      controller: controller,
      decoration: InputDecoration(
        label: Text(lable.toString()),
        alignLabelWithHint: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QCubit, QStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'D/D/1/K  Model',
              textScaleFactor: 1.2,
              style:
                  TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
            ),
          ),
          body: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 4,
                      child: Form(
                        key: fKey,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3,
                                  child: myTextField(
                                      ctx: context,
                                      lable: 'λ',
                                      controller: lambdaController),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3,
                                  child: myTextField(
                                      ctx: context,
                                      lable: 'μ',
                                      controller: muController),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3,
                                  child: myTextField(
                                      ctx: context,
                                      lable: 'K',
                                      controller: kController),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3,
                                  child: myTextField(
                                      ctx: context,
                                      lable: 'M',
                                      controller: mController),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3,
                                  child: myTextField(
                                      ctx: context,
                                      lable: 'X Range',
                                      controller: xRangeController),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3,
                                  child: myTextField(
                                      ctx: context,
                                      lable: 'Y Range',
                                      controller: yRangeController),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    OutlinedButton(
                      child: const  Text(
                      'Calc',
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                    ),
                      onPressed: () {
                        if (fKey.currentState!.validate()) {
                          // setState(() {
                          QCubit.get(context).clearWqXyList();
                          QCubit.get(context).clearNofTxyList();

                          QCubit.get(context).setRanges(
                            x: xRangeController.text.isNotEmpty
                                ? xRangeController.text
                                : '20.0',
                            y: yRangeController.text.isNotEmpty
                                ? yRangeController.text
                                : '10.0',
                          );
                          QCubit.get(context).getNofTChart(
                            lambda: double.parse(
                                double.tryParse(lambdaController.text) != null
                                    ? lambdaController.text
                                    : QCubit.get(context)
                                        .currentLambda
                                        .toString()),
                            mu: double.parse(
                                double.tryParse(muController.text) != null
                                    ? muController.text
                                    : QCubit.get(context)
                                        .currentMu
                                        .toString()),
                            k: int.parse(
                                int.tryParse(kController.text) != null
                                    ? kController.text
                                    : '1'),
                            m: int.parse(
                                int.tryParse(mController.text) != null
                                    ? mController.text
                                    : '0'),
                          );
                          QCubit.get(context).getWqChart();
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DD1KGraph();
                            },
                          ));
                          // });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
