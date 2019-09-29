import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';


void main() => runApp(ThemeBLOC(child: new GridView()));

const COLOR_COFFEE = Color.fromARGB(0xFF, 112, 80, 80);
const COLOR_DARK_BROWN = Color.fromARGB(0xFF, 59, 20, 18);
const COLOR_GREY = Color.fromARGB(0xFF, 68, 68, 68);
const COLOR_LIGHT_BLUE = Color.fromARGB(0xFF, 112, 207, 221);
const COLOR_MAROON = Color.fromARGB(0xFF, 86, 18, 16);
const COLOR_NAVY_BLUE = Color.fromARGB(0xFF, 15, 32, 67);
const COLOR_ORANGE = Color.fromARGB(0xFF, 240, 146, 34);
const COLOR_SAND = Color.fromARGB(0xFF, 213, 184, 88);
const COLOR_YELLOW = Color.fromARGB(0xFF, 246, 236, 32);

const COLOR_DROPDOWN_MENU_ITEMS = [
  DropdownMenuItem(value: COLOR_COFFEE, child: const Text("Coffee")),
  DropdownMenuItem(value: COLOR_DARK_BROWN, child: const Text("Dark Brown")),
  DropdownMenuItem(value: COLOR_GREY, child: const Text("Grey")),
  DropdownMenuItem(value: COLOR_LIGHT_BLUE, child: const Text("Light Blue")),
  DropdownMenuItem(value: COLOR_MAROON, child: const Text("Maroon")),
  DropdownMenuItem(value: COLOR_NAVY_BLUE, child: const Text("Navy Blue")),
  DropdownMenuItem(value: COLOR_ORANGE, child: const Text("Orange")),
  DropdownMenuItem(value: COLOR_SAND, child: const Text("Sand")),
  DropdownMenuItem(value: COLOR_YELLOW, child: const Text("Yellow")),
];

class ColorOptions {
  Color primaryColor;
  Color scaffoldBackgroundColor;
  Color accentColor;

  ColorOptions({@required this.primaryColor,
    @required this.scaffoldBackgroundColor,
    @required this.accentColor});

  ColorOptions.copyOf(ColorOptions other) {
    this.primaryColor = other.primaryColor;
    this.scaffoldBackgroundColor = other.scaffoldBackgroundColor;
    this.accentColor = other.accentColor;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'primaryColor': '${colorToJson(primaryColor)}',
      'scaffoldBackgroundColor': '${colorToJson(scaffoldBackgroundColor)}',
      'accentColor': '${colorToJson(accentColor)}'
    };
    return map;
  }

  ColorOptions.fromJson(Map<String, dynamic> json)
  : primaryColor = jsonToColor(json['primaryColor']),
  scaffoldBackgroundColor = jsonToColor(json['scaffoldBackgroundColor']),
  accentColor = jsonToColor(json['accentColor']);


  static String colorToJson(Color color) {
    DropdownMenuItem menuItemForColor =
        COLOR_DROPDOWN_MENU_ITEMS.firstWhere((item) => item.value == color);
    return (menuItemForColor.child as Text).data;
  }

  static Color jsonToColor(String json) {
    DropdownMenuItem menuItemForColor = COLOR_DROPDOWN_MENU_ITEMS
        .firstWhere((item) => (item.child as Text).data == json);
    return menuItemForColor.value;
  }
}

class GridOptions {
  int crossAxisCountPortrait;
  int crossAxisCountLandscape;
  double childAspectRatio;
  double padding;
  double spacing;

  GridOptions({
      @required this.crossAxisCountPortrait,
      @required this.crossAxisCountLandscape,
      @required this.childAspectRatio,
      @required this.padding,
      @required this.spacing});

  @override
  String toString() {
    return 'GridOptions{_crossAxisCountPortrait: $crossAxisCountPortrait, '
    '_crossAxisCountLandscape: $crossAxisCountLandscape, '
    '_childAspectRatio: $childAspectRatio, '
    '_padding: $padding, '
    '_spacing: $spacing}';
  }
}

class ThemeBLOC extends InheritedWidget {
  String _path;

  ThemeBLOC({Key key, @required Widget child})
  : assert(child != null),
  super(key: key, child: child) {
    getApplicationDocumentsDirectory()
        .then((directory) => _path = directory.path);
  }

  ColorOptions _colorOptions = ColorOptions(
      primaryColor: COLOR_NAVY_BLUE,
      scaffoldBackgroundColor: COLOR_LIGHT_BLUE,
      accentColor: COLOR_SAND);

  static ThemeBLOC of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ThemeBLOC) as ThemeBLOC;
  }

  ThemeData get startingThemeData {
    return createThemeDataFromColorOptions();
  }


  ThemeData createThemeDataFromColorOptions() {
    return ThemeData(
      primaryColor: _colorOptions.primaryColor,
      scaffoldBackgroundColor: _colorOptions.scaffoldBackgroundColor,
      accentColor: _colorOptions.accentColor);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  Stream<ThemeData> get themeStream => _themeSubject.stream;
  final _themeSubject = BehaviorSubject<ThemeData>();

  ColorOptions get colorOptions => _colorOptions;

  set colorOptions(ColorOptions value) {
    _colorOptions = value;
    _themeSubject.add(createThemeDataFromColorOptions());
  }

  List<String> get filenames {
    List<String>filenameList = [];
    Directory(_path).listSync().forEach((FileSystemEntity fse) {
      String path = fse.path;
      if (path.endsWith(".themeColor")) {
        int startIndex = path.lastIndexOf(Platform.pathSeparator) + 1;
        int endIndex = path.lastIndexOf(".themeColor");
        filenameList.add(path.substring(startIndex, endIndex));
      }
    });
    return filenameList;
  }

  open(String filename) {
    FileSystemEntity fse =
        Directory(_path).listSync().firstWhere((FileSystemEntity fse) {
          String path = fse.path;
          if (path.endsWith(".themeColor")) {
            int startIndex = path.lastIndexOf(Platform.pathSeparator) + 1;
            if (startIndex != -1) {
              int endIndex = path.lastIndexOf(".themeColor");
              if (endIndex != -1) {
                var pathFilename = path.substring(startIndex, endIndex);
                if (pathFilename == filename) {
                  return true;
                }
              }
            }
          }
          return false;
        });
        if (fse != null) {
          File("${fse.path}").readAsString().then((str) {
            ColorOptions newColorOptions = ColorOptions.fromJson(jsonDecode(str));
            this.colorOptions = newColorOptions;
          });
        }
    }

  saveAs(String filename) {
    String json = jsonEncode(_colorOptions.toJson());
    File("${_path}/${filename}.themeColor").writeAsString(json);
    }
  }
  class GridViewApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      ThemeBLOC bloc = ThemeBLOC.of(context);
      return StreamBuilder<ThemeData>(
        stream: bloc._themeSubject,
        initialData: bloc.startingThemeData,
        builder: (context, snapshot) {
          ThemeData themeData = snapshot.data;
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeData,
            home: HomeWidget(title: 'Flutter Demo Home Page'),
          );
        });
    }
  }

  class HomeWidget extends StatefulWidget {
    HomeWidget({Key key, this.title}) : super(key: key);
    final String title;

    @override
    _HomeWidgetState createState() => new _HomeWidgetState();
  }

  class _HomeWidgetState extends State<HomeWidget> {
  List<Widget> _kittenTiles = [];
  int _gridOptionsIndex = 0;
  List<GridOptions> _gridOptions = [
    GridOptions(
      crossAxisCountPortrait: 2,
      crossAxisCountLandscape: 3,
      childAspectRatio: 1.0,
      padding: 10.0,
      spacing: 10.0),
    GridOptions(
        crossAxisCountPortrait: 3,
        crossAxisCountLandscape: 4,
        childAspectRatio: 1.5,
        padding: 10.0,
        spacing: 10.0),
    GridOptions(
        crossAxisCountPortrait: 2,
        crossAxisCountLandscape: 3,
        childAspectRatio: 2.0,
        padding: 10.0,
        spacing: 30.0),
  ];

  _HomeWidgetState() : super() {
    for (int i = 200; i < 1000; i += 100) {
      String imageUrl = "http://placekitten.com/200/${i}";
      _kittenTiles.add(GridTile(
        header: GridTileBar(
          title:
          Text("Cats", style:  TextStyle(fontWeight: FontWeight.bold))),
        child: Image.network(imageUrl, fit: BoxFit.cover)));
    }
  }

  void _tryMoreGridOptions() {
    setState(() {
      _gridOptionsIndex++;
          if (_gridOptionsIndex >= (_gridOptions.length - 1)) {
            _gridOptionsIndex = 0;
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    GridOptions options = _gridOptions[_gridOptionsIndex];
    return Scaffold(
      appBar: AppBar(title: Text("GridView"), actions: [
        IconButton(
          icon: Icon(Icons.settings),
          tooltip: 'Color Options',
          onPressed: () => _showColorOptionsDialog()),
        IconButton(
          icon: Icon(Icons.folder_open),
          tooltip: 'Open',
          onPressed: () {
            List<String> names = ThemeBLOC.of(context).filenames;
            _showOpenDialog(context, names);
          }),
        IconButton(
          icon: Icon(Icons.settings),
          tooltip: 'Save',
          onPressed: () => _showSaveAsDialog(context))
      ]),
      body: OrientationBuilder(builder: (context, orientation){
        return GridView.count(
            crossAxisCount: (orientation == Orientation.portrait)
                ? options.crossAxisCountPortrait
                : options.crossAxisCountLandscape,
          childAspectRatio: options.childAspectRatio,
          padding: EdgeInsets.all(options.padding),
          mainAxisSpacing: options.spacing,
          crossAxisSpacing: options.spacing,
          children: _kittenTiles);
      }),
    );
  }

  void _showColorOptionsDialog() async {
    ColorOptions colorOptions = await showDialog<ColorOptions> (
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ColorDialogWidget(ThemeBLOC.of(context).colorOptions));
      });
    if (colorOptions != null) {
      ThemeBLOC.of(context).colorOptions = colorOptions;
    }
  }

  void _showOpenDialog(BuildContext context, List<String> name) async {
    List<SimpleDialogOption> chilredn = names.map((s) {
      return SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, s);
        },
        child: Text(s),
      );
    }).toList(growable: false);

    String name = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
       return SimpleDialog(title: const Text('Open'), children: chilredn);
      });

    if (name != null) {
      setState(() {
        ThemeBLOC.of(context).open(name);
      });
    }
  }

  void _showSaveAsDialog(BuildContext context) async {
    String name = await showDialog<String>(
      context: context
          builder: (BuildContext context) {
        return Dialog(child: SaveAsDialogWidget());
    });
    if (name != null) {
      ThemeBLOC.of(context).saveAs(name);
    }
  }




}