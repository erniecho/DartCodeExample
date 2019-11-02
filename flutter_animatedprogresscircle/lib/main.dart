import 'package:flutter/material.dart';
import 'dart:math';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;


  void _performAnimation() {
    setState(() {
      if (_controller.status != AnimationStatus.forward) {
        _controller.forward(from: 0.0);
      }
    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this)
        ..addListener(() {
          setState(() {
              // Force build...
          });
        });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("_controller: ${_controller.value}"),
     ),
     body: Container(child:
     Padding(
       padding: const EdgeInsets.all(20.0),
       child: CustomPaint(
         foregroundPainter: new ProgressCirclePainter(
           lineColor: Colors.amber,
           completeColor: Colors.blueAccent,
           completePercent: _controller.value * 100,
           width: 18.0)),
     ),
         constraints: BoxConstraints.expand(),
         margin: const EdgeInsets.all(8.0)
     ),
     floatingActionButton: FloatingActionButton(
       onPressed: _performAnimation,
       child: Icon(Icons.refresh),
     ),
   );
  }
}

class ProgressCirclePainter extends CustomPainter{
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;

  ProgressCirclePainter({this.lineColor, this.completeColor,
      this.completePercent, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
        ..color = lineColor
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = width;
    Paint complete = new Paint()
        ..color = completeColor
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = width;
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2 * pi * (completePercent / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
    arcAngle, false, complete);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }



}
