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
        MyCalcButton( state, "M+", 80, buttonHeight1, 25, 0x000000, 0xC0C0FF, state.onButtonMAdd ),
        MyCalcButton( state, "M-", 80, buttonHeight1, 25, 0x000000, 0xC0C0FF, state.onButtonMSub ),
        MyCalcButton( state, state.mrcButtonText, 80, buttonHeight1, 25, MyModel.calc.memoryRecalled ? 0xFF8080 : 0x000000, 0xC0C0FF, state.onButtonMRC ),
        MyCalcButton( state, "FNC", 80, buttonHeight1, 25, 0xFFFFFF, 0xFFA0A0, state.onButtonFunction )
      ] ),
      MyRow( children: [
        MyCalcButton( state, "CE", 80, buttonHeight2, 32, MyModel.calc.errorFlag ? 0xFFFFFF : 0xFF8080, MyModel.calc.errorFlag ? 0xFFA0A0 : 0xFFFFFF, state.onButtonCE ),
        MyCalcButton( state, "C", 80, buttonHeight2, 32, MyModel.calc.errorFlag ? 0xFFFFFF : 0xFF8080, MyModel.calc.errorFlag ? 0xFFA0A0 : 0xFFFFFF, state.onButtonC ),
        MyCalcButton( state, "DEL", 80, buttonHeight2, 32, 0x000000, 0xFFFFFF, state.onButtonDEL ),
        MyCalcButton( state, "÷", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButtonDiv )
      ] ),
      MyRow( children: [
        MyCalcButton( state, "7", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton7 ),
        MyCalcButton( state, "8", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton8 ),
        MyCalcButton( state, "9", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton9 ),
        MyCalcButton( state, "×", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButtonMul )
      ] ),
      MyRow( children: [
        MyCalcButton( state, "4", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton4 ),
        MyCalcButton( state, "5", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton5 ),
        MyCalcButton( state, "6", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton6 ),
        MyCalcButton( state, "-", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButtonSub )
      ] ),
      MyRow( children: [
        MyCalcButton( state, "1", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton1 ),
        MyCalcButton( state, "2", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton2 ),
        MyCalcButton( state, "3", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButton3 ),
        MyCalcButton( state, "+", 80, buttonHeight2, 40, 0x000000, 0xFFFFFF, state.onButtonAdd )
      ] ),
      MyRow( children: [
        MyCalcButton( state, "+/-", 80, buttonHeight3, 40, 0x000000, 0xFFFFFF, state.onButtonNegative ),
        MyCalcButton( state, "0", 80, buttonHeight3, 40, 0x000000, 0xFFFFFF, state.onButton0 ),
        MyCalcButton( state, ".", 80, buttonHeight3, 40, 0x000000, 0xFFFFFF, state.onButtonPoint ),
        MyCalcButton( state, "=", 80, buttonHeight3, 40, 0xFF8080, 0xFFFFFF, state.onButtonEqual )
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
