import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String departureStation = '';
  String arrivalStation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('기차 예매')),
      body: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StationSelectWidget(
                  departureStation: departureStation,
                  arrivalStation: arrivalStation,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
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
                      "좌석 선택",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
 * 출발역과 도착역을 선택하는 위젯
 */
class StationSelectWidget extends StatelessWidget {
  final String departureStation;
  final String arrivalStation;

  const StationSelectWidget({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StationSelectButton(
            title: '출발역',
            stationName: departureStation == '' ? '선택' : departureStation,
            onTap: () {
              // TODO: 출발역 선택 화면으로 이동
            },
          ),
          Container(width: 2, height: 50, color: Colors.grey[400]),
          StationSelectButton(
            title: '도착역',
            stationName: arrivalStation == '' ? '선택' : arrivalStation,
            onTap: () {
              // TODO: 도착역 선택 화면으로 이동
            },
          ),
        ],
      ),
    );
  }
}

class StationSelectButton extends StatelessWidget {
  final String title;
  final String stationName;
  final VoidCallback onTap;

  const StationSelectButton({
    super.key,
    required this.title,
    required this.stationName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Text(stationName, style: TextStyle(fontSize: 40)),
          ],
        ),
      ),
    );
  }
}
