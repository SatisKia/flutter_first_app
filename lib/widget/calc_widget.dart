import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../main.dart';
import '../utility.dart';

// ボタン
class MyCalcButton extends Container {
  MyCalcButton( MyState state, String text, int width, int height, int fontSize, int fontColor, int backgroundColor, Function() onPressed, {Key? key} ) : super(
    key: key,
    width: state.size( width ),
    height: state.size( height ),
    color: MyColor( backgroundColor ),
    child: TextButton( key: null, onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: state.size( fontSize ),
          color: MyColor( fontColor ),
          fontWeight: FontWeight.w200,
        ),
      ),
    ),
  );
}

// 計算結果等の表示欄
class MyDisplay extends Container {
  MyDisplay( MyState state, String text, int width, int height, int fontSize, FontStyle fontStyle, AlignmentGeometry alignment, {Key? key} ) : super(
    key: key,
    width: state.size( width ),
    height: state.size( height ),
    alignment: alignment,
    color: MyColor( 0xE0E0E0 ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: state.size( fontSize ),
          color: MyColor( 0x000000 ),
          fontWeight: FontWeight.w200,
          fontStyle: fontStyle
      ),
    ),
  );
}
