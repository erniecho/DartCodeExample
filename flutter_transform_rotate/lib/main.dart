import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Earth',
      theme: ThemeData(
        primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
AnimationController _controller;

@override
void initState() {
//  Create animation controller.

_controller =
    AnimationController(duration: const Duration(seconds: 10), vsync: this)
    ..addListener(() {
      setState(() {
//         Force build.
      });

    });
}


}
