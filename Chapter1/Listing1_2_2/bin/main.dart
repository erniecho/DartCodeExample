import 'package:Listing1_2_2/Listing1_2_2.dart' as Listing1_2_2;

main(List<String> arguments) {
final bool nums = trueIfNull(1, 2);
final bool _strings = trueIfNull("Hello", null);
print("$nums");
print("$_strings");
}
  trueIfNull(int a , int b) {
    return a == null && b == null;
  }