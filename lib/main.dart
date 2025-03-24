import 'package:flutter/material.dart';
import 'package:flutter_train_app/screens/home_page.dart';

void main() {
  runApp(const TrainApp());
}

class TrainApp extends StatefulWidget {
  const TrainApp({super.key});

  @override
  State<TrainApp> createState() => _TrainAppState();
}

class _TrainAppState extends State<TrainApp> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(onThemeToggle: toggleTheme),
      // debugShowCheckedModeBanner: false,
    );
  }
}
