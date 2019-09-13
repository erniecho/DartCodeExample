import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

void main() => runApp(new MyApp());

class Car {
  String _make;
  String _model;
  String _imageSrc;

  Car(this._make, this._model, this._imageSrc);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Car &&
              runtimeType == other.runtimeType &&
              _make == other._make &&
              _model == other._model &&
              _imageSrc == other._imageSrc;

  @override
  int get hashCode =>
      _make.hashCode ^
      _model.hashCode ^
      _imageSrc.hashCode;
}

// ignore: must_be_immutable
class CarsInheritedWidget extends InheritedWidget {
  List<Car> _cars = [
    Car(
      "Bmw",
      "M3",
      "Https://media.ed.edmunds-media.com/bmw/m3/2018/oem/2018_bmw_m3_sedan_base_fq_oem_4_150.jpg",
    ),
    Car(
        "Nissan",
        "GTR",
        "Https://media.ed.edmunds-media.com/nissan/gt-r/2018/oem/2018_nissan_gt-r_coupe_nismo_fq_oem_1_150.jpg",
    ),
    Car(
        "Nissan",
        "Sentra",
        "Https://media.ed.edmunds-media.com/nissan/sentra/2017/oem/2017_nissan_sentra_sedan_sr-turbo_fq_oem_4_150.jpg",
    ),
  ];

  CarsInheritedWidget(child) : super(child: child);

  List<Car> get cars {
    return _cars;
  }

  void addNissanSentra() {
    _cars.add(Car(
        "Nissan",
        "Sentra",
        "Https://media.ed.edmunds-media.com/nissan/sentra/2017/oem/2017_nissan_sentra_sedan_sr-turbo_fq_oem_4_150.jpg"
    ));
  }

  @override
  bool updateShouldNotify(CarsInheritedWidget old) => true;

  static CarsInheritedWidget of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CarsInheritedWidget));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CarsInheritedWidget(MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    List<CarWidget> carWidgets =
        CarsInheritedWidget.of(context).cars.map((Car car) {
          return CarWidget(car);
        }).toList();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cars"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              CarsInheritedWidget.of(context).addNissanSentra();
            },)
        ],
      ),body: new ListView(children: carWidgets),);
  }
}

class CarWidget extends StatelessWidget {
  CarWidget(this._car) : super();

  final Car _car;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(children: <Widget>[
            Text('${_car._make} ${_car._model}',
            style: TextStyle(fontSize: 24.0),),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Image.network(_car._imageSrc),),
          ],),),),);
  }


}
