
class Person {
  final String name;
  final String addressLine1;
  final String addressCity;
  final String addressState;
  final List<Person> children;

  const Person(this.name, this.addressLine1, this.addressCity, this.addressState
      ,this.children);

  Map<String, dynamic> toJson(){
    var map = {
      'name': name,
      'addr': addressLine1,
      'city': addressCity,
      'state' : addressState,
      'children': children
    };
    return map;
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw FormatException("Null Json.");
    }

    List<dynamic> decodedChildren = json['children'];
    List<Person> children = [];
    decodedChildren.forEach((decodedChildren) {
      children.add(Person.fromJson(decodedChildren));
    });

    return Person(
    json['name'],json['add1'],json['city'],json['state'],children);
  }
}