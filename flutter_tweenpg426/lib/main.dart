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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _yesOnTap() {
    print('yes');
  }

  _noOnTap() {
    print('no');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Do you want to\nbuy this item?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.w200),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(flex: 2),
              SelectButton(text: "YES", onTap: _yesOnTap),
              Spacer(),
              SelectButton(text: "NO", onTap: _noOnTap),
              Spacer(flex: 2),
            ],
          )
        ],
      ),
    );
  }
}

class SelectButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  SelectButton({@required this.text, @required this.onTap});

  @override
  _SelectButtonState createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton>
with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _circleTween;
  Animation<Color> _textTween;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
