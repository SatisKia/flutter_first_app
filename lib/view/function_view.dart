import 'package:flutter/material.dart';

import '../main.dart';
import '../model.dart';
import '../model/calc_model.dart';
import '../service.dart';
import '../view_model/function_view_model.dart';
import '../view_model/option_view_model.dart';
import '../widget/calc_widget.dart';
import '../widget/common_widget.dart';

class FunctionView extends MyView {
  @override
  Widget build( MyState state ){
    state as MyFunctionState;

    int height = state.getContentHeight() - 20 - 50 - 20; // 計算結果等の表示欄の高さを引いた分
    int buttonHeight1 = height * 3 ~/ 23;
    int buttonHeight2 = height * 4 ~/ 23;
    int remainder = height - buttonHeight1 - buttonHeight2 * 5;
    int buttonHeight3 = buttonHeight2 + remainder;

    // 桁区切り
    String dispStr = state.dispStr;
    if (MyModel.calc.separatorType == CalcModel.separatorTypeDash) {
      dispStr = MyService.calc.sepString(dispStr, "'");
    } else if (MyModel.calc.separatorType == CalcModel.separatorTypeComma) {
      dispStr = MyService.calc.sepString(dispStr, ",");
    }

    return MyColumn( children: [
      InkWell(
        onTap: () {
          MyOptionArguments arguments = MyOptionArguments();
          arguments.returnRoute = state.routeName;
          state.go('/option', arguments: arguments);
        },
        child: MyDisplay( state, state.dispAngle, 320, 20, 17, FontStyle.normal, Alignment.topLeft ),
      ),
      InkWell(
        onTap: () {
          MyOptionArguments arguments = MyOptionArguments();
          arguments.returnRoute = state.routeName;
          state.go('/option', arguments: arguments);
        },
        child: MyDisplay( state, dispStr, 320, 50, 29, MyModel.calc.italicFlag ? FontStyle.italic : FontStyle.normal, Alignment.centerRight ),
      ),
      InkWell(
        onTap: () {
          MyOptionArguments arguments = MyOptionArguments();
          arguments.returnRoute = state.routeName;
          state.go('/option', arguments: arguments);
        },
        child: MyDisplay( state, "M = ${state.dispMemory}", 320, 20, 17, FontStyle.normal, Alignment.bottomLeft ),
      ),
      MyRow( children: [
        MyCalcButton( state, "M+", 80, buttonHeight1, 25, 0x000000, 0xC0C0FF, state.onButtonMAdd ),
        MyCalcButton( state, "M-", 80, buttonHeight1, 25, 0x000000, 0xC0C0FF, state.onButtonMSub ),
        MyCalcButton( state, state.mrcButtonText, 80, buttonHeight1, 25, MyModel.calc.memoryRecalled ? 0xFF8080 : 0x000000, 0xC0C0FF, state.onButtonMRC ),
        MyCalcButton( state, "NUM", 80, buttonHeight1, 25, 0xFFFFFF, 0xFFA0A0, state.onButtonNumber )
      ] ),
      MyRow( children: [
        MyCalcButton( state, "CE", 80, buttonHeight2, 32, MyModel.calc.errorFlag ? 0xFFFFFF : 0xFF8080, MyModel.calc.errorFlag ? 0xFFA0A0 : 0xFFFFFF, state.onButtonCE ),
        MyCalcButton( state, "C", 80, buttonHeight2, 32, MyModel.calc.errorFlag ? 0xFFFFFF : 0xFF8080, MyModel.calc.errorFlag ? 0xFFA0A0 : 0xFFFFFF, state.onButtonC ),
        MyCalcButton( state, state.angleButtonText, 80, buttonHeight2, 25, 0x000000, 0xFFFFFF, state.onButtonAngle ),
        MyCalcButton( state, "√", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButtonSqrt )
      ] ),
      MyRow( children: [
        MyCalcButton( state, "sin", 107, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonSin ),
        MyCalcButton( state, "cos", 107, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonCos ),
        MyCalcButton( state, "tan", 106, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonTan ),
      ] ),
      MyRow( children: [
        MyCalcButton( state, "asin", 107, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonArcSin ),
        MyCalcButton( state, "acos", 107, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonArcCos ),
        MyCalcButton( state, "atan", 106, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonArcTan ),
      ] ),
      MyRow( children: [
        MyCalcButton( state, "ln", 107, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonLog ),
        MyCalcButton( state, "log", 107, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonLog10 ),
        MyCalcButton( state, "sqr", 106, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonSqr ),
      ] ),
      MyRow( children: [
        MyCalcButton( state, "exp", 107, buttonHeight3, 32, 0x000000, 0xFFFFFF, state.onButtonExp ),
        MyCalcButton( state, "exp10", 107, buttonHeight3, 32, 0x000000, 0xFFFFFF, state.onButtonExp10 ),
        MyCalcButton( state, "int", 106, buttonHeight3, 32, 0x000000, 0xFFFFFF, state.onButtonInt ),
      ] )
    ] );
  }
}
