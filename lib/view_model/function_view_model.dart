import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../model.dart';
import '../model/calc_model.dart';
import '../service.dart';
import '../view/function_view.dart';

class MyFunctionWidget extends StatefulWidget {
  const MyFunctionWidget({Key? key}) : super(key: key);

  @override
  State createState() => MyFunctionState();
}

class MyFunctionState extends MyState {
  MyFunctionState() : super( FunctionView() );

  String dispStr = "0";
  String dispAngle = "RAD";
  String dispMemory = "0";
  String mrcButtonText = "MR";
  String angleButtonText = "DEG";

  @override
  void onEnter(){
    debugPrint( 'function onEnter' );

    MyService.calcFunction.initWithState( this );
  }

  @override
  void onBack(){
    debugPrint( 'function onBack' );

    goNoDuration( '/number' );
  }

  void vibrate(){
    // TODO: 振動機能呼び出し
  }

  void changeAngle(){
    if( MyService.calcFunction.angle() == CalcModel.angleTypeRad ){
      MyService.calcFunction.setAngle( CalcModel.angleTypeDeg );
    } else if( MyService.calcFunction.angle() == CalcModel.angleTypeDeg ){
      MyService.calcFunction.setAngle( CalcModel.angleTypeGrad );
    } else if( MyService.calcFunction.angle() == CalcModel.angleTypeGrad ){
      MyService.calcFunction.setAngle( CalcModel.angleTypeRad );
    }
  }

  void onButtonFunction( Function() function ){
    if( !MyModel.calc.errorFlag ){
      vibrate();
      setState( function );
    }
  }
  void onButtonClear( bool allFlag ){
    vibrate();
    setState( (){
      MyService.calcFunction.clearEntry( allFlag );
    } );
  }
  void onButtonMAdd(){ onButtonFunction( (){ MyService.calcFunction.addMemory(); } ); }
  void onButtonMSub(){ onButtonFunction( (){ MyService.calcFunction.subMemory(); } ); }
  void onButtonMRC(){ onButtonFunction( (){ if( MyModel.calc.memoryRecalled ){ MyService.calcFunction.clearMemory(); } else { MyService.calcFunction.recallMemory(); } } ); }
  void onButtonNumber(){ onButtonFunction( (){ MyService.calcFunction.setOp(); goNoDuration( '/number' ); } ); }
  void onButtonCE(){ onButtonClear( false ); }
  void onButtonC(){ onButtonClear( true ); }
  void onButtonAngle(){ onButtonFunction( (){ changeAngle(); } ); }
  void onButtonSqrt(){ onButtonFunction( (){ MyService.calcFunction.funcSqrt(); MyService.calcFunction.setOp(); } ); }
  void onButtonSin(){ onButtonFunction( (){ MyService.calcFunction.funcSin(); MyService.calcFunction.setOp(); } ); }
  void onButtonCos(){ onButtonFunction( (){ MyService.calcFunction.funcCos(); MyService.calcFunction.setOp(); } ); }
  void onButtonTan(){ onButtonFunction( (){ MyService.calcFunction.funcTan(); MyService.calcFunction.setOp(); } ); }
  void onButtonArcSin(){ onButtonFunction( (){ MyService.calcFunction.funcArcSin(); MyService.calcFunction.setOp(); } ); }
  void onButtonArcCos(){ onButtonFunction( (){ MyService.calcFunction.funcArcCos(); MyService.calcFunction.setOp(); } ); }
  void onButtonArcTan(){ onButtonFunction( (){ MyService.calcFunction.funcArcTan(); MyService.calcFunction.setOp(); } ); }
  void onButtonLog(){ onButtonFunction( (){ MyService.calcFunction.funcLog(); MyService.calcFunction.setOp(); } ); }
  void onButtonLog10(){ onButtonFunction( (){ MyService.calcFunction.funcLog10(); MyService.calcFunction.setOp(); } ); }
  void onButtonSqr(){ onButtonFunction( (){ MyService.calcFunction.funcSqr(); MyService.calcFunction.setOp(); } ); }
  void onButtonExp(){ onButtonFunction( (){ MyService.calcFunction.funcExp(); MyService.calcFunction.setOp(); } ); }
  void onButtonExp10(){ onButtonFunction( (){ MyService.calcFunction.funcExp10(); MyService.calcFunction.setOp(); } ); }
  void onButtonInt(){ onButtonFunction( (){ MyService.calcFunction.funcInt(); MyService.calcFunction.setOp(); } ); }

  @override
  void onInit(){
    debugPrint( 'function onInit' );
  }
  @override
  void onDispose(){
    debugPrint( 'function onDispose' );
  }
  @override
  void onReady(){
    debugPrint( 'function onReady' );
  }
  @override
  void onLeave(){
    debugPrint( 'function onLeave' );
  }
  @override
  void onPause(){
    debugPrint( 'function onPause' );
  }
  @override
  void onResume(){
    debugPrint( 'function onResume' );
  }
}
