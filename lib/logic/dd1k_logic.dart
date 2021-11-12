import 'package:flutter/cupertino.dart';

class DD1KMinus1 {
  late double ti;
  late double arrivalTime, serviceTime;
  late double lambda, mu;
  late double kMinus1, k, M;

  DD1KMinus1(
      {required this.lambda,
      required this.mu,
      required this.kMinus1,
      required this.M}) {
    k = kMinus1 + 1;

    arrivalTime = 1 / lambda;
    serviceTime = 1 / mu;

    if (lambda == mu) {
      ti = 0;
      M = ((mu * ti).floor() - (lambda * ti).floor()) as double;
    } else if (mu < lambda) {
      ti = calcTi(k);
    } else if (mu >= lambda) {
      for (double i = 0;; i += 1) {
        if (M == (mu * i).floor() - (lambda * i).floor()) {
          ti = i;
          break;
        }
      }
    }
    // ti = calcTi(k);
    // debugPrint('ti====$ti');
  }

  dynamic calcNt(t) {
    if (lambda > mu) {
      if (t > ti) return (k - 1);

      if (t < (1 / lambda))
        return 0;
      else {
        return (t * lambda).floor() - ((t * mu) - (mu / lambda)).floor();
      }
    } else if (mu >= lambda) {
      if (t < ti) {
        return M + (lambda * t).floor() - (mu * t).floor();
      } else {
        return 0;
      }
    }
  }

  calcTi(k) {
    for (double i = 0;; i += 1) {
      if ((i * lambda).floor() - ((i * mu) - (mu / lambda)).floor() == k) {
        return i;
      }
    }
  }
}
