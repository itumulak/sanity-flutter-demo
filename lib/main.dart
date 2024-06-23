import 'package:flutter/material.dart';
import 'package:sanity_flutter_demo/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanity Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
          background: Colors.white70
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
