import 'package:flutter/material.dart';
import 'package:flutter_train_app/data/stations.dart';

class StationListPage extends StatelessWidget {
  final String title;
  final Function(String) onStationSelected;
  final String? currentStation;

  const StationListPage({
    super.key,
    required this.title,
    required this.onStationSelected,
    this.currentStation,
  });

  @override
  Widget build(BuildContext context) {
    final filteredStations =
        stations.where((station) => station.name != currentStation).toList();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: filteredStations.length,
        itemBuilder: (context, index) {
          final station = filteredStations[index];
          return Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: ListTile(
              title: Text(
                station.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                onStationSelected(station.name);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
