import 'package:flutter/material.dart';

import '../main.dart';
import '../model.dart';
import 'common_widget.dart';

// 影
class MyLTShadow extends Shadow {
  MyLTShadow() : super(
      color: Color( 0xFF404040 ),
      offset: Offset( -1.0, -1.0 ), // 左上方向
      blurRadius: 0.0
  );
}
class MyRBShadow extends Shadow {
  MyRBShadow() : super(
      color: Color( 0xFFE0E0E0 ),
      offset: Offset( 1.0, 1.0 ), // 右下方向
      blurRadius: 0.0
  );
}

// ボタン
class _MyCalcButton extends MyTextButton {
  _MyCalcButton( MyState state, String text, int width, int height, int fontSize, int fontColor, int backgroundColor, Function() onPressed, {Key? key, List<Shadow>? shadows} ) : super(
    state,
    key: key,
    width: width,
    height: height,
    color: backgroundColor,
    alpha: MyModel.app.imageFlag ? 0x7F : 0xFF,
    onPressed: onPressed,
    child: MyText( state, text, fontSize: fontSize, color: fontColor, shadows: shadows, ),
  );
}
class MyCalcButtonLTShadow extends _MyCalcButton {
  MyCalcButtonLTShadow( MyState state, String text, int width, int height, int fontSize, int fontColor, int backgroundColor, Function() onPressed, {Key? key} ) : super(
    state, text, width, height, fontSize, fontColor, backgroundColor, onPressed, key: key,
    shadows: MyModel.app.imageFlag ? [MyLTShadow()] : null,
  );
}
class MyCalcButtonRBShadow extends _MyCalcButton {
  MyCalcButtonRBShadow( MyState state, String text, int width, int height, int fontSize, int fontColor, int backgroundColor, Function() onPressed, {Key? key} ) : super(
    state, text, width, height, fontSize, fontColor, backgroundColor, onPressed, key: key,
    shadows: MyModel.app.imageFlag ? [MyRBShadow()] : null,
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
    child: MyText(
      state, text, fontSize: fontSize, fontStyle: fontStyle, color: 0x000000,
      shadows: MyModel.app.imageFlag ? [MyRBShadow()] : null,
    ),
  );
}

// テキスト
class MyTextShadow extends MyText {
  MyTextShadow( MyState state, String text, {
    Key? key,
    required int color,
    required int fontSize,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  } ) : super(
    state, text,
    key: key,
    color: color,
    fontSize: fontSize,
    fontStyle: fontStyle,
    shadows: MyModel.app.imageFlag ? [MyRBShadow()] : null,
    decoration: decoration,
    strutStyle: strutStyle,
    textAlign: textAlign,
    textDirection: textDirection,
    locale: locale,
    softWrap: softWrap,
    overflow: overflow,
    maxLines: maxLines,
    semanticsLabel: semanticsLabel,
    textWidthBasis: textWidthBasis,
    textHeightBehavior: textHeightBehavior,
  );
}
