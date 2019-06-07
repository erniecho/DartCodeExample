import 'package:flutter_web/material.dart';

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
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Text("About")),
                Tab(icon: Text("Services")),
                Tab(icon: Text("Contact")),
                Tab(icon: Text("Apps")),
              ],
            ),
            title: Text('ErnShu Corporation'),
          ),
          body: TabBarView(
            children: [
              Text("""ERNSHU provide corp computer and network technical support for small to large corperate sector.
               We can help remote access to router and switches computer network. Lan lines that stop working can be fix by ErnShu LLC in less than one to three days work week or weekend.
               Contract for quote on projects installing thoasands of PC's, Mac's, Network devices, and running ethernet cable DMARC to Server Rooms.
               """,
              textAlign: TextAlign.center,
              //overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              Text("""
              Services

Installing lines from DMARC to Server room.
Installing VOIP phones and running ethernet wire to 
Removing Cisco equipment and Installing Routers, Switches, and POE Switches.
              """, 
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              Text("Contact"),
              Text("Apps"),
            ],
          ),
        ),
      ),
    );
  }
}