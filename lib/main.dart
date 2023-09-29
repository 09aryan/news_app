import 'package:flutter/material.dart';
import './pages/newScreen.dart'; // Import the NewsScreen widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsScreen(),
    );
  }
}
