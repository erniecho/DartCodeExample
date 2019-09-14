import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

void main() => runApp(new MyApp());

class Car{
  final String _make;
  final String _model;
  final String _imageSrc;

  const Car(this._make, this._model, this._imageSrc);

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

class CarModel {
  const CarModel(this.carList);

  final List<Car> carList;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other.runtimeType != runtimeType) {
      return false;
    } else {
      final CarModel otherModel = other;
      return IterableEquality().equals(otherModel.carList, carList);
    }
  }
    int get hashCode => carList.hashCode;
}

class _ModelBindingScope<T> extends InheritedWidget {
  const _ModelBindingScope({Key key, this.modelBindingState, Widget child})
  : super(key: key, child: child);

  final _ModelBindingState<T> modelBindingState;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

class ModelBinding<T> extends StatefulWidget {
  ModelBinding({Key key, @required this.initialModel, this.child})
      : assert(initialModel != null),
      super(key: key);

  final T initialModel;
  final Widget child;

  _ModelBindingState<T> createState() => _ModelBindingState<T>();

  static Type _typeOf<T>() => T;

  static T of<T>(BuildContext context) {
    final Type scopeType = _typeOf<_ModelBindingScope<T>>();
    final _ModelBindingScope<T> scope =
        context.inheritFromWidgetOfExactType(scopeType);
    return scope.modelBindingState.currentModel;
  }

  static void update<T>(BuildContext context, T newModel) {
    final Type scopeType = _typeOf<_ModelBindingScope<T>>();
    final _ModelBindingScope<dynamic> scope =
        context.inheritFromWidgetOfExactType(scopeType);
    scope.modelBindingState.updateModel(newModel);
  }
}

class _ModelBindingState<T> extends State<ModelBinding<T>> {
  T currentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }

  void updateModel(T newModel) {
    if (newModel != currentModel) {
      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ModelBindingScope<T>(
      modelBindingState: this,
      child: widget.child,
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ModelBinding<CarModel>(
        initialModel: const CarModel(const [
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
        ]),
        child: new MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    CarModel model = ModelBinding.of(context);
    List<CarWidget> carWidgets = model.carList.map((Car car) {
      return CarWidget(car);
    }).toList();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cars"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              List<Car> carList = List.from(model.carList);
              carList.add(Car(
                "Nissan",
                "Sentra",
                "Https://media.ed.edmunds-media.com/nissan/sentra/2017/oem/2017_nissan_sentra_sedan_sr-turbo_fq_oem_4_150.jpg",
              ));
              ModelBinding.update(context, new CarModel(carList));
            },),
        ],
      ),
      body: new ListView(children: carWidgets),);
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
           Text('${_car._make}${_car._model}',
           style: TextStyle(fontSize: 24.0)),
           Padding(
             padding: EdgeInsets.only(top: 20.0),
             child: Image.network(_car._imageSrc))
         ],),),),);
  }
}

