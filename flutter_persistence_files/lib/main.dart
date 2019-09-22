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


}

