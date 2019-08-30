import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class Order {
  int _id;
  DateTime _dt;
  String _description;
  double _total;

  Order(this._id, this._dt, this._description, this._total);
  Order.empty() : this(0, DateTime.now(), "" , 0.0);

  int get id => _id;
  double get total => _total;
  String get description => _description;
  DateTime get dt => _dt;
}

class Customer {
  int _id;
  String _name;
  String _location;
  List<Order> _orders;

  Customer(this._id,this._name,this._location,this._orders);
  Customer.empty() : this(0,"","",[]);

  int get id => _id;
  List<Order> get orders => _orders;
  String get location => _location;
  String get name => _name;
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new DataContainerWidget(child: HomeWidget()),
      onGenerateRoute: handleRoute);
  }
}

Route<dynamic> handleRoute(RouteSettings routeSettings){
  List<String> nameParm = routeSettings.name.split(":");
  assert(nameParm.length == 2);
  String name = nameParm[0];
  assert(name != null);
  int id = int.tryParse(nameParm[1]);
  assert(id != null);
  Widget childWidget;
  if (name == "/customer/") {
    childWidget = CustomerWidget(id);
  } else {
    childWidget = OrderWidget(id);
  }
  return MaterialPageRoute(
    builder: (context) => DataContainerWidget(child: childWidget));
}

class DataContainerWidget extends InheritedWidget {
  DataContainerWidget({
    Key key,
    @required Widget child,
}) : assert(child != null),
  super(key: key, child: child);

  List<Customer> _customerList = [
    Customer(1, "Bike Corp","Atlanta",[
      Order(11,DateTime(2018, 11, 17), "Bicycle parts", 197.02),
      Order(12,DateTime(2018, 12, 1), "Bicycle parts", 107.45),
    ]),
    Customer(2, "Trust Corp","Atlanta",[
      Order(11,DateTime(2017, 1, 3), "Shredder parts", 97.02),
      Order(12,DateTime(2018, 3, 13), "Shredder parts", 7.45),
      Order(12,DateTime(2018, 5, 2), "Shredder parts", 7.45),
    ]),
    Customer(3, "Jilly Boutique","Birmingham",[
      Order(11,DateTime(2017, 1, 3), "Display parts", 97.02),
      Order(12,DateTime(2018, 3, 3), "Desk units", 12.25),
      Order(12,DateTime(2018, 3, 21), "Clothes rack", 97.15),
    ]),
  ];

  List<Customer> get customerList => _customerList;

  Customer getCustomer(int id) {
    return _customerList.firstWhere(
            (customer) => customer.id == id,
    orElse: () => Customer.empty());
  }

  Customer getCustomerHasOrderId(int id) {
    return customerList.firstWhere(
        (customer) => customerHasOrderId(customer,id),
      orElse: () => Customer.empty());
  }

  Order getOrder(int id) {
    Customer customerThatOwnsOrder = getCustomerHasOrderId(id);
    return customerThatOwnsOrder.orders
        .firstWhere((order) => order.id == id, orElse: () => Order.empty());
  }

  bool customerHasOrderId(Customer customer, int id) {
    Order order = customer.orders
        .firstWhere((order) => order.id == id, orElse: () => Order.empty());
  }

  static DataContainerWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DataContainerWidget)
        as DataContainerWidget;
  }

  @override
  bool updateShouldNotify(covariant inheritedWidget oldWidget){
    return false;
  }
}

class HomeWidget extends StatelessWidget {
HomeWidget({Key key}) : super(key: key);

void navigateToCustomer(BuildContext context,Customer customer) {
  Navigator.pushNamed(context, '/customer/:${customer.id}');
}

ListTile createCustomerWidget(BuildContext context, Customer customer) {
return new ListTile(
  title: Text(customer.name),
  subtitle: Text(customer.location),
  trailing: Icon(Icons.arrow_right),
  onTap: () => navigateToCustomer(context, customer),
);
}

}