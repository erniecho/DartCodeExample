import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<dynamic> _nasaOffices = [
    {
      "Name":"March 6, High Reynolds Number Facility",
      "Address":"1864 4th St",
      "City":"Wright-Patterson AFB",
      "State":"OH",
      "ZIP":"45433-7541",
      "Country":"US"
    },
    {
      "Name":"N206A - 12 FOOT PRESSURE WIND TUNNEL AUXILIARIES (PAPAC)",
      "Address":"Code RC",
      "City":"Moffett Field",
      "State":"CA",
      "ZIP":"94035",
      "Country":"US"
    },
    {
      "Name":"March 6, High Reynolds Number Facility",
      "Address":"1864 4th St",
      "City":"Wright-Patterson AFB",
      "State":"OH",
      "ZIP":"45433-7541",
      "Country":"US"
    },
    {
      "Name":"N206A - 12 FOOT PRESSURE WIND TUNNEL AUXILIARIES (PAPAC)",
      "Address":"Code RC",
      "City":"Moffett Field",
      "State":"CA",
      "ZIP":"94035",
      "Country":"US"
    },
    {
      "Name":"March 6, High Reynolds Number Facility",
      "Address":"1864 4th St",
      "City":"Wright-Patterson AFB",
      "State":"OH",
      "ZIP":"45433-7541",
      "Country":"US"
    },
    {
      "Name":"N206A - 12 FOOT PRESSURE WIND TUNNEL AUXILIARIES (PAPAC)",
      "Address":"Code RC",
      "City":"Moffett Field",
      "State":"CA",
      "ZIP":"94035",
      "Country":"US"
    },
    {
      "Name":"March 6, High Reynolds Number Facility",
      "Address":"1864 4th St",
      "City":"Wright-Patterson AFB",
      "State":"OH",
      "ZIP":"45433-7541",
      "Country":"US"
    },
    {
      "Name":"N206A - 12 FOOT PRESSURE WIND TUNNEL AUXILIARIES (PAPAC)",
      "Address":"Code RC",
      "City":"Moffett Field",
      "State":"CA",
      "ZIP":"94035",
      "Country":"US"
    }
  ];

  MyHomePage({Key key}) : super(key: key){
    _nasaOffices.sort((a,b) => a['Name'].compareTo(b['Name']));
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ListView builder = ListView.builder(
      itemCount: widget._nasaOffices.length,
      itemBuilder: (context, index) {
        print('invoking itemBuilder for row ${index}');
        var nasaOffice = widget._nasaOffices[index];
        return ListTile(
          title: Text('${nasaOffice['Name']}'),
          subtitle: Text('${nasaOffice['Address']},${nasaOffice['City']}'
          '${nasaOffice['State']},${nasaOffice['ZIP']},'
          '${nasaOffice['Country']}'),
          trailing: Icon(Icons.arrow_right),);
      },);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Nasa Offices"),
      ),
      body: new Center(child: builder),
    );
  }


}
