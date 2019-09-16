import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class Customer {
  String _firstName;
  String _lastName;
  bool _upButton;
  bool _downButton;

  Customer(this._firstName, this._lastName) {
    _downButton = false;
    _upButton = false;
  }

  String get name => _firstName + " " + _lastName;

  // ignore: unnecessary_getters_setters
  bool get upButton => _upButton;

  // ignore: unnecessary_getters_setters
  set upButton(bool value) {
    _upButton = value;
  }

  // ignore: unnecessary_getters_setters
  bool get downButton => _downButton;

  // ignore: unnecessary_getters_setters
  set downButton(bool value) {
    _downButton = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Customer &&
              runtimeType == other.runtimeType &&
              _firstName == other._firstName &&
              _lastName == other._lastName;

  @override
  int get hashCode =>
      _firstName.hashCode ^
      _lastName.hashCode;
}

class Bloc {
  List<Customer>  _customerList = [];

  Bloc() {
    _upActionStreamController.stream.listen(_handleUp);
    _downActionStreamController.stream.listen(_handleDown);
  }

  List<Customer> initCustomerList() {
    _customerList = [
      new Customer("Fred","Smith"),
      new Customer("Brian","Johnson"),
      new Customer("James","McGrit"),
      new Customer("John","Brown"),
    ];
    updateUpDownButton();
    return _customerList;
  }

  void dispose() {
    _upActionStreamController.close();
    _downActionStreamController.close();
  }

  void _handleUp(Customer customer) {
    swap(customer, true);
    updateUpDownButton();

    _customerListSubject.add(_customerList);
    _messageSubject.add(customer.name + "moved up");
  }

  void _handleDown(Customer customer) {
    swap(customer, false);
    updateUpDownButton();

    _customerListSubject.add(_customerList);
    _messageSubject.add(customer.name + "moved down");
  }

  void swap(Customer customer, bool up) {
    int idx = _customerList.indexOf(customer);
    _customerList.remove(customer);
    _customerList.insert(up ? idx - 1 : idx + 1 , customer);
  }

  void updateUpDownButton() {
    for (int idx= 0, lastIdx = _customerList.length - 1; idx <= lastIdx; idx++) {
      Customer customer = _customerList[idx];
      customer.upButton = (idx > 0);
      customer.downButton = (idx < lastIdx);
    }
  }




}
