import 'dart:math';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 38,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    Avatar(),
                    SizedBox(height: 60,),
                    Expanded(child: SizedBox(),),
                    SizedBox(height: 30,),
                    Transform.rotate(
                        angle: pi/4,

                    ),
                    SizedBox(height: 60,),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 4.0 / 3,
                            child: ActiveTab(),

                          ),



                          Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color(0xFEEEA255),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 10),

                                ),
                              ]
                            ),
                          )
                        ],
                      ),
                    ),



                    SizedBox(height: 60),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                              color: const Color(0x44000000),

                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveTab  extends StatelessWidget {
}

class Avatar extends StatelessWidget {



}
