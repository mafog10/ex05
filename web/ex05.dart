library ex05;

import 'dart:html';
import 'dart:async';
import 'dart:math';

part 'sierpinski_triangle.dart';

void main() {
  CanvasElement canvas = document.query('#canvas');
  SierpinskiTriangle triangle = new SierpinskiTriangle(canvas);
}

