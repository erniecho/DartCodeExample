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
}