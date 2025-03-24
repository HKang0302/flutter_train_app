class PassengerCount {
  int adult;
  int child;
  int infant;
  int senior;
  int mildDisability;
  int severeDisability;

  PassengerCount({
    this.adult = 1,
    this.child = 0,
    this.infant = 0,
    this.senior = 0,
    this.mildDisability = 0,
    this.severeDisability = 0,
  });

  int get total =>
      adult + child + infant + senior + mildDisability + severeDisability;
}
