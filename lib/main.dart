import 'package:flutter/material.dart';
import 'package:volveretask/Input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Volvere Task",
      debugShowCheckedModeBanner: true,
      home: Input(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
    );
  }
}