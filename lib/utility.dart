import 'dart:ui';

class MyColor extends Color {
  MyColor( int rgbColor, { int alpha = 0xFF } ) : super( (alpha << 24) | rgbColor );
}
