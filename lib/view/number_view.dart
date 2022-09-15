import 'package:flutter/material.dart';

import '../main.dart';
import '../model.dart';
import '../model/calc_model.dart';
import '../service.dart';
import '../view_model/number_view_model.dart';
import '../view_model/option_view_model.dart';
import '../widget/calc_widget.dart';
import '../widget/common_widget.dart';

class NumberView extends MyView {
  @override
  Widget build( MyState state ){
    state as MyNumberState;

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
        child: MyDisplay( state, state.dispLog, 320, 20, 17, FontStyle.normal, Alignment.topLeft ),
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
        child: MyDisplay( state, "A = ${state.dispAnswer}  M = ${state.dispMemory}", 320, 20, 17, FontStyle.normal, Alignment.bottomLeft ),
      ),
      MyRow( children: [
        MyCalcButtonRBShadow( state, "M+", 80, buttonHeight1, 25, 0x000000, 0xC0C0FF, state.onButtonMAdd ),
        MyCalcButtonRBShadow( state, "M-", 80, buttonHeight1, 25, 0x000000, 0xC0C0FF, state.onButtonMSub ),
        MyCalcButtonRBShadow( state, state.mrcButtonText, 80, buttonHeight1, 25, MyModel.calc.memoryRecalled ? 0xFF8080 : 0x000000, 0xC0C0FF, state.onButtonMRC ),
        MyCalcButtonLTShadow( state, "FNC", 80, buttonHeight1, 25, 0xFFFFFF, 0xFFA0A0, state.onButtonFunction )
      ] ),
      MyRow( children: [
        MyCalcButtonRBShadow( state, "CE", 80, buttonHeight2, 32, MyModel.calc.errorFlag ? 0xFFFFFF : 0xFF8080, MyModel.calc.errorFlag ? 0xFFA0A0 : 0xFFFFFF, state.onButtonCE ),
        MyCalcButtonRBShadow( state, "C", 80, buttonHeight2, 32, MyModel.calc.errorFlag ? 0xFFFFFF : 0xFF8080, MyModel.calc.errorFlag ? 0xFFA0A0 : 0xFFFFFF, state.onButtonC ),
        MyCalcButtonRBShadow( state, "DEL", 80, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonDEL ),
        MyCalcButtonRBShadow( state, "÷", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButtonDiv )
      ] ),
      MyRow( children: [
        MyCalcButtonRBShadow( state, "7", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton7 ),
        MyCalcButtonRBShadow( state, "8", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton8 ),
        MyCalcButtonRBShadow( state, "9", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton9 ),
        MyCalcButtonRBShadow( state, "×", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButtonMul )
      ] ),
      MyRow( children: [
        MyCalcButtonRBShadow( state, "4", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton4 ),
        MyCalcButtonRBShadow( state, "5", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton5 ),
        MyCalcButtonRBShadow( state, "6", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton6 ),
        MyCalcButtonRBShadow( state, "-", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButtonSub )
      ] ),
      MyRow( children: [
        MyCalcButtonRBShadow( state, "1", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton1 ),
        MyCalcButtonRBShadow( state, "2", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton2 ),
        MyCalcButtonRBShadow( state, "3", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton3 ),
        MyCalcButtonRBShadow( state, "+", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButtonAdd )
      ] ),
      MyRow( children: [
        MyCalcButtonRBShadow( state, "+/-", 80, buttonHeight3, 40, 0x000000, 0xFFFFFF, state.onButtonNegative ),
        MyCalcButtonRBShadow( state, "0", 80, buttonHeight3, 40, 0x000000, 0xFFFFFF, state.onButton0 ),
        MyCalcButtonRBShadow( state, ".", 80, buttonHeight3, 40, 0x000000, 0xFFFFFF, state.onButtonPoint ),
        MyCalcButtonRBShadow( state, "=", 80, buttonHeight3, 40, 0xFF8080, 0xFFFFFF, state.onButtonEqual )
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
