import 'dart:html';
import 'dart:math' as math;

void main() {
  Sunflower();
}

class Sunflower {
  static const orange = 'orange';
  static const seedRadius = 2;
  static const scaleFactor = 4;
  static const tau = math.pi * 2;
  static const maxD = 300;


  static final phi = (math.sqrt(5) + 1) / 2;
  static final center = maxD / 2;

  final context = (querySelector('#canvas') as )
}