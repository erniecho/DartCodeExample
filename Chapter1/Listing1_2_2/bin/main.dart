import 'package:Listing1_2_2/Listing1_2_2.dart' as Listing1_2_2;

main(List<String> arguments) {
final bool nums = trueIfNull(1, 2);  //Stores "false" in dynamic variable nums.
final bool _strings = trueIfNull("Hello ", null); //Stores "true" in dynamic variable strings.
print("$nums"); //Outputs variables nums and strings to console.
print("$_strings");
}
  trueIfNull(int a , int b) { //Function takes two values.
    return a == null && b == null;
  }