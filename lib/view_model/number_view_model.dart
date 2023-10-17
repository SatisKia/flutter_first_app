import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 振動機能
import 'package:flutter_first_plugin/flutter_first_plugin.dart';

import '../main.dart';
import '../model.dart';
import '../model/calc_model.dart';
import '../service.dart';
import '../view/number_view.dart';

class MyNumberWidget extends StatefulWidget {
  const MyNumberWidget({Key? key}) : super(key: key);

  @override
  State createState() => MyNumberState();
}

class MyNumberState extends MyState {
  MyNumberState() : super( NumberView() );

  String dispStr = "0";
  String dispLog = "";
  String dispAnswer = "0";
  String dispMemory = "0";
  String mrcButtonText = "MR";

  @override
  void onEnter(){
    debugPrint( 'number onEnter' );

    MyService.calcNumber.initWithState( this );
  }

  @override
  void onBack(){
    debugPrint( 'number onBack' );

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("アプリ終了"),
          content: const Text("アプリを終了してもよろしいですか？"),
          actions: [
            CupertinoDialogAction(
              child: const Text('いいえ'),
              onPressed: (){ closeDialog(); },
            ),
            CupertinoDialogAction(
              child: const Text('はい'),
              onPressed: (){ finish(); },
            )
          ],
        )
    );
  }

  void vibrate(){
    // 振動機能
    FlutterFirstPlugin().vibrate();
  }

  void onButtonNumber( Function() function ){
    if( !MyModel.calc.errorFlag ){
      vibrate();
      setState( function );
    }
  }
  void onButtonClear( bool allFlag ){
    vibrate();
    setState( (){
      MyService.calcNumber.clearEntry( allFlag );
    } );
  }
  void onButtonMAdd(){ onButtonNumber( (){ MyService.calcNumber.addMemory(); } ); }
  void onButtonMSub(){ onButtonNumber( (){ MyService.calcNumber.subMemory(); } ); }
  void onButtonMRC(){ onButtonNumber( (){ if( MyModel.calc.memoryRecalled ){ MyService.calcNumber.clearMemory(); } else { MyService.calcNumber.recallMemory(); } } ); }
  void onButtonFunction(){ onButtonNumber( (){ MyService.calcNumber.setOp( CalcModel.opTypeSet ); goNoDuration( '/function' ); } ); }
  void onButtonCE(){ onButtonClear( false ); }
  void onButtonC(){ onButtonClear( true ); }
  void onButtonDEL(){ if( !MyModel.calc.errorFlag && MyModel.calc.entryFlag ){ vibrate(); setState( (){ MyService.calcNumber.delEntry(); } ); } }
  void onButtonDiv(){ onButtonNumber( (){ MyService.calcNumber.setOp( CalcModel.opTypeDiv ); } ); }
  void onButtonMul(){ onButtonNumber( (){ MyService.calcNumber.setOp( CalcModel.opTypeMul ); } ); }
  void onButtonSub(){ onButtonNumber( (){ MyService.calcNumber.setOp( CalcModel.opTypeSub ); } ); }
  void onButtonAdd(){ onButtonNumber( (){ MyService.calcNumber.setOp( CalcModel.opTypeAdd ); } ); }
  void onButton0(){ onButtonNumber( (){ MyService.calcNumber.addNumber( "0" ); } ); }
  void onButton1(){ onButtonNumber( (){ MyService.calcNumber.addNumber( "1" ); } ); }
  void onButton2(){ onButtonNumber( (){ MyService.calcNumber.addNumber( "2" ); } ); }
  void onButton3(){ onButtonNumber( (){ MyService.calcNumber.addNumber( "3" ); } ); }
  void onButton4(){ onButtonNumber( (){ MyService.calcNumber.addNumber( "4" ); } ); }
  void onButton5(){ onButtonNumber( (){ MyService.calcNumber.addNumber( "5" ); } ); }
  void onButton6(){ onButtonNumber( (){ MyService.calcNumber.addNumber( "6" ); } ); }
  void onButton7(){ onButtonNumber( (){ MyService.calcNumber.addNumber( "7" ); } ); }
  void onButton8(){ onButtonNumber( (){ MyService.calcNumber.addNumber( "8" ); } ); }
  void onButton9(){ onButtonNumber( (){ MyService.calcNumber.addNumber( "9" ); } ); }
  void onButtonPoint(){ onButtonNumber( (){ MyService.calcNumber.addPoint(); } ); }
  void onButtonNegative(){ onButtonNumber( (){ MyService.calcNumber.negative(); } ); }
  void onButtonEqual(){ onButtonNumber( (){ MyService.calcNumber.setOp( CalcModel.opTypeSet ); } ); }

  @override
  void onInit(){
    debugPrint( 'number onInit' );
  }
  @override
  void onDispose(){
    debugPrint( 'number onDispose' );
  }
  @override
  void onReady(){
    debugPrint( 'number onReady' );
  }
  @override
  void onLeave(){
    debugPrint( 'number onLeave' );
  }
  @override
  void onPause(){
    debugPrint( 'number onPause' );
  }
  @override
  void onResume(){
    debugPrint( 'number onResume' );
  }
}
