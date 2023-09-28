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

    Widget child = MyColumn( children: [
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
        MyCalcButtonRBShadow( state, "M+", 80, buttonHeight1, 25, 0x000000, 0xC0C0FF, state.onButtonMAdd ),
        MyCalcButtonRBShadow( state, "M-", 80, buttonHeight1, 25, 0x000000, 0xC0C0FF, state.onButtonMSub ),
        MyCalcButtonRBShadow( state, state.mrcButtonText, 80, buttonHeight1, 25, MyModel.calc.memoryRecalled ? 0xFF8080 : 0x000000, 0xC0C0FF, state.onButtonMRC ),
        MyCalcButtonLTShadow( state, "NUM", 80, buttonHeight1, 25, 0xFFFFFF, 0xFFA0A0, state.onButtonNumber )
      ] ),
      MyRow( children: [
        MyModel.calc.errorFlag ? MyCalcButtonLTShadow( state, "CE", 80, buttonHeight2, 32, 0xFFFFFF, 0xFFA0A0, state.onButtonCE ) : MyCalcButtonRBShadow( state, "CE", 80, buttonHeight2, 32, 0xFF8080, 0xFFFFFF, state.onButtonCE ),
        MyModel.calc.errorFlag ? MyCalcButtonLTShadow( state, "C", 80, buttonHeight2, 32, 0xFFFFFF, 0xFFA0A0, state.onButtonC ) : MyCalcButtonRBShadow( state, "C", 80, buttonHeight2, 32, 0xFF8080, 0xFFFFFF, state.onButtonC ),
        MyCalcButtonRBShadow( state, state.angleButtonText, 80, buttonHeight2, 25, 0x000000, 0xFFFFFF, state.onButtonAngle ),
        MyCalcButtonRBShadow( state, "√", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButtonSqrt )
      ] ),
      MyRow( children: [
        MyCalcButtonRBShadow( state, "sin", 107, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonSin ),
        MyCalcButtonRBShadow( state, "cos", 107, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonCos ),
        MyCalcButtonRBShadow( state, "tan", 106, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonTan ),
      ] ),
      MyRow( children: [
        MyCalcButtonRBShadow( state, "asin", 107, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonArcSin ),
        MyCalcButtonRBShadow( state, "acos", 107, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonArcCos ),
        MyCalcButtonRBShadow( state, "atan", 106, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonArcTan ),
      ] ),
      MyRow( children: [
        MyCalcButtonRBShadow( state, "ln", 107, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonLog ),
        MyCalcButtonRBShadow( state, "log", 107, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonLog10 ),
        MyCalcButtonRBShadow( state, "sqr", 106, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonSqr ),
      ] ),
      MyRow( children: [
        MyCalcButtonRBShadow( state, "exp", 107, buttonHeight3, 32, 0x000000, 0xFFFFFF, state.onButtonExp ),
        MyCalcButtonRBShadow( state, "exp10", 107, buttonHeight3, 32, 0x000000, 0xFFFFFF, state.onButtonExp10 ),
        MyCalcButtonRBShadow( state, "int", 106, buttonHeight3, 32, 0x000000, 0xFFFFFF, state.onButtonInt ),
      ] )
    ] );

    if( MyModel.app.imageFlag && MyModel.app.image != null ) {
      return Container(
          width: state.contentWidth,
          height: state.contentHeight,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: MyModel.app.image!,
                  fit: BoxFit.cover,
                  alignment: Alignment( MyModel.app.imageX, MyModel.app.imageY )
              )
          ),
          child: child
      );
    }
    return child;
  }
}
