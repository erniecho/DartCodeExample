import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

final key = new GlobalKey<_Widget1State>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: Widget1(key:key),
              color: Colors.greenAccent,
            ),
            Container(
              child: Widget2(),
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class Widget1 extends StatefulWidget {
  Widget1({Key key}) : super(key: key);
  @override
  _Widget1State createState() => _Widget1State();
}

class _Widget1State extends State<Widget1> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Widget2 extends StatefulWidget {
  @override
  _Widget2State createState() => _Widget2State();
}

class _Widget2State extends State<Widget2> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
