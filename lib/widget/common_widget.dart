import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../data.dart';
import '../main.dart';
import '../utility.dart';

// 縦方向のレイアウト
class MyColumn extends Column {
  // 縦方向アライメント
  static const MainAxisAlignment vAlignTop    = MainAxisAlignment.start;
  static const MainAxisAlignment vAlignCenter = MainAxisAlignment.center;
  static const MainAxisAlignment vAlignBottom = MainAxisAlignment.end;

  // 横方向アライメント
  static const CrossAxisAlignment hAlignLeft   = CrossAxisAlignment.start;
  static const CrossAxisAlignment hAlignCenter = CrossAxisAlignment.center;
  static const CrossAxisAlignment hAlignRight  = CrossAxisAlignment.end;

  MyColumn( {
    Key? key,
    MainAxisAlignment vAlign = vAlignTop,
    CrossAxisAlignment hAlign = hAlignLeft,
    required List<Widget> children,
  } ) : super(
    key: key,
    mainAxisAlignment: vAlign,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: hAlign,
    children: children,
  );
}

// 横方向のレイアウト
class MyRow extends Row {
  // 横方向アライメント
  static const MainAxisAlignment hAlignLeft   = MainAxisAlignment.start;
  static const MainAxisAlignment hAlignCenter = MainAxisAlignment.center;
  static const MainAxisAlignment hAlignRight  = MainAxisAlignment.end;

  // 縦方向アライメント
  static const CrossAxisAlignment vAlignTop    = CrossAxisAlignment.start;
  static const CrossAxisAlignment vAlignCenter = CrossAxisAlignment.center;
  static const CrossAxisAlignment vAlignBottom = CrossAxisAlignment.end;

  MyRow( {
    Key? key,
    MainAxisAlignment hAlign = hAlignLeft,
    CrossAxisAlignment vAlign = vAlignTop,
    required List<Widget> children,
  } ) : super(
    key: key,
    mainAxisAlignment: hAlign,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: vAlign,
    children: children,
  );
}

class MyContainer extends Container {
  MyContainer( MyState state, { Key? key, required int width, required int height, int color = 0xFFFFFF, required Widget child } ) : super(
    key: key,
    width: state.size( width ),
    height: state.size( height ),
    color: MyColor( color ),
    child: child,
  );
}

// 周囲の余白
class MyPadding extends Padding {
  MyPadding( MyState state, { Key? key, int left = 0, int top = 0, int right = 0, int bottom = 0, required Widget child } ) : super(
    key: key,
    padding: EdgeInsets.only(
      left: state.size( left ),
      top: state.size( top ),
      right: state.size( right ),
      bottom: state.size( bottom ),
    ),
    child: child,
  );
}

// 縦方向の余白
class MyColumnSpace extends SizedBox {
  MyColumnSpace( MyState state, int height, { Key? key } ) : super(
    key: key,
    height: state.size( height ),
  );
}

// 横方向の余白
class MyRowSpace extends SizedBox {
  MyRowSpace( MyState state, int width, { Key? key } ) : super(
    key: key,
    width: state.size( width ),
  );
}

// ボタン
class MyButton extends Container {
  MyButton( MyState state, String text, int width, int height, int fontSize, int fontColor, int backgroundColor, Function() onPressed, {Key? key} ) : super(
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
  MyDisplay( MyState state, String text, int width, int height, int fontSize, AlignmentGeometry alignment, {Key? key} ) : super(
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
          fontStyle: MyData.calc.italicFlag ? FontStyle.italic : FontStyle.normal
      ),
    ),
  );
}

class MyOptionText extends Text {
  MyOptionText( MyState state, String text, int fontSize, {Key? key} ) : super(
    text,
    key: key,
    style: TextStyle(
      fontSize: state.size( fontSize ),
      fontWeight: FontWeight.w200,
    ),
  );
}
