/// 승객 수를 관리하는 모델 클래스
///
/// 각 인원 유형별(성인, 어린이, 유아, 경로, 장애인) 수를 관리하고
/// 전체 승객 수를 계산하는 기능을 제공합니다.
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
