import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


void main() {
  runApp(MyApp());
}

enum Language { english, spanish}

class Word {
  final int _id;
  final String _english;
  final String _spanish;

  Word(this._id, this._english, this._spanish);

  Map<String, dynamic> toMap() {
    return {'id': _id, 'english': _english, 'spanish': _spanish};
  }

  String get spanish => _spanish;

  String get english => _english;

  int get id => _id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Word &&
              runtimeType == other.runtimeType &&
              _id == other._id &&
              _english == other._english &&
              _spanish == other._spanish;

  @override
  int get hashCode =>
      _id.hashCode ^
      _english.hashCode ^
      _spanish.hashCode;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DbWidget(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeWidget()));
  }
}

class DbWidget extends InheritedWidget {
  final _random = new Random();
  Database _database;
  String _databasesPath;

  DbWidget({Key key, @required Widget child})
      : assert(child != null),
  super(key: key, child: child);

  Future<bool> loadDatabasesPath() async {
    _databasesPath = await getDatabasesPath();
    return true;
  }

  Future<bool> openAndInitDatabase() async {
    _database = await openDatabase(
      join(_databasesPath, 'vocabulary.db'),
      onCreate: (db, version) {
        debugPrint("creating database...");
        db.execute("CREATE TABLE word(id INTEGER PRIMARY KEY, english TEXT,"
        "spanish TEXT, correct INTEGER, incorrect INTEGER)");
        db.execute("INSERT INTO word(english, spanish)"
        "VALUES('uncle','tio')");
        db.execute("INSERT INTO word(english, spanish)"
            "VALUES('reader','lector')");
        db.execute("INSERT INTO word(english, spanish)"
            "VALUES('to keep vigil over','velar')");
        db.execute("INSERT INTO word(english, spanish)"
            "VALUES('to remove','quitar')");
        db.execute("INSERT INTO word(english, spanish)"
            "VALUES('to continue','reanudar')");
        db.execute("INSERT INTO word(english, spanish)"
            "VALUES('until','hasta')");
        debugPrint("done");
      },
      version: 1,
    );
    return true;
  }

  Future<Word> loadNextWord(Word priorWord) async {
    final List<Map<String, dynamic>> words = await _database.query('word');
    final List<Word> list = List.generate(words.length, (i) {
      return Word(words[i]['id'],words[i]['english'],words[i]['spanish']);
    });

    Word nextWord = null;
    do {
      int nextWordIndex = _nextRandom(0, list.length);
      nextWord = list[nextWordIndex];
    } while (nextWord == priorWord);
    return  nextWord;
  }


  Future<int> addWord(Word word) async {
    return await _database.insert('word', word.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteWord(Word word) async {
    return await _database.delete(
      'word',
      where: "id = ?",
      whereArgs: [word.id],
    );
  }

  static DbWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DbWidget) as DbWidget;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  int _nextRandom(int min, int max) => min + _random.nextInt(max - min);
}

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loadedDatabasePath = false;
  bool _openedDatabase = false;
  Language _language = Language.spanish;
  Word _priorWord;
  Word _word;

  _showSnackBar(String content, {bool error = false}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content:
      Text('${error ? "An unexpected error occurred: ":""}${content}'),
    ));
  }

  _loadDatabasesPath(BuildContext context) {
    try {
      DbWidget.of(context).loadDatabasesPath().then((b) {
        setState(() {
          _loadedDatabasePath = true;
        });
      }).catchError((error) {
        _showSnackBar(error.toString(), error: true);
      });
    } catch (e) {
      _showSnackBar(e.toString(), error: true);
    }
  }

  _openAndInitDatabase(BuildContext context) {
    try {
      DbWidget.of(context).openAndInitDatabase().then((b) {
        setState(() {
          _openedDatabase = true;
        });
      }).catchError((error) {
        _showSnackBar(error.toString(), error: true);
      });
    } catch (e) {
      _showSnackBar(e.toString(), error: true);
    }
  }

  _loadWord(BuildContext context) {
    try {
      DbWidget.of(context).loadNextWord(_priorWord).then((word) {
        setState(() {
          _word = word;
        });
      }).catchError((error) {
        _showSnackBar(error.toString(), error: true);
      });
    } catch (e) {
      _showSnackBar(e.toString(), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loadedDatabasePath) {
      _loadDatabasesPath(context);
    } else if (!_openedDatabase){
      _openAndInitDatabase(context);
    } else if (_word == null){
      _loadWord(context);
    }

    WordWidget englishWordWidget =
        WordWidget(Language.english, _language, _word);
    WordWidget spanishWordWidget =
        WordWidget(Language.spanish, _language, _word);

    Column wordWidgets = _language == Language.spanish
      ? Column(children: [englishWordWidget, spanishWordWidget])
        : Column(children: [spanishWordWidget, englishWordWidget]);

    AppBar appBar = AppBar(title: Text("Vocabulary"), actions: <Widget>[
      IconButton(icon: Icon(Icons.shuffle), onPressed: () => _switchLanguage() ,),
      IconButton(icon: Icon(Icons.add), onPressed: () => _addWord(context),),
      IconButton(icon: Icon(Icons.remove), onPressed: () =>  _deleteWord(context),)
    ]);

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: wordWidgets,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh), onPressed: () => _loadNextWord(),),);
  }

  _loadNextWord() {
    setState(() {
      _priorWord = _word;
      _word = null;
    });
  }

  _switchLanguage() {
    Language newLanguage =
        _language == Language.spanish ? Language.english : Language.spanish;
    setState(() => _language = newLanguage);
  }

  _addWord(BuildContext context) async {
    Word word = await showDialog<Word>(
      context: context,
      builder: (BuildContext context) {
       return Dialog(child: AddDialogWidget(),);
      });
    if  (word != null) {
      try {
        DbWidget.of(context).addWord(word).then((_) {
          _loadNextWord();
          _showSnackBar("Added word.");
        }).catchError((e) => _showSnackBar(e.toString(), error: true))
      } catch (e) {
        _showSnackBar(e.toString(), error: true);
      }
    }
  }
  // _deleteWord method function needs to be added here.





}