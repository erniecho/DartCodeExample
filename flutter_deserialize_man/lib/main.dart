import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class Person {
  final String name;
  final String addressLine1;
  final String addressCity;
  final String addressState;
  final List<Person> children;

  const Person(this.name, this.addressLine1, this.addressCity, this.addressState,
      this.children);

  factory Person.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw FormatException("Null JSON");
    }

    List<dynamic> decodedChildren = json['children'];
    List<Person> children = [];
    decodedChildren.forEach((decodedChild) {
      children.add(Person.fromJson(decodedChild));
    });

    return Person(
        json['name'],json['addr1'],json['city'],json['state'], children);
  }

  @override
  String toString() {
    return 'Person{name: $name, addressLine1: $addressLine1, addressCity: $addressCity, addressState: '
        '$addressState, children: $children}';
  }


}

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _jsonTextController = TextEditingController();
  Person _person;
  String _error;

  _MyHomePageState() {
    final String grandchild =
        "{\"name\":\"Tracy Brown\",\"add1\":\"9625 Roberts Avenue\"," +
    "\"city\":\"Birmingham\",\"state\":\"AL\",\"children\":[" +
    "]}";
  }

}
