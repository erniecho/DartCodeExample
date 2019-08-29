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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TableRow tableRow = TableRow(children: [
      const Text("aaaaaaaaaaaaaaa", overflow: TextOverflow.fade,),
      const Text("bbbbbbbbbbbbbbb", overflow: TextOverflow.fade,),
      const Text("ccccccccccccccc", overflow: TextOverflow.fade,),
    ]);
    return new Scaffold(
      appBar: new AppBar(title: new Text("Table"),),
      body: new Table(
        children: [
          tableRow,
          tableRow,
          tableRow,
          tableRow,
          tableRow,
          tableRow,
          tableRow,
          tableRow,
          tableRow,
          tableRow,
        ],
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(0.1),
          1: FlexColumnWidth(0.3),
          2: FlexColumnWidth(0.6),
        },
        border: TableBorder.all(),
      ),
    );
  }
}

