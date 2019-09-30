import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(ThemeBLOC(child: new GridViewApp()));

const COLOR_COFFEE = Color.fromARGB(0xFF, 112, 80, 80);
const DARK_BROWN = Color.fromARGB(0xFF, 59, 20, 18);
const COLOR_GREY = Color.fromARGB(0xFF, 68, 68, 68);
const COLOR_LIGHT_BLUE = Color.fromARGB(0xFF, 112, 207, 221);
const COLOR_MAROON = Color.fromARGB(0xFF, 86, 18, 16);
const COLOR_NAVY_BLUE = Color.fromARGB(0xFF, 15, 32, 67);
const COLOR_ORANGE = Color.fromARGB(0xFF, 240, 146, 34);
const COLOR_SAND = Color.fromARGB(0xFF, 213, 184, 88);
const COLOR_YELLOW = Color.fromARGB(0xFF, 246, 236, 32);

const COLOR_DROPDOWN_MENU_ITEMS = [
  DropdownMenuItem(value: COLOR_COFFEE, child: const Text("Coffee"),),
  DropdownMenuItem(value: DARK_BROWN, child: const Text("Dark Brown"),),
  DropdownMenuItem(value: COLOR_GREY, child: const Text("Grey"),),
  DropdownMenuItem(value: COLOR_LIGHT_BLUE, child: const Text("Light Blue"),),
  DropdownMenuItem(value: COLOR_MAROON, child: const Text("Maroon"),),
  DropdownMenuItem(value: COLOR_ORANGE, child: const Text("Orange"),),
  DropdownMenuItem(value: COLOR_SAND, child: const Text("Sand"),),
  DropdownMenuItem(value: COLOR_YELLOW, child: const Text("Yellow"),),
];

class ColorOption {
  Color primaryColor;
  Color scaffoldBackgroundColor;
  Color accentColor;

  ColorOption({@required this.primaryColor,@required this.scaffoldBackgroundColor,
  @required this.accentColor});

  ColorOption.copyOf(ColorOption other) {
    this.primaryColor = other.primaryColor;
    this.scaffoldBackgroundColor = other.scaffoldBackgroundColor;
    this.accentColor = other.accentColor;
  }

  Map<String, dynamic>toJson() {
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
    return(menuItemForColor.child as Text).data;
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

class ThemeBLOC extends inheritedWidget {
  SharedPreferences _prefs;

  ThemeBLOC({Key key, @required Widget child})
  : assert(child != null),
  super(key: key, child: child) {
    SharedPreferences.getInstance().then((prefs) => _prefs = prefs);
  }

  ColorOption _colorOption = ColorOption(
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
      primaryColor: _colorOption.primaryColor,
      scaffoldBackgroundColor:  _colorOption.scaffoldBackgroundColor,
      accentColor: _colorOption.accentColor);
  }

  @override
  bool updateShouldNotify(covariant inheritedWidget oldWidget) {
    return false;
  }

  Stream<ThemeData> get themeStream =>_themeSubject.stream;
  final _themeSubject = BehaviorSubject<ThemeData>();

  ColorOption get colorOptions => _colorOption;

  set colorOptions(ColorOption value) {
    _colorOption = value;
    _themeSubject.add(createThemeDataFromColorOptions());
  }


}


