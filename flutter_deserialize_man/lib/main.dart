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
    final String adultFather =
        "{\"name\":\"John Brown\",\"add1\":\"9625 Roberts Avenue\"," +
            "\"city\":\"Birmingham\",\"state\":\"AL\",\"children\":[" +
            grandchild +
            "]}";
    final String adultNoChildren =
        "{\"name\":\"Jill Jones\",\"add1\":\"100 East Road\"," +
            "\"city\":\"Ocala\",\"state\":\"FL\",\"children\":[" +
            "]}";
    final String grandfather =
        "{\"name\":\"John Brown\",\"add1\":\"9625 Roberts Avenue\"," +
            "\"city\":\"Birmingham\",\"state\":\"AL\",\"children\":[" +
            adultFather +
            "," +
            adultNoChildren +
            "]}";

    _jsonTextController.text = grandfather;
  }

  TextFormField _createJsonTextFormField() {
    return new TextFormField(
      // ignore: missing_return
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter the json';
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Json',
        labelText: 'Enter the json for a person.'),
      controller: _jsonTextController,
      autofocus: true,
      maxLines: 8,
      keyboardType: TextInputType.multiline);
  }

  _convertJsonToPerson() {
    _error = null;
    _person = null;
    setState(() {
      try {
        final String jsonText = _jsonTextController.text;
        debugPrint("JSON TEXT: ${jsonText}");
        var decoded = json.decode(jsonText);
        debugPrint("DECODED: type:${decoded.runtimeType}value: ${decoded}");
        _person = Person.fromJson(decoded);
        debugPrint("PERSON OBJECT: type: ${_person.runtimeType}value:"
        "${_person}");
      } catch (e) {
        debugPrint("ERROR: ${e}");
        _error = e.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recursive Deserialization"),
      ),
      body: Center(
        child: Padding(
          child: ListView(
            children: <Widget>[
              _createJsonTextFormField(),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  _error == null ? '' : 'An error occured:\n\n${_error}',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(_person == null
                ? 'Person is null'
                :'Converted to Person object:\n\n${_person}'),),
            ],
          ),
          padding: EdgeInsets.all(10.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _convertJsonToPerson,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ),
    );
  }

}
