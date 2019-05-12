import 'package:Listing1_2/Listing1_2.dart' as Listing1_2;


class Greeter {
  var greeting; //public property
  var _name; // underscore means it's private property denoted by _

    sayHello() {
    return "$greeting ${this.name}";
  }
 get name => _name; //Getter proptery in dart.
 set name(value) => _name = value; //Set Property in dart.
}


main(List<String> arguments) {
var greeter = new Greeter(); //Create a object from the Greeter class.
greeter.greeting = "Hello"; //Assigns values to fields and settes with same syntax.
greeter.name = "World";
print(greeter.sayHello());
}
