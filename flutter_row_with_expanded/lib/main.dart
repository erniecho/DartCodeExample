import 'package:flutter/material.dart';

void main() => runApp(new RowWithExpandedApp());

class RowWithExpandedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  HomeWidget({Key, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Rows"),),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Text("None expanded:"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("aaaaaaaaaaa"),
              const Text("bbbbbbbbbbb"),
              const Text("ccccccccccc"),
            ],
          ),
          const Text("1st child expanded:"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Expanded(child: const Text("aaaaaaaaaaa")),
              const Text("bbbbbbbbbbb"),
              const Text("ccccccccccc"),
            ],
          ),
          const Text("2nd child expanded:"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("aaaaaaaaaaa"),
              const Expanded(child: const Text("bbbbbbbbbbb")),
              const Text("ccccccccccc"),
            ],
          ),
          const Text("3rd child expanded"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("aaaaaaaaaaa"),
              const Text("bbbbbbbbbbb"),
              const Expanded(child: const Text("ccccccccccc")),
            ],
          ),
        ],
      ),
    );
  }
}

