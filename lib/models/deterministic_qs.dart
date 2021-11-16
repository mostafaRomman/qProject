class DeterministicQS {
  int systemCapacity = 1, M = 0, ti = 0;
  double interArrivalTime = 1, serviceTime = 1;
  bool isCase1 = true;

  DeterministicQS.case1(
      {required int systemCapacity,
      required double interArrivalTime,
      required double serviceTime}) {
    this.systemCapacity = (systemCapacity > 0) ? systemCapacity : 1;
    this.interArrivalTime = (interArrivalTime > 0) ? interArrivalTime : 1;
    this.serviceTime = (serviceTime > 0) ? serviceTime : 1;
    isCase1 = (interArrivalTime < serviceTime);
    M = 0;
    if (isCase1) {
      int t = interArrivalTime.toInt();
      for (;
          ((t / interArrivalTime).floor() -
                      ((t - interArrivalTime) / serviceTime).floor())
                  .toInt() !=
              (systemCapacity + 1);
          t++) {}
      ti = t;
    } else {
      ti = 0;
    }
  }

  DeterministicQS.case2(
      {required int systemCapacity,
      required double interArrivalTime,
      required double serviceTime,
      required int M}) {
    this.systemCapacity = (systemCapacity > 0) ? systemCapacity : 1;
    this.interArrivalTime = (interArrivalTime > 0) ? interArrivalTime : 1;
    this.serviceTime = (serviceTime > 0) ? serviceTime : 1;
    isCase1 = (interArrivalTime < serviceTime);
    if (isCase1) {
      this.M = 0;
      int t = interArrivalTime.toInt();
      for (;
          ((t / interArrivalTime).floor() -
                      ((t - interArrivalTime) / serviceTime).floor())
                  .toInt() !=
              (systemCapacity + 1);
          t++) {}
      ti = t;
    } else {
      this.M = (M > 0) ? M : 0;
      int t = 0;
      for (;
          ((t / serviceTime).floor() - (t / interArrivalTime).floor())
                  .toInt() !=
              M;
          t++) {}
      ti = t;
    }
  }

  int getTi() {
    return ti;
  }

  int nOfT(double t) {
    if (isCase1) {
      if (t < interArrivalTime) {
        return 0;
      }
      if (t < ti) {
        return ((t / interArrivalTime).floor() -
                ((t - interArrivalTime) / serviceTime).floor())
            .toInt();
      }
      return systemCapacity;
    }
    if (t < serviceTime) {
      return M;
    }
    if (t < ti) {
      return (M +
          ((t / interArrivalTime).floor() - (t / serviceTime).floor()).toInt());
    }
    return 0;
  }

  double wqOfN(int n) {
    if (isCase1) {
      if (n < (ti / interArrivalTime)) {
        return ((serviceTime - interArrivalTime) * (n - 1));
      }
      return ((serviceTime - interArrivalTime) * ((ti / interArrivalTime) - 2));
    }
    if (n == 0) {
      return ((M - 1) * serviceTime * 0.5);
    }
    if (n < (ti / interArrivalTime)) {
      return (((M + n - 1) * serviceTime) - (n * interArrivalTime));
    }
    return 0;
  }
}
