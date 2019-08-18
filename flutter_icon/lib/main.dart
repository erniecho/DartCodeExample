import 'package:flutter/material.dart';

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
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
Row row1 = Row(
 mainAxisAlignment: MainAxisAlignment.center,
 children: <Widget>[
   const Icon(Icons.add, size: 48),
   const Text("Specified size 48, default color black")
 ]);
Row row2 = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const Icon(Icons.add, size: 48),
      const Text("Specified size 48, default color black")
    ]);
Row row3 = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const Icon(Icons.add, size: 48),
      const Text("Specified size 48, default color black")
    ]);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          row1,row2, row3
        ]
      )
    );
  }
}
