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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.amber,
        title: new Text("AppBar"),
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            print("Add IconButton Pressed...");
          },)
        ],
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Body',
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) => debugPrint("Bottom Navigation Bar onTap: ${index}"),
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Bottom Nav Bar Item 1'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Bottom Nav Bar Item 2'),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.amberAccent,
        padding: EdgeInsets.all(20.0),
        child: Row(children: <Widget>[
          IconButton(
            icon: Icon(Icons.update),
            onPressed: () {
              print("Bottom Sheet Icon Pressed");
            },
          ),
          Text('Bottom Sheet Text')
        ],),
      ),

      /* this would be use in the app more. using this code. */
      drawer: Drawer(
        child: ListView(children: <Widget>[
          Row(children: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                print("Drawer Item 1 Pressed");
              },
            ),
            Text('Drawer item 1')
          ],),
          Row(children: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                print("Drawer Item 2 Pressed");
              },
            ),
            Text('Drawer Item 2')
          ],),
        ],
        ),
      ),

      endDrawer: Drawer(
        child: ListView(children: <Widget>[
          Row(children: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  print("Drawer Item 1");
                },),
              Text('Drawer Item 1 Pressed')
            ],),
          Row(children: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                print("Drawer Item 2");
              },),
            Text('Drawer Item 2 Pressed')
          ],),
        ],),
      ),

      floatingActionButton: new FloatingActionButton(
          onPressed: (){
            print('FloatingActionButton Pressed');
          },
          tooltip: 'Increment',
          child: new Icon(Icons.add),),
      persistentFooterButtons: <Widget>[
        IconButton(
          icon: Icon(Icons.update),
          onPressed: () {
            print("Persistant Footer Icon Pressed");
          },),
        Text('Presistant Footer Text')
      ],

    );
  }
}
