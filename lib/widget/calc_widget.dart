import 'package:flutter/material.dart';

import '../main.dart';
import '../utility.dart';
import 'common_widget.dart';

// ボタン
class MyCalcButton extends Container {
  MyCalcButton( MyState state, String text, int width, int height, int fontSize, int fontColor, int backgroundColor, Function() onPressed, {Key? key} ) : super(
    key: key,
    width: state.size( width ),
    height: state.size( height ),
    color: MyColor( backgroundColor ),
    child: TextButton( onPressed: onPressed,
      child: MyText( state, text, fontSize: fontSize, color: fontColor ),
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
    child: MyText( state, text, fontSize: fontSize, fontStyle: fontStyle, color: 0x000000 ),
  );
}
