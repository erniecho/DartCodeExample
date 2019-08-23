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
      home: NewsfeedWidget(title: 'News Feed'),
    );
  }
}

class News {
  DateTime _dt;
  String _title;
  String _text;

  News(this._dt, this._title, this._text);
}


// ignore: must_be_immutable
class NewsCard extends StatelessWidget {
  News _news;

  NewsCard(this._news);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network("https://encrypted-tbn0.gstatic"
                  ".com/images?q=tbn:ANd9GcSgRogHfUfGFGAH"
                  "_9V3PJgb83dZYBHQ3n1WBe2zJlBY8EhfxiBLxw"
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Text("${_news._dt.month}//${_news._dt.day}/${_news._dt.year}",
                      style: TextStyle(
                          fontSize: 10.0, fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text("${_news._title}",
                      style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold))),
              Text(
                "${_news._text}",
                maxLines: 2,
                style: TextStyle(fontSize: 14.0),
                overflow: TextOverflow.fade,
              ),
              Row(children: <Widget>[
                FlatButton(child: Text("Share"), onPressed: () => {}),
                FlatButton(child: Text("Bookmark"), onPressed: () => {}),
                FlatButton(child: Text("Link"), onPressed: () => {}),
              ])
            ],
          ),),),);
  }
}

// ignore: must_be_immutable
class NewsfeedWidget extends StatelessWidget {
  NewsfeedWidget({Key key, this.title}) : super(key: key);

  final String title;
  List<News> _newsList = [
    News(
      DateTime(2019, 20, 8),
      "Free College",
      ""
    ),
    News(
        DateTime(2019, 20, 8),
        "Free College",
        ""
    ),
    News(
        DateTime(2019, 20, 8),
        "Free College",
        ""
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> newsCards = _newsList.map((news) => NewsCard(news)).toList();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('News Feed'),
      ),
      body: new ListView(padding: EdgeInsets.all(20.0), children: newsCards),
    );
  }
}
