import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../data.dart';
import '../data/calc_data.dart';
import '../service.dart';
import '../state/number_state.dart';
import '../widget/common_widget.dart';

Column numberView( MyNumberState state ){
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
      onTap: () { state.go('calc.option', state.routeName); },
      child: MyDisplay( state, state.dispLog, 320, 20, 17, FontStyle.normal, Alignment.topLeft ),
    ),
    InkWell(
      onTap: () { state.go('calc.option', state.routeName); },
      child: MyDisplay( state, dispStr, 320, 50, 29, MyData.calc.italicFlag ? FontStyle.italic : FontStyle.normal, Alignment.centerRight ),
    ),
    InkWell(
      onTap: () { state.go('calc.option', state.routeName); },
      child: MyDisplay( state, "A = ${state.dispAnswer}  M = ${state.dispMemory}", 320, 20, 17, FontStyle.normal, Alignment.bottomLeft ),
    ),
    MyRow( children: [
      MyButton( state, "M+", 80, height * 3 ~/ 23, 25, 0x000000, 0xC0C0FF, state.onButtonMAdd ),
      MyButton( state, "M-", 80, height * 3 ~/ 23, 25, 0x000000, 0xC0C0FF, state.onButtonMSub ),
      MyButton( state, state.mrcButtonText, 80, height * 3 ~/ 23, 25, state.isMemoryRecalled() ? 0xFF8080 : 0x000000, 0xC0C0FF, state.onButtonMRC ),
      MyButton( state, "FNC", 80, height * 3 ~/ 23, 25, 0xFFFFFF, 0xFFA0A0, state.onButtonFunction )
    ] ),
    MyRow( children: [
      MyButton( state, "CE", 80, height * 4 ~/ 23, 32, state.isError() ? 0xFFFFFF : 0xFF8080, state.isError() ? 0xFFA0A0 : 0xFFFFFF, state.onButtonCE ),
      MyButton( state, "C", 80, height * 4 ~/ 23, 32, state.isError() ? 0xFFFFFF : 0xFF8080, state.isError() ? 0xFFA0A0 : 0xFFFFFF, state.onButtonC ),
      MyButton( state, "DEL", 80, height * 4 ~/ 23, 32, 0x000000, 0xFFFFFF, state.onButtonDEL ),
      MyButton( state, "÷", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButtonDiv )
    ] ),
    MyRow( children: [
      MyButton( state, "7", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButton7 ),
      MyButton( state, "8", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButton8 ),
      MyButton( state, "9", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButton9 ),
      MyButton( state, "×", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButtonMul )
    ] ),
    MyRow( children: [
      MyButton( state, "4", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButton4 ),
      MyButton( state, "5", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButton5 ),
      MyButton( state, "6", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButton6 ),
      MyButton( state, "-", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButtonSub )
    ] ),
    MyRow( children: [
      MyButton( state, "1", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButton1 ),
      MyButton( state, "2", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButton2 ),
      MyButton( state, "3", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButton3 ),
      MyButton( state, "+", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButtonAdd )
    ] ),
    MyRow( children: [
      MyButton( state, "+/-", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButtonNegative ),
      MyButton( state, "0", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButton0 ),
      MyButton( state, ".", 80, height * 4 ~/ 23, 40, 0x000000, 0xFFFFFF, state.onButtonPoint ),
      MyButton( state, "=", 80, height * 4 ~/ 23, 40, 0xFF8080, 0xFFFFFF, state.onButtonEqual )
    ] )
  ] );
}
