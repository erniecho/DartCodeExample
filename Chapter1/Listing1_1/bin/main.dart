import 'package:Listing1_1/Listing1_1.dart' as Listing1_1;

main(List<String> arguments) {
  var h = "Hello";
  final w = "World";
  print('$h $w'); //$ evaluates simple variables.
  print(r'$h $w'); // r prefix outputs literal string without interpolation.
  var helloWorld = "Hello" "World"; //Adjiacent string constants are concatenated.
  print(helloWorld);
  print("${helloWorld.toUpperCase()}");
  print("The answer is ${5 + 10}"); //Evaluated expressions need to be within braces ${}
  var multiline = """
  <div id = 'greating'>
  "Hello World"
  </div> """; //Multiline strings ignore first line break following """". Multiline strings can contain both single and double quotes.
  print(multiline);
  var o = new Object();
  print(o.toString()); //String interpolation automatically calls toString() function.
  print("$o");
}
