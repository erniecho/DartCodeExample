import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

enum PopupMenuAction { add1,add10,add100,exit}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
  int _counter = 0;

  void _increment(int by) {
    setState(() {
      _counter += by;
    });
  }

  void _onPopupMenuSelected(PopupMenuAction item) {
    if (PopupMenuAction.exit == item) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      _increment(PopupMenuAction.add1 == item
      ? 1
      : PopupMenuAction.add10 == item ? 10: 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<PopupMenuAction>(
            onSelected: _onPopupMenuSelected,
            itemBuilder: (BuildContext context) =>
             <PopupMenuEntry<PopupMenuAction>>[
                const PopupMenuItem<PopupMenuAction>(
                  value: PopupMenuAction.add1,
                  child: Text('+1'),
                ),
               const PopupMenuItem<PopupMenuAction>(
                 value: PopupMenuAction.add10,
                 child: Text('+10'),
               ),
               const PopupMenuItem<PopupMenuAction>(
                 value: PopupMenuAction.add100,
                 child: Text('+100'),
               ),
               const PopupMenuItem<PopupMenuAction>(
                 value: PopupMenuAction.exit,
                 child: Text('Exit'),
               ),
            ],
          )
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
                '$_counter',
              style: Theme.of(context).textTheme.display1,
            )
          ],
        ),
      ),
    );
  }
}
