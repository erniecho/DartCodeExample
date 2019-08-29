import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String computeListOfTimesstamps(int count) {
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < count; i++) {
      sb.write("${i + 1} : ${DateTime.now()}");
      debugPrint('sb.write("${i + 1} : ${DateTime.now()}")');
    }
    return sb.toString();
  }


  Future<String> createFutureCalculation(int count) {
    return new Future((){
      return computeListOfTimesstamps(count);
    });
  }

  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showCalculation = false;

  void _onInvokeFuturePressed() {
    setState(() {
      _showCalculation = !_showCalculation;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _showCalculation
        ? FutureBuilder(
      future: widget.createFutureCalculation(100000),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Expanded(
          child: SingleChildScrollView(
            child: Text(
              '${snapshot.data == null ?"":snapshot.data}',
              style: TextStyle(fontSize: 20.0),),),);
      },)
        : Text('hit the button to show calculation');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Future"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[child]),),
      floatingActionButton: new FloatingActionButton(
          onPressed: _onInvokeFuturePressed,
        tooltip: 'Invoke Future',
        child: new Icon(Icons.refresh),
      ),
    );
  }
}
