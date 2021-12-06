import 'package:flutter/material.dart';
import 'package:tictac/layout/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff222831),
        shadowColor: const Color(0xff30475E),
        splashColor: const Color(0xffF05454),
      ),
      home: const HomeScreen(),
    );
  }
}
