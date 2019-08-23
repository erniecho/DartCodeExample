import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class CirclePainter extends CustomPainter {
  final _random = new Random();
  List<Color> _colors = [];

  CirclePainter() {
    for (int i=0; i < 100; i++) {
      _colors.add(Colors.green
          .withRed(next(0,255))
          .withGreen(next(0,255))
          .withBlue(next(0,255)));
    }
  }

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 100; i++) {
      var radius = (i * 10).toDouble();
      canvas.drawCircle(
        new Offset(1000.0, 1000.0),
        radius,
        new Paint()
          ..color = _colors[i]
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15.0);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
   return false;
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  CirclePainter circlePainter = new CirclePainter();
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Scroll"),
      ),
      body: new SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: CustomPaint(
          size: Size(2000.0, 2000.0),
          foregroundPainter: circlePainter,
        ),
      ),
    );
  }
}


