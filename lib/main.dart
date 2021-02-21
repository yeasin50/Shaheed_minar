import 'package:flutter/material.dart';
import 'package:shaheedMinar/body.dart';
import 'package:shaheedMinar/rive/shaheed_minar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  animState() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///TODO:: Background color
      backgroundColor: Colors.blue.withAlpha(40),
      body: Body(),
    );
  }
}
