import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../data.dart';
import '../data/calc_data.dart';
import '../service.dart';
import '../state/function_state.dart';
import '../widget/calc_widget.dart';
import '../widget/common_widget.dart';

Widget functionView( MyFunctionState state ){
  double height = state.getContentHeight().toDouble() - 20 - 50 - 20; // 計算結果等の表示欄の高さを引いた分

  // 桁区切り
  String dispStr = state.dispStr;
  if (MyData.calc.separatorType == CalcData.separatorTypeDash) {
    dispStr = MyService.calc.sepString(dispStr, "'");
  } else if (MyData.calc.separatorType == CalcData.separatorTypeComma) {
    dispStr = MyService.calc.sepString(dispStr, ",");
  }

  return MyColumn( children: [
    InkWell(
      onTap: () { state.go('/option', state.routeName); },
      child: MyDisplay( state, state.dispAngle, 320, 20, 17, FontStyle.normal, Alignment.topLeft ),
    ),
    InkWell(
      onTap: () { state.go('/option', state.routeName); },
      child: MyDisplay( state, dispStr, 320, 50, 29, MyData.calc.italicFlag ? FontStyle.italic : FontStyle.normal, Alignment.centerRight ),
    ),
    InkWell(
      onTap: () { state.go('/option', state.routeName); },
      child: MyDisplay( state, "M = ${state.dispMemory}", 320, 20, 17, FontStyle.normal, Alignment.bottomLeft ),
    ),
    MyRow( children: [
      MyCalcButton( state, "M+", 80, height * 3 ~/ 23, 25, 0x000000, 0xC0C0FF, state.onButtonMAdd ),
      MyCalcButton( state, "M-", 80, height * 3 ~/ 23, 25, 0x000000, 0xC0C0FF, state.onButtonMSub ),
      MyCalcButton( state, state.mrcButtonText, 80, height * 3 ~/ 23, 25, MyData.calc.memoryRecalled ? 0xFF8080 : 0x000000, 0xC0C0FF, state.onButtonMRC ),
      MyCalcButton( state, "NUM", 80, height * 3 ~/ 23, 25, 0xFFFFFF, 0xFFA0A0, state.onButtonNumber )
    ] ),
    MyRow( children: [
      MyCalcButton( state, "CE", 80, height * 4 ~/ 23, 32, MyData.calc.errorFlag ? 0xFFFFFF : 0xFF8080, MyData.calc.errorFlag ? 0xFFA0A0 : 0xFFFFFF, state.onButtonCE ),
      MyCalcButton( state, "C", 80, height * 4 ~/ 23, 32, MyData.calc.errorFlag ? 0xFFFFFF : 0xFF8080, MyData.calc.errorFlag ? 0xFFA0A0 : 0xFFFFFF, state.onButtonC ),
      MyCalcButton( state, state.angleButtonText, 80, height * 4 ~/ 23, 25, 0x000000, 0xFFFFFF, state.onButtonAngle ),
      MyCalcButton( state, "√", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButtonSqrt )
    ] ),
    MyRow( children: [
      MyCalcButton( state, "sin", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonSin ),
      MyCalcButton( state, "cos", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonCos ),
      MyCalcButton( state, "tan", 106, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonTan ),
    ] ),
    MyRow( children: [
      MyCalcButton( state, "asin", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonArcSin ),
      MyCalcButton( state, "acos", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonArcCos ),
      MyCalcButton( state, "atan", 106, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonArcTan ),
    ] ),
    MyRow( children: [
      MyCalcButton( state, "ln", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonLog ),
      MyCalcButton( state, "log", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonLog10 ),
      MyCalcButton( state, "sqr", 106, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonSqr ),
    ] ),
    MyRow( children: [
      MyCalcButton( state, "exp", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonExp ),
      MyCalcButton( state, "exp10", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonExp10 ),
      MyCalcButton( state, "int", 106, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonInt ),
    ] )
  ] );
}
