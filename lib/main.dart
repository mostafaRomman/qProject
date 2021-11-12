import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:q_project/logic/dd1k_logic.dart';
import 'package:q_project/ui/dd1k.dart';
import 'package:q_project/ui/ui.dart';

void main() {


  DD1KMinus1 d=DD1KMinus1(lambda:1/3 ,mu:1/5 ,M: 0,kMinus1: 20);
  debugPrint('${d.calcNt(11).toString()}');

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DD1K(),
  ));
}
