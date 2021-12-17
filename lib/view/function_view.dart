import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../data.dart';
import '../data/calc_data.dart';
import '../service.dart';
import '../state/function_state.dart';
import '../widget/common_widget.dart';

Column functionView( MyFunctionState state ){
  double height = state.getContentHeight().toDouble() - 20 - 50 - 20;

  // 桁区切り
  String dispStr = state.dispStr;
  if (MyData.calc.separatorType == CalcData.separatorTypeDash) {
    dispStr = MyService.calc.sepString(dispStr, "'");
  } else if (MyData.calc.separatorType == CalcData.separatorTypeComma) {
    dispStr = MyService.calc.sepString(dispStr, ",");
  }

  return MyColumn( children: [
    InkWell(
      onTap: () { state.go('calc.option', state.routeName); },
      child: MyDisplay( state, state.dispAngle, 320, 20, 17, Alignment.topLeft ),
    ),
    InkWell(
      onTap: () { state.go('calc.option', state.routeName); },
      child: MyDisplay( state, dispStr, 320, 50, 29, Alignment.centerRight ),
    ),
    InkWell(
      onTap: () { state.go('calc.option', state.routeName); },
      child: MyDisplay( state, "M = ${state.dispMemory}", 320, 20, 17, Alignment.bottomLeft ),
    ),
    MyRow( children: [
      MyButton( state, "M+", 80, height * 3 ~/ 23, 25, 0x000000, 0xC0C0FF, state.onButtonMAdd ),
      MyButton( state, "M-", 80, height * 3 ~/ 23, 25, 0x000000, 0xC0C0FF, state.onButtonMSub ),
      MyButton( state, state.mrcButtonText, 80, height * 3 ~/ 23, 25, state.isMemoryRecalled() ? 0xFF8080 : 0x000000, 0xC0C0FF, state.onButtonMRC ),
      MyButton( state, "NUM", 80, height * 3 ~/ 23, 25, 0xFFFFFF, 0xFFA0A0, state.onButtonNumber )
    ] ),
    MyRow( children: [
      MyButton( state, "CE", 80, height * 4 ~/ 23, 32, state.isError() ? 0xFFFFFF : 0xFF8080, state.isError() ? 0xFFA0A0 : 0xFFFFFF, state.onButtonCE ),
      MyButton( state, "C", 80, height * 4 ~/ 23, 32, state.isError() ? 0xFFFFFF : 0xFF8080, state.isError() ? 0xFFA0A0 : 0xFFFFFF, state.onButtonC ),
      MyButton( state, state.angleButtonText, 80, height * 4 ~/ 23, 25, 0x000000, 0xFFFFFF, state.onButtonAngle ),
      MyButton( state, "√", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButtonSqrt )
    ] ),
    MyRow( children: [
      MyButton( state, "sin", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonSin ),
      MyButton( state, "cos", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonCos ),
      MyButton( state, "tan", 106, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonTan ),
    ] ),
    MyRow( children: [
      MyButton( state, "asin", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonArcSin ),
      MyButton( state, "acos", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonArcCos ),
      MyButton( state, "atan", 106, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonArcTan ),
    ] ),
    MyRow( children: [
      MyButton( state, "ln", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonLog ),
      MyButton( state, "log", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonLog10 ),
      MyButton( state, "sqr", 106, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonSqr ),
    ] ),
    MyRow( children: [
      MyButton( state, "exp", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonExp ),
      MyButton( state, "exp10", 107, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonExp10 ),
      MyButton( state, "int", 106, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonInt ),
    ] )
  ] );
}
