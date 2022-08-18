import 'package:flutter/material.dart';

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
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment hAlign = hAlignLeft, // ColumnのデフォルトはhAlignCenter
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    List<Widget> children = const <Widget>[],
  } ) : super(
    key: key,
    mainAxisAlignment: vAlign,
    mainAxisSize: mainAxisSize,
    crossAxisAlignment: hAlign,
    textDirection: textDirection,
    verticalDirection: verticalDirection,
    textBaseline: textBaseline,
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
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment vAlign = vAlignTop, // RowのデフォルトはvAlignCenter
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    List<Widget> children = const <Widget>[],
  } ) : super(
    key: key,
    mainAxisAlignment: hAlign,
    mainAxisSize: mainAxisSize,
    crossAxisAlignment: vAlign,
    textDirection: textDirection,
    verticalDirection: verticalDirection,
    textBaseline: textBaseline,
    children: children,
  );
}

class MyContainer extends Container {
  MyContainer( MyState state, {
    Key? key,
    AlignmentGeometry alignment = Alignment.topLeft,
    EdgeInsetsGeometry? padding,
    int color = 0xFFFFFF,
    int alpha = 0xFF,
//    Decoration? decoration,
//    Decoration? foregroundDecoration,
    required int width,
    required int height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    Widget? child,
    Clip clipBehavior = Clip.none,
  } ) : super(
    key: key,
    alignment: alignment,
    padding: padding,
    color: MyColor( color, alpha: alpha ),
//    decoration: decoration,
//    foregroundDecoration: foregroundDecoration,
    width: state.size( width ),
    height: state.size( height ),
    constraints: constraints,
    margin: margin,
    transform: transform,
    transformAlignment: transformAlignment,
    child: child,
    clipBehavior: clipBehavior,
  );
}

class MySizedBox extends SizedBox {
  MySizedBox( MyState state, {
    Key? key,
    required int width,
    required int height,
    Widget? child,
  } ) : super(
    key: key,
    width: state.size( width ),
    height: state.size( height ),
    child: child,
  );
}

// 周囲の余白
class MyPadding extends Padding {
  MyPadding( MyState state, {
    Key? key,
    int left = 0,
    int top = 0,
    int right = 0,
    int bottom = 0,
    Widget? child
  } ) : super(
      key: key,
      padding: EdgeInsets.only(
        left: state.size( left ),
        top: state.size( top ),
        right: state.size( right ),
        bottom: state.size( bottom ),
      ),
      child: child
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

class MyText extends Text {
  MyText( MyState state, String text, {
    Key? key,
    required int color,
    required int fontSize,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
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
    text,
    key: key,
    style: TextStyle(
      color: MyColor( color ),
      fontSize: state.size( fontSize ),
      fontWeight: FontWeight.w200,
      fontStyle: (fontStyle == null) ? FontStyle.normal : fontStyle,
      height: 1.0,
      shadows: shadows,
      decoration: decoration,
    ),
    strutStyle: strutStyle,
    textAlign: (textAlign == null) ? TextAlign.left : textAlign,
    textDirection: textDirection,
    locale: locale,
    softWrap: softWrap,
    overflow: overflow,
    textScaleFactor: 1.0,
    maxLines: maxLines,
    semanticsLabel: semanticsLabel,
    textWidthBasis: textWidthBasis,
    textHeightBehavior: textHeightBehavior,
  );
}

class MyTextButton extends Container {
  MyTextButton( MyState state, {
    Key? key,
    required int width,
    required int height,
    int color = 0xFFFFFF,
    int alpha = 0xFF,
    void Function()? onPressed,
    void Function()? onLongPress,
    void Function(bool)? onHover,
    void Function(bool)? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    required Widget child,
  } ) : super(
      key: key,
      width: state.size( width ),
      height: state.size( height ),
      color: MyColor( color, alpha: alpha ),
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        child: child,
      )
  );
}

class MyElevatedButton extends SizedBox {
  MyElevatedButton( MyState state, {
    Key? key,
    required int width,
    required int height,
    required int color,
    void Function()? onPressed,
    void Function()? onLongPress,
    void Function(bool)? onHover,
    void Function(bool)? onFocusChange,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    required Widget child,
  } ) : super(
      key: key,
      width: state.size( width ),
      height: state.size( height ),
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: ElevatedButton.styleFrom(
          primary: MyColor( color ),
          padding: EdgeInsets.zero,
        ),
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        child: child,
      )
  );
}
