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

  Future<List<Employee>>loadAndParseEmployees() async {
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

  Future<dynamic> saveEmployee(Employee employee) async {
        bool isUpdate = employee.id.isNotEmpty;
        final uri = _BASE_URL + (isUpdate ? '/update/${employee.id}' : '/create');
        final responese = isUpdate
        ? await HTTP.put(url, body: json.encode(employee)).timeout(_TIMEOUT)
            : await HTTP.post(uri, body: json.encode(employee)).timeout(_TIMEOUT);
        if (responese.statusCode == 200) {
          return json.decode(responese.body);
        } else {
          badStatusCode(responese);
        }
  }

  Future<dynamic> deleteEmployee(String id) async {
    final uri = '${_BASE_URL}/delete/${id}';
    final response = await HTTP.delete(uri).timeout(_TIMEOUT);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      badStatusCode(response);
    }
  }


  badStatusCode(Response response){
      debugPrint("Bad status code ${response.statusCode} returned from server.");
      debugPrint("Response body ${response.body} returned from server.");
      throw Exception(
      'Bad status code ${response.statusCode} returned from server.');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ApiWidget(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new EmployeeListWidget(),),);
  }
}

class EmployeeListWidget extends StatefulWidget {
  @override
  _EmployeeListWidgetState createState() => new _EmployeeListWidgetState();
}


class _EmployeeListWidget extends State<EmployeeListWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PleaseWaitWidget _pleaseWaitWidget =
      PleaseWaitWidget(key: ObjectKey("pleasewaitWidget"));

  bool _refresh = true;
  List<Employee> _employees;
  bool _pleaseWait = false;

  _showSnackBar(String content, {bool error = false}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content:
      Text('${error ? "An unecpected error occurred: ": ""}${content}'),
    ));
  }

  _showPleaseWait(bool b) {
    setState(() {
      _pleaseWait = b;
    });
  }

  _navigateToEmployee(BuildContext context, String employeeId) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmployeeDetailWidget(employeeId)),
    ).then((result) {
      if ((result != null) && (result is bool) && (result == true)){
        _showSnackBar('Employee saved.');
        _refreshEmployees();
      }
    });
  }

  _deleteEmployee(BuildContext context, Employee employee) async {
    _showDeleteConfirmDialog(employee).then((result) {
      if ((result != null) && (result is bool) && (result == true)) {
        _showPleaseWait(true);
        try {
          ApiWidget.of(context).deleteEmployee(employee.id).then((employee) {
            _showPleaseWait(false);
            _showSnackBar('Employee deleted');
            _refreshEmployees();
          }).catchError((error) {
            _showPleaseWait(false);
            _showSnackBar(error.toString(), error: true);
          });
        } catch (e) {
          _showPleaseWait(false);
          _showSnackBar(e.toString(), error: true);
        }
      }
    });
  }


  Future<bool> _showDeleteConfirmDialog(Employee employee) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Employee'),
          content: Text(
            'Are you sure you want to delete ${employee.employeeName}?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Yes'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            )
          ],
        );
      });
  }

  _refreshEmployees() {
    setState(() {
      _refresh = true;
    });
  }


  _loadEmployees(BuildContext context) {
    _showPleaseWait(true);
    try {
      ApiWidget.of(context).loadAndParseEmployees().then((employees)  {
        employees.sort((a,b) => a.employeeName
        .toLowerCase()
        .compareTo(b.employeeName.toLowerCase()));
        setState(() {
          _employees = employees;
        });
          _showPleaseWait(false);
      }).catchError((error) {
        _showPleaseWait(false);
        _showSnackBar(error.toString(), error: true);
      });
    } catch (e) {
      _showPleaseWait(false);
      _showSnackBar(e.toString(), error: true);
    }
  }


}

