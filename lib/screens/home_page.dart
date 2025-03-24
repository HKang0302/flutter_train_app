import 'package:flutter/material.dart';
import 'package:flutter_train_app/screens/seat_page.dart';
import 'package:flutter_train_app/screens/station_list_page.dart';
import 'package:flutter_train_app/models/passenger_count.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const HomePage({super.key, required this.onThemeToggle});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String departureStation = '';
  String arrivalStation = '';
  final PassengerCount passengerCount = PassengerCount();

  void updatePassengerCount(String type, bool increment) {
    setState(() {
      switch (type) {
        case 'adult':
          if (increment) {
            passengerCount.adult++;
          } else if (passengerCount.adult > 0) {
            passengerCount.adult--;
          }
          break;
        case 'child':
          if (increment) {
            passengerCount.child++;
          } else if (passengerCount.child > 0) {
            passengerCount.child--;
          }
          break;
        case 'infant':
          if (increment) {
            passengerCount.infant++;
          } else if (passengerCount.infant > 0) {
            passengerCount.infant--;
          }
          break;
        case 'senior':
          if (increment) {
            passengerCount.senior++;
          } else if (passengerCount.senior > 0) {
            passengerCount.senior--;
          }
          break;
        case 'mildDisability':
          if (increment) {
            passengerCount.mildDisability++;
          } else if (passengerCount.mildDisability > 0) {
            passengerCount.mildDisability--;
          }
          break;
        case 'severeDisability':
          if (increment) {
            passengerCount.severeDisability++;
          } else if (passengerCount.severeDisability > 0) {
            passengerCount.severeDisability--;
          }
          break;
      }
    });
  }

  Widget passengerSelector(String title, String type, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => updatePassengerCount(type, false),
              ),
              Text('$count'),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => updatePassengerCount(type, true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기차 예매'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: Container(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).scaffoldBackgroundColor
                : Colors.grey[200],
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
                  onDepartureSelected: (station) {
                    setState(() {
                      departureStation = station;
                    });
                  },
                  onArrivalSelected: (station) {
                    setState(() {
                      arrivalStation = station;
                    });
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        final temp = departureStation;
                        departureStation = arrivalStation;
                        arrivalStation = temp;
                      });
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all(
                        const Size(double.infinity, 50),
                      ),
                      side: WidgetStateProperty.all(
                        BorderSide(color: Colors.purple.withAlpha(139)),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '출발역',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.swap_horiz, size: 24),
                        const SizedBox(width: 10),
                        Text(
                          '도착역',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      passengerSelector('성인', 'adult', passengerCount.adult),
                      passengerSelector('어린이', 'child', passengerCount.child),
                      passengerSelector('유아', 'infant', passengerCount.infant),
                      passengerSelector('결로', 'senior', passengerCount.senior),
                      passengerSelector(
                        '경증장애인',
                        'mildDisability',
                        passengerCount.mildDisability,
                      ),
                      passengerSelector(
                        '중증장애인',
                        'severeDisability',
                        passengerCount.severeDisability,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      if (departureStation == '' || arrivalStation == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('출발역과 도착역을 모두 선택해주세요.'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                          ),
                        );
                        return;
                      }
                      if (passengerCount.total == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('인원을 추가해주세요'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                          ),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => SeatPage(
                                departureStation: departureStation,
                                arrivalStation: arrivalStation,
                                passengerCount: passengerCount,
                              ),
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
  final Function(String) onDepartureSelected;
  final Function(String) onArrivalSelected;

  const StationSelectWidget({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
    required this.onDepartureSelected,
    required this.onArrivalSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]!
                : Colors.white,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => StationListPage(
                        title: '출발역 선택',
                        onStationSelected: onDepartureSelected,
                        currentStation: arrivalStation,
                      ),
                ),
              );
            },
          ),
          Container(width: 2, height: 50, color: Colors.grey[400]),
          StationSelectButton(
            title: '도착역',
            stationName: arrivalStation == '' ? '선택' : arrivalStation,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => StationListPage(
                        title: '도착역 선택',
                        onStationSelected: onArrivalSelected,
                        currentStation: departureStation,
                      ),
                ),
              );
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
