import 'package:flutter/material.dart';

void main() => runApp(new MyApp());


class Order {
  DateTime _dt;
  String _description;
  double _total;

  Order(this._dt, this._description, this._total);

  double get total => _total;
  String get description => _description;
  DateTime get dt => _dt;
}

class Customer {
  String _name, _location;
  List<Order> _orders;

  Customer(this._name,this._location,this._orders);

  List<Order> get order => _orders;
  String get location => _location;
  String get name => _name;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatelessWidget {
  List<Customer> _customerList = [
    Customer("Bike Corp", "Atlanta", [
      Order(DateTime(2018,11,17),"Bicycle parts", 197.02),
      Order(DateTime(2018,12,1),"Bicycle parts", 107.45),
    ]),
    Customer("Trust Corp", "Atlanta", [
      Order(DateTime(2018,1,3),"Shredder parts", 97.02),
      Order(DateTime(2018,3,13),"Shredder parts", 7.45),
      Order(DateTime(2018,5,2),"Shredder parts", 7.45),
    ]),
    Customer("Jilly Boutique", "Birmingham", [
      Order(DateTime(2018,1,3),"Display unit", 97.01),
      Order(DateTime(2018,3,3),"Desk unit", 12.25),
      Order(DateTime(2018,3,21),"Clothes rack", 97.15),
    ]),
  ];

  HomePageWidget({Key key}) : super(key: key);

  void navigateToCustomer(BuildContext context, Customer customer) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerWidget(customer)),
    );
  }

  ListTile createCustomerWidget(BuildContext context, Customer customer) {
    return new ListTile(
      title: Text(customer.name),
      subtitle: Text(customer.location),
      trailing: Icon(Icons.arrow_right),
      onTap: () => navigateToCustomer(context, customer),);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> customerList = List.from(_customerList
    .map((Customer customer) => createCustomerWidget(context, customer)));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Customer'),
      ),
      body: new Center(
        child: new ListView(
          children: customerList,
        ),
      ),);
  }


}



