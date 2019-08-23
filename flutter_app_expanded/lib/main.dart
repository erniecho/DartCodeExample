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
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => new _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool _topExpanded = false;
  bool _bottomExpanded = false;

  toggleTop() {
    setState(() => _topExpanded = !_topExpanded);
  }

  toggleBottom() {
    setState(() => _bottomExpanded = !_bottomExpanded);
  }

  @override
  Widget build(BuildContext context) {
  Container topContainer = Container(
    child: new Text(
      'Top Container',
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 1.0),
      color: Colors.blue),
    padding: EdgeInsets.all(10.0),
    );
  Container bottomContainer = Container(
    child: new Text(
      'Bottom Container',
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 1.0),
      color: Colors.yellow),
    padding: EdgeInsets.all(10.0),
  );
  Widget topWidget =
      _topExpanded ? Expanded(child: topContainer) : topContainer;
      Widget bottomWidget =
          _bottomExpanded ? Expanded(child: topContainer) : topContainer;
      return new Scaffold(
        appBar: new AppBar( title: new Text('Expanded'), actions: <Widget>[
          FlatButton.icon(
              onPressed: ()=> toggleTop(),
              icon: Icon(_topExpanded ? Icons.expand_more : Icons.expand_less),
              label: Text("Top")),
          FlatButton.icon(
              onPressed: ()=> toggleBottom(),
              icon: Icon(_topExpanded ? Icons.expand_less : Icons.expand_more),
              label: Text("Bottom")),
        ],),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[topWidget, bottomWidget],
          ),
        ),
      );
  }
}