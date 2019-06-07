import 'package:flutter_web/material.dart';

class NavBar extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 45, vertical: 38),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 125,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [
                Color(0xFFC86DD7),
                Color(0xFF3029AE),
            ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
            child: Center(
              child: Text("ErnShu", style: TextStyle(fontSize: 30, color: Colors.white),),
              ),
        ),
        SizedBox(
          width: 16,
        ),
        Text("Testing", style: TextStyle(fontSize: 26))
    ],
    ),
  );
  }
}