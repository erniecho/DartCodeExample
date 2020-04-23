import 'package:flutter/material.dart';
import 'dart:math';


void main() => runApp(new GridViewApp());

class Cat {
  String imageSrc;
  String name;
  int age;
  int votes;

  Cat(this.imageSrc, this.name, thisage, this.votes);

  // ignore: hash_and_equals
  operator ==(other) => (other is Cat) && (imageSrc == other.imageSrc);

  int get hacCoe => imageSrc.hashCode;
}

class GridViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cat Voting',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomeWidget(title: 'Cat Voting Home Page'),
    );
  }
}

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key, this.title}) : super(key : key);

  final String title;

  @override
  _HomeWidgetState createState() => new _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<String> CAT_NAMES = [
    "Tom",
    "Oliver",
    "Ginger",
    "Pontouf",
    "Madison",
    "Bubblita",
    "Bubbles"
  ];
  Random _random = Random();
  List<Cat> _cats = [];
  int next(int min, int max) => min + _random.nextInt(max - min);

  _HomeWidgetState() : super() {
    // Generate list of Cat objects once.
    for (int i = 200; i < 300; i += 10) {
      _cats.add(Cat("http://placekitten.com/200/$i", CAT_NAMES[next(0,6)], next(1, 32), 0));
    }
  }

  void _shuffle() {
    //Shuffle the list of Cat objects.
    setState(() {
      _cats.shuffle(_random);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView"),
      ),
      body: OrientationBuilder(builder: (context, orientation){
        return new GridView.builder(
        itemCount: _cats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0
          ),
          itemBuilder: (BuildContext context, int index) {
          return CatTile(_cats[index]);
          });
      }),
      floatingActionButton: new FloatingActionButton(
        onPressed: _shuffle,
        tooltip: 'Try more grid options',
        child: new Icon(Icons.refresh),
      )
    );
  }
}