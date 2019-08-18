import 'package:flutter/material.dart';

void main() => runApp(new ButtonApp());

class ButtonApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  return new MaterialApp(
    title: 'Button Demo',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomeWidget(),
  );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  Row flatButtonRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      FlatButton(
        onPressed: () => debugPrint('Flatbutton pressed'),
        child: Text('FlatButon'),
      ),
      const Text('FlatButton')
    ],
  );
  Row raisedButtonRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      RaisedButton(
        onPressed: () => debugPrint('RaisedButton pressed'),
        child: Text('RaisedButton'),
      ),
      const Text('RaisedButton')
    ],
  );
  Row iconButtonRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      IconButton(
        onPressed: () => debugPrint('IconButton pressed'),
        icon: Icon(Icons.add),
      ),
      const Text('IconButton')
    ],
  );
  Row outlineButtonRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      OutlineButton(
        onPressed: () => debugPrint('OutlineButton pressed'),
        child: Text("OutlineButton"),
      ),
      const Text('OutlineButton')
    ],
  );
  Row dropdownButtonRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      new DropdownButton<String>(
        items: <String> ['Mens','Womans'].map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
              child: Text(value),
          );
  }).toList(),
      onChanged: (value) => debugPrint('Changed: ${value}')),
      const Text("Dropdownbutton")
  ]);

  Row backButtonRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[BackButton(), const Text("BackButton")],);

  Row closeButtonRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[CloseButton(), const Text("CloseButton")],);


  return new Scaffold(
    appBar: new AppBar(
      title: const Text("Buttons"),
    ),
    body: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          flatButtonRow,
          raisedButtonRow,
          iconButtonRow,
          outlineButtonRow,
          dropdownButtonRow,
          backButtonRow,
          closeButtonRow
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint('FloatingActionButton pressed'),
      child: const Text('F.A.B'),
    ),
  );
  }
}