import 'package:flutter/material.dart';
import 'dart:ui';
import'package:flutter/foundation.dart';

void main() =>runApp(AppWidget());

class AppWidget extends StatefulWidget {
  AppWidget() {
    debugPrint("App Widget - constructor -" + hashCode.toString());

  }

  @override
  _AppWidgetState createState() {
    debugPrint("App Widget - createState -" + hashCode.toString());
    return _AppWidgetState();
  }
}

class _AppWidgetState extends State<AppWidget> {
  bool _bright = false;

_brightnessCallback() {
  setState(() => _bright =! _bright);
}

  @override
  Widget build(BuildContext context) {
    debugPrint("_AppWidgetState - build - " + hashCode.toString());
    return MaterialApp(
      title: 'FLutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: _bright ? Brightness.light : Brightness.dark),
      home: FlowerWidget(
        imageSrc: _bright
            ? "https://www.viewbug.com/media/mediafiles/" +
          "2015/07/05/56234977_large1300.jpg"
            : "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/colorful-of-dahlia-pink-flower-in-beautiful-garden-royalty-free-image-825886130-1554743243.jpg?crop=1.00xw:0.753xh;0,0.247xh&resize=980:*",
        brightnessCallback: _brightnessCallback
      ),
    );
  }
}

class FlowerWidget extends StatefulWidget {
  final String imageSrc;
  final VoidCallback brightnessCallback;

  FlowerWidget({Key key,this.imageSrc, this.brightnessCallback}) : super(key: key) {
    debugPrint("FlowerWidget - constructor -" + hashCode.toString());
  }

  @override
  _FlowerWidgetState createState() {
    debugPrint("FlowerWidget -createState-" + hashCode.toString());
    return _FlowerWidgetState();
  }
}

class _FlowerWidgetState extends State<FlowerWidget> {
  double _blur = 0;

  _FlowerWidgetState() {
    debugPrint("_FlowerWidgetState - constructor -" + hashCode.toString());
  }

  @override
  void initState() {
   debugPrint(" _FlowerWidgetState - initState -" + hashCode.toString());
  }

  @override
  void didChangeDependencies() {
    debugPrint(
      "_FlowerWidgetState - didChangeDependencies" + hashCode.toString()
    );
  }

  @override
  void didUpdateWidget(FlowerWidget oldWidget) {
    debugPrint("_FlowerWidgetState - didUpdateWidget." + hashCode.toString());
    _blur = 0;
  }

  void _blurMore() {
    setState(() {
      _blur += 5.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("_FlowerWidgetState build" + hashCode.toString());
    return Scaffold(
      appBar: AppBar(title: Text("Flower"), actions: [
        new IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              widget.brightnessCallback();
            })
      ]),
      body: new Container(
        decoration: new BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: new DecorationImage(
              image: NetworkImage(widget.imageSrc),
            fit: BoxFit.cover)),
        child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: _blur,sigmaY: _blur),
          child: new Container(
            decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _blurMore,
        tooltip: 'Blur More',
        child: Icon(Icons.add),
      ),
    );
  }
}