import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as HTTP;
import 'package:http/http.dart';


void main() => runApp(MyApp());

class Employee {
  String id;
  String employeeName;
  String employeeSalary;
  String employeeAge;
  String profileImage;

  Employee(this.id, this.employeeName, this.employeeSalary, this.employeeAge,
      this.profileImage);


  Employee.isEmpty() {
    id = "";
    employeeName = "";
    employeeSalary = "";
    employeeAge = "";
    profileImage = "";
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw FormatException("Null JSON");
    }
    return Employee(json['id'],json['employee_name'],json['employee_salary'],
    json['employee_age'],json['profile_image']);
  }

  Map<String, dynamic> toJson() {
    var map = {
      'name': employeeName,
      'salary': employeeSalary,
      'age': employeeAge
    };
    if (id.isNotEmpty) {
      map['id'] = id;
    }
    if (profileImage.isNotEmpty) {
      map['profileImage'] = profileImage;
    }
    return map;
}

get hasEmptyId {
    return id.isEmpty;
}
}


class PleaseWaitWidget extends StatelessWidget {
  PleaseWaitWidget({Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}


class ApiWidget extends InheritedWidget{
  static final String _BASE_URL = "http://dummy.restapiexample.com/api/v1";
      static const _TIMEOUT = Duration(seconds: 10);

      ApiWidget({
        Key key,
        @required Widget child,
      }) : assert(child != null),
  super(key: key, child: child);


      static ApiWidget of(BuildContext context) {
       return context.inheritFromWidgetOfExactType(ApiWidget) as ApiWidget;
      }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  Future<List<Employee>>loadAndParseEmployee() async {
    var url = '${_BASE_URL}/employees';
    final responese = await HTTP.get(url).timeout(_TIMEOUT);
    if (responese.statusCode == 200) {
      final parsed = json.decode(responese.body).cast<Map<String, dynamic>>();
      var list =
          parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
      return list;
    } else {
      badStatusCode(responese);
    }
  }

  Future<Employee> loadEmployee(String id) async {
        var url = '${_BASE_URL}/employee/${id}';
        final response = await HTTP.get(url).timeout(_TIMEOUT);
        if (response.statusCode == 200) {
          final parsed = json.decode(response.body);
          return Employee.fromJson(parsed);
        } else {
          badStatusCode(response);
        }
  }


}




