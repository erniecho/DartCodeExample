import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey _counterWidgetGlobalKey = GlobalKey();
  bool _widget1 = true;

  _selectPage() {
    setState(() => _widget1 = !_widget1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _widget1
        ? Widget1(_counterWidgetGlobalKey, _selectPage)
          : Widget2(_counterWidgetGlobalKey, _selectPage));
  }
//This widget is the root of your application.
}

class Widget1 extends StatelessWidget {
  final GlobalKey _counterWidgetGlobalKey;
  final VoidCallback _selectPageCallback;

  Widget1(this._counterWidgetGlobalKey, this._selectPageCallback);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Widget 1"),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.refresh),
            onPressed: () => _selectPageCallback()
          )
        ]
      )
    );
  }


}
