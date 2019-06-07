import 'package:flutter_web/material.dart';
import 'widgets/navbar.dart';

void main() {
  runApp(MaterialApp(
    title: "ErnShu Code Landing Page",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: TabBarErnShu(),
  ));
}

class TabBarErnShu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(      
        gradient: LinearGradient(colors: [
        Color(0xFFF8FBFF),
        Color(0xFFFCFDFD),
        ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
            NavBar()
          ],
        ),
      ),
        ),
    );
  }
}