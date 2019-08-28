import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class ExpansionPanelData {
  String _title;
  String _body;
  bool _expanded;

  ExpansionPanelData(this._title, this._body, this._expanded);

  String get title => _title;

  @override
  String toString() {
    return 'ExpansionPanelData{_title: $_title, _body: $_body, _expanded: $_expanded}';
  }

  // ignore: unnecessary_getters_setters
  bool get expanded => _expanded;

  String get body => _body;

  // ignore: unnecessary_getters_setters
  set expanded(bool value) {
    _expanded = value;
  }


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      showPerformanceOverlay: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState([
    ExpansionPanelData(
     "Can I backup my data?",
     "fashgalhgal;g ahg;aghagg/h agh;aghagh",
     false),
    ExpansionPanelData(
        "Can I backup my data?",
        "fashgalhgal;g ahg;aghagg/h agh;aghagh",
        false),
    ExpansionPanelData(
        "Can I backup my data?",
        "fashgalhgal;g ahg;aghagg/h agh;aghagh",
        false),
  ]);
}

class _MyHomePageState extends State<MyHomePage> {
 List<ExpansionPanelData> _expansionPanelData;
 _MyHomePageState(this._expansionPanelData);

 _onExpansion(int panelIndex, bool isExpanded) {
   setState(() {
     _expansionPanelData[panelIndex].expanded =
         !(_expansionPanelData[panelIndex].expanded);
   });
 }

 @override
 Widget build(BuildContext context) {
   List<ExpansionPanel> expansionPanels = [];
       for (int i = 0, ii = _expansionPanelData.length; i < ii ; i++) {
         var expansionPanelData = _expansionPanelData[i];
         expansionPanels.add(ExpansionPanel(
           headerBuilder: (BuildContext context, bool isExpanded){
             return Padding(
              padding: EdgeInsets.all(20.0),
               child: Text(expansionPanelData.title,
                   style: TextStyle(
                   fontSize: 20.0, fontWeight: FontWeight.bold
               ),),);
           },
           body: Padding(
             padding: EdgeInsets.all(20.0),
             child: Text(expansionPanelData.body,
             style:
             TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),),),
           isExpanded: expansionPanelData.expanded));
       }
       return new Scaffold(
         appBar: new AppBar(
           title: new Text("FAQs"),
         ),
         body: SingleChildScrollView(
           child: Container(
             margin: const EdgeInsets.all(24.0),
             child: new ExpansionPanelList(
               children: expansionPanels, expansionCallback:  _onExpansion,
             ),
           ),
         ),
       );
 }
}
