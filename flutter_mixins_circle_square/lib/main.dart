import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new CircleWidget(),
      routes: <String, WidgetBuilder>{
        '/circle': (context) => CircleWidget(),
        '/square': (context) => SquareWidget(),
      },
    );
  }
}

class Colorizer {
  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);

  List<Color> _color = [];
  _initColor() {
    for (int i = 0; i < 100; i++) {
      _color.add(Colors.green
          .withRed(next(0, 255))
          .withGreen(next(0, 255))
          .withBlue(next(0, 255)));
    }
  }
}
//Mixin classes
class CirclePainter extends CustomPainter with Colorizer {
  CirclePainter() {
    _initColor();
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 100; i++) {
      var radius = (i * 10).toDouble();
      canvas.drawCircle(
          new Offset(1000.0, 1000.0)
          , radius
          , new Paint()
          ..color = _color[i]
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
//mixin class
class SquarePainter extends CustomPainter with Colorizer {
  SquarePainter() {
    _initColor();
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 100; i++) {
      var inset = (i * 10).toDouble();
      canvas.drawRect(
          new Rect.fromLTRB(inset, inset, 2000.0 - inset, 2000.0 - inset),
        new Paint()
          ..color = _color[i]
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15.0);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => false;
}

class CircleWidget extends StatelessWidget {
  CirclePainter _painter = new CirclePainter();
  CircleWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Circle'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.crop_square),
          onPressed: () => Navigator.pushNamed(context, "/square"),),
      ]),
      body: new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        child: CustomPaint(
          size: Size(2000.0, 2000.0),
          foregroundPainter: _painter,
        ),),);
  }
}

class SquareWidget extends StatelessWidget {
  SquarePainter _painter = new SquarePainter();
  SquareWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Square"),
      ),
      body: new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        child: CustomPaint(
          size: Size(2000.0, 2000.0),
          foregroundPainter: _painter,
        ),),);
  }
}
