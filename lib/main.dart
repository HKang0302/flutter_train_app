import 'package:flutter/material.dart';
import 'package:flutter_train_app/screens/home_page.dart';

void main() {
  runApp(const TrainApp());
}

class TrainApp extends StatelessWidget {
  const TrainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      // debugShowCheckedModeBanner: false,
    );
  }
}
