import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/calc_data.dart';
import '../main.dart';
import '../service.dart';
import '../view/number_view.dart';

import 'package:flutter_first_plugin/flutter_first_plugin.dart';

class MyNumberWidget extends StatefulWidget {
  const MyNumberWidget({Key? key}) : super(key: key);

  @override
  State createState() => MyNumberState();
}

class MyNumberState extends MyState {
  MyNumberState() : super( numberView );

  String dispStr = "0";
  String dispLog = "";
  String dispAnswer = "0";
  String dispMemory = "0";
  String mrcButtonText = "MR";

  @override
  void onEnter(){
    MyService.calcNumber.initWithState( this );
  }

  @override
  void onLeave(){
  }

  @override
  void onPause(){
  }

  @override
  void onResume(){
  }

  @override
  void onBack(){
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
              onPressed: (){ exit(); },
            )
          ],
        )
    );
  }

  bool isEntry(){
    return MyService.calcNumber.isEntry();
  }
  bool isMemoryRecalled(){
    return MyService.calcNumber.isMemoryRecalled();
  }
  bool isError(){
    return MyService.calcNumber.isError();
  }

  void vibrate(){
    FlutterFirstPlugin.vibrate();
  }

  void onButtonMAdd(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.addMemory(); } ); } }
  void onButtonMSub(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.subMemory(); } ); } }
  void onButtonMRC(){ if( !isError() ){ vibrate(); setState( (){ if( isMemoryRecalled() ){ MyService.calcNumber.clearMemory(); } else { MyService.calcNumber.recallMemory(); } } ); } }
  void onButtonFunction(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.setOp( CalcData.opTypeSet ); go( 'calc.function', null ); } ); } }
  void onButtonCE(){ vibrate(); setState( (){ MyService.calcNumber.clearEntry( false ); } ); }
  void onButtonC(){ vibrate(); setState( (){ MyService.calcNumber.clearEntry( true ); } ); }
  void onButtonDEL(){ if( !isError() && isEntry() ){ vibrate(); setState( (){ MyService.calcNumber.delEntry(); } ); } }
  void onButtonDiv(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.setOp( CalcData.opTypeDiv ); } ); } }
  void onButtonMul(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.setOp( CalcData.opTypeMul ); } ); } }
  void onButtonSub(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.setOp( CalcData.opTypeSub ); } ); } }
  void onButtonAdd(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.setOp( CalcData.opTypeAdd ); } ); } }
  void onButton0(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.addNumber( "0" ); } ); } }
  void onButton1(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.addNumber( "1" ); } ); } }
  void onButton2(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.addNumber( "2" ); } ); } }
  void onButton3(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.addNumber( "3" ); } ); } }
  void onButton4(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.addNumber( "4" ); } ); } }
  void onButton5(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.addNumber( "5" ); } ); } }
  void onButton6(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.addNumber( "6" ); } ); } }
  void onButton7(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.addNumber( "7" ); } ); } }
  void onButton8(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.addNumber( "8" ); } ); } }
  void onButton9(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.addNumber( "9" ); } ); } }
  void onButtonPoint(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.addPoint(); } ); } }
  void onButtonNegative(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.negative(); } ); } }
  void onButtonEqual(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcNumber.setOp( CalcData.opTypeSet ); } ); } }
}
