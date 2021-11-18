import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_project/models/deterministic_qs.dart';
import 'package:q_project/models/xY.dart';

abstract class QStates {}

class InitState extends QStates {}

class GetGraphDetailsCase1State extends QStates {}

class GetGraphDetailsCase2State extends QStates {}

class GetWqState extends QStates {}

class ClearNofTListState extends QStates {}

class ClearWqListState extends QStates {}

class SetRangesState extends QStates {}

class SetMuState extends QStates {}

class SetLambdaState extends QStates {}

class GetWqYRangeState extends QStates {}

class QCubit extends Cubit<QStates> {
  QCubit() : super(InitState());

  static QCubit get(context) => BlocProvider.of(context);

  List<XY> nOfTxyList = [];
  List<XY> wQxyList = [];

  double xRange = 20, yRange = 10;
  late double wQyRange;

  late DeterministicQS d;

  getWqYRange() {
    wQyRange = d.getWqYRange();
    emit(GetWqYRangeState());
    return wQyRange;
  }

  clearWqXyList() {
    wQxyList.clear();
    emit(ClearWqListState());
  }

  clearNofTxyList() {
    nOfTxyList.clear();
    emit(ClearNofTListState());
  }

  late double currentLambda, currentMu;

  setMu({m}) {
    currentMu = m;
    emit(SetMuState());
  }

  setLambda({l}) {
    currentLambda = l;
    emit(SetLambdaState());
  }

  getWqChart() {
    for (int i = 1; i <= xRange; i++) {
      wQxyList.add(XY(i.toDouble(), d.wqOfN(i)));
    }
    emit(GetWqState());
  }

  getNofTChart(
      {required double lambda, required double mu, int k = 0, int m = 1}) {
    if ((1 / lambda) < (1 / mu)) {
      d = DeterministicQS.case1(
          interArrivalTime: 1 / lambda, serviceTime: 1 / mu, systemCapacity: k);
      for (double i = 0; i <= xRange; i += 1) {
        if (i > 0) nOfTxyList.add(XY(i, (d.nOfT(i - 1).toDouble())));
        nOfTxyList.add(XY(i, (d.nOfT(i).toDouble())));
      }
      for (var element in nOfTxyList) {
        debugPrint('${element.x} = = ${element.y}');
      }
      emit(GetGraphDetailsCase1State());
    } else {
      d = DeterministicQS.case2(
          interArrivalTime: 1 / lambda,
          M: m,
          serviceTime: 1 / mu,
          systemCapacity: k);
      for (double i = 0; i <= xRange; i += 1) {
        if (i > 0) nOfTxyList.add(XY(i, (d.nOfT(i - 1).toDouble())));
        nOfTxyList.add(XY(i, (d.nOfT(i).toDouble())));
      }
      for (var element in nOfTxyList) {
        debugPrint('${element.x} = = ${element.y}');
      }
      emit(GetGraphDetailsCase2State());
    }
  }

  setRanges({x, y}) {
    if (x != null) xRange = double.parse(x);
    if (y != null) yRange = double.parse(y);
    emit(SetRangesState());
  }
}
