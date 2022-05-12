import 'package:flutter/material.dart';

import '../main.dart';
import '../model.dart';
import 'common_widget.dart';

// ボタン
class MyCalcButton extends MyTextButton {
  MyCalcButton( MyState state, String text, int width, int height, int fontSize, int fontColor, int backgroundColor, Function() onPressed, {Key? key} ) : super(
    state,
    key: key,
    width: width,
    height: height,
    color: backgroundColor,
    alpha: MyModel.app.imageFlag ? 0x7F : 0xFF,
    onPressed: onPressed,
    child: MyText( state, text, fontSize: fontSize, color: fontColor ),
  );
}

// 計算結果等の表示欄
class MyDisplay extends MyContainer {
  MyDisplay( MyState state, String text, int width, int height, int fontSize, FontStyle fontStyle, AlignmentGeometry alignment, {Key? key} ) : super(
    state,
    key: key,
    width: width,
    height: height,
    alignment: alignment,
    color: 0xE0E0E0,
    alpha: MyModel.app.imageFlag ? 0x7F : 0xFF,
    child: MyText( state, text, fontSize: fontSize, fontStyle: fontStyle, color: 0x000000 ),
  );
}
