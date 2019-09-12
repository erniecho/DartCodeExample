import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

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


class MyHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState("Cars");
}


class _HomePageState extends State<MyHomePage> {
  String _title;
  List<Car> _cars;
  Car _selectCar;

  _HomePageState(this._title) {
    _cars = [
      Car(
        "Bmw",
        "M3",
        "Https://media.ed.edmunds-"
            "media.com/bmw/m3/2018/oem/2018_bmw_m3_sedan_base_fq_oem_4_150.jpg",
      ),
      Car(
        "Nissan",
        "GTR",
        "Https://media.ed.edmunds-"
            "media.com/nissan/gt-r/2018/oem/2018_nissan_gt-"
            "r_coupe_nismo_fq_oem_1_150.jpg",
      ),
      Car(
        "Nissan",
        "Sentra",
        "Https://media.ed.edmunds-"
            "media.com/nissan/sentra/2017/oem/2017_"
            "nissan_sentra_sedan_sr-turbo_fq_oem_4_150.jpg",
      ),
    ];
  }

  void _selectionHandler(Car selectdCar) {
    setState(() {
      _title = 'Selected ${selectdCar._make}${selectdCar._model}';
      _selectCar = selectdCar;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<CarWidget> carWidget = _cars.map((Car car) {
      return CarWidget(car, car == _selectCar, _selectionHandler);
    }).toList();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_title),
      ),
      body: new ListView(children: carWidget),
    );
  }
}
class CarWidget extends StatelessWidget {
  CarWidget(this._car, this._isSelected, this._parentSelectionHandler)
      : super();

  final Car _car;
  final bool _isSelected;
  final ValueChanged<Car> _parentSelectionHandler;

  void _handleTap() {
    _parentSelectionHandler(_car);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: GestureDetector(
      onTap: _handleTap,
      child: Container(
        decoration: BoxDecoration(
            color: _isSelected ? Colors.blue : Colors.white,
            border: Border.all()),
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(children: <Widget>[
            Text('${_car._make} ${_car._model}',
            style: TextStyle(fontSize: 24.0)),
            Padding(
             padding: EdgeInsets.only(top: 20.0),
             child: Image.network(_car._imageSrc),
            )],),
        ),),),);
  }
}