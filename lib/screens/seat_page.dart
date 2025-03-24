import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_train_app/models/passenger_count.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;
  final PassengerCount passengerCount;
  final VoidCallback onBookingComplete;

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
    required this.passengerCount,
    required this.onBookingComplete,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  Set<String> selectedSeats = {};

  void toggleSeat(String seat) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
      } else if (selectedSeats.length < widget.passengerCount.total) {
        selectedSeats.add(seat);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('선택 가능한 좌석 수를 초과했습니다.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  Widget seatTextBox(String text) => Container(
    margin: EdgeInsets.fromLTRB(2, 4, 2, 4),
    child: SizedBox(
      width: 50,
      height: 50,
      child: Center(child: Text(text, style: TextStyle(fontSize: 18))),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("좌석 선택")),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                StationText(station: widget.departureStation),
                Icon(Icons.arrow_circle_right_outlined, size: 30),
                StationText(station: widget.arrivalStation),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SeatBox(isSelected: true, isSmallBox: true),
                  SizedBox(width: 2),
                  Text('선택됨'),
                  SizedBox(width: 18),
                  SeatBox(isSelected: false, isSmallBox: true),
                  SizedBox(width: 2),
                  Text('선택안됨'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                '선택 인원: ${selectedSeats.length}/${widget.passengerCount.total}명',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          seatTextBox('A'),
                          seatTextBox('B'),
                          seatTextBox(''),
                          seatTextBox('C'),
                          seatTextBox('D'),
                        ],
                      ),
                      ...List.generate(
                        20,
                        (index) => SeatRow(
                          seatBoxes: [
                            GestureDetector(
                              onTap: () => toggleSeat('A${index + 1}'),
                              child: SeatBox(
                                isSelected: selectedSeats.contains(
                                  'A${index + 1}',
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => toggleSeat('B${index + 1}'),
                              child: SeatBox(
                                isSelected: selectedSeats.contains(
                                  'B${index + 1}',
                                ),
                              ),
                            ),
                            seatTextBox((index + 1).toString()),
                            GestureDetector(
                              onTap: () => toggleSeat('C${index + 1}'),
                              child: SeatBox(
                                isSelected: selectedSeats.contains(
                                  'C${index + 1}',
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => toggleSeat('D${index + 1}'),
                              child: SeatBox(
                                isSelected: selectedSeats.contains(
                                  'D${index + 1}',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    if (selectedSeats.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('선택한 좌석이 없습니다'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      return;
                    }

                    if (selectedSeats.length < widget.passengerCount.total) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${widget.passengerCount.total - selectedSeats.length}명 더 추가해주세요',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      return;
                    }

                    showCupertinoDialog(
                      context: context,
                      builder:
                          (context) => CupertinoAlertDialog(
                            title: const Text('예매 확인'),
                            content: Text('좌석: ${selectedSeats.join(', ')}'),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text(
                                  '취소',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                              CupertinoDialogAction(
                                child: const Text(
                                  '확인',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  Navigator.pop(context); // dialog 닫기
                                  Navigator.pop(context); // seat page 닫기
                                  widget.onBookingComplete(); // 인원 수 초기화
                                },
                              ),
                            ],
                          ),
                    );
                  },
                  style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(
                      const Size(double.infinity, 50),
                    ),
                    backgroundColor: WidgetStateProperty.all(Colors.purple),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  child: const Text(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    "예매하기",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StationText extends StatelessWidget {
  final String station;
  const StationText({super.key, required this.station});

  static const TextStyle stationTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.purple,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: Center(child: Text(station, style: stationTextStyle)),
      ),
    );
  }
}

class SeatBox extends StatelessWidget {
  final bool isSelected;
  final bool? isSmallBox;
  const SeatBox({super.key, required this.isSelected, this.isSmallBox = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isSmallBox ?? false ? 24 : 50,
      height: isSmallBox ?? false ? 24 : 50,
      margin: EdgeInsets.fromLTRB(2, 4, 2, 4),
      decoration: BoxDecoration(
        color:
            isSelected
                ? Colors.purple
                : Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[600]!
                : Colors.grey[300]!,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class SeatRow extends StatelessWidget {
  final List<Widget> seatBoxes;
  const SeatRow({super.key, required this.seatBoxes});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: seatBoxes,
    );
  }
}
