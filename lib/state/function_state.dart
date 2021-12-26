import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data.dart';
import '../data/calc_data.dart';
import '../main.dart';
import '../service.dart';
import '../view/function_view.dart';

class MyFunctionWidget extends StatefulWidget {
  const MyFunctionWidget({Key? key}) : super(key: key);

  @override
  State createState() => MyFunctionState();
}

class MyFunctionState extends MyState {
  MyFunctionState() : super( functionView );

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

    go( 'calc.number', null );
  }

  bool isMemoryRecalled(){
    return MyData.calc.memoryRecalled;
  }
  bool isError(){
    return MyData.calc.errorFlag;
  }

  void vibrate(){
    // TODO: 振動機能呼び出し
  }

  void changeAngle(){
    if( MyService.calcFunction.angle() == CalcData.angleTypeRad ){
      MyService.calcFunction.setAngle( CalcData.angleTypeDeg );
    } else if( MyService.calcFunction.angle() == CalcData.angleTypeDeg ){
      MyService.calcFunction.setAngle( CalcData.angleTypeGrad );
    } else if( MyService.calcFunction.angle() == CalcData.angleTypeGrad ){
      MyService.calcFunction.setAngle( CalcData.angleTypeRad );
    }
  }

  void onButtonFunction( Function() function ){
    if( !isError() ){
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
  void onButtonMRC(){ onButtonFunction( (){ if( isMemoryRecalled() ){ MyService.calcFunction.clearMemory(); } else { MyService.calcFunction.recallMemory(); } } ); }
  void onButtonNumber(){ onButtonFunction( (){ MyService.calcFunction.setOp( CalcData.opTypeSet ); go( 'calc.number', null ); } ); }
  void onButtonCE(){ onButtonClear( false ); }
  void onButtonC(){ onButtonClear( true ); }
  void onButtonAngle(){ onButtonFunction( (){ changeAngle(); } ); }
  void onButtonSqrt(){ onButtonFunction( (){ MyService.calcFunction.funcSqrt(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }
  void onButtonSin(){ onButtonFunction( (){ MyService.calcFunction.funcSin(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }
  void onButtonCos(){ onButtonFunction( (){ MyService.calcFunction.funcCos(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }
  void onButtonTan(){ onButtonFunction( (){ MyService.calcFunction.funcTan(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }
  void onButtonArcSin(){ onButtonFunction( (){ MyService.calcFunction.funcArcSin(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }
  void onButtonArcCos(){ onButtonFunction( (){ MyService.calcFunction.funcArcCos(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }
  void onButtonArcTan(){ onButtonFunction( (){ MyService.calcFunction.funcArcTan(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }
  void onButtonLog(){ onButtonFunction( (){ MyService.calcFunction.funcLog(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }
  void onButtonLog10(){ onButtonFunction( (){ MyService.calcFunction.funcLog10(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }
  void onButtonSqr(){ onButtonFunction( (){ MyService.calcFunction.funcSqr(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }
  void onButtonExp(){ onButtonFunction( (){ MyService.calcFunction.funcExp(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }
  void onButtonExp10(){ onButtonFunction( (){ MyService.calcFunction.funcExp10(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }
  void onButtonInt(){ onButtonFunction( (){ MyService.calcFunction.funcInt(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); }

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
