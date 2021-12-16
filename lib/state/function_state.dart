import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/calc_data.dart';
import '../main.dart';
import '../service.dart';
import '../view/function_view.dart';

import 'package:flutter_first_plugin/flutter_first_plugin.dart';

class MyFunctionWidget extends StatefulWidget {
  const MyFunctionWidget({Key? key}) : super(key: key);

  @override
  State createState() => MyFunctionState();
}

class MyFunctionState extends MyState {
  MyFunctionState() : super( functionView );

  String dispStr = "0";
  String dispAngle = "RAD";
  String dispAnswer = "0";
  String dispMemory = "0";
  String mrcButtonText = "MR";
  String angleButtonText = "DEG";

  @override
  void onEnter(){
    MyService.calcFunction.initWithState( this );
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
    go( 'calc.number', null );
  }

  bool isMemoryRecalled(){
    return MyService.calcFunction.isMemoryRecalled();
  }
  bool isError(){
    return MyService.calcFunction.isError();
  }

  void vibrate(){
    FlutterFirstPlugin.vibrate();
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

  void onButtonMAdd(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.addMemory(); } ); } }
  void onButtonMSub(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.subMemory(); } ); } }
  void onButtonMRC(){ if( !isError() ){ vibrate(); setState( (){ if( isMemoryRecalled() ){ MyService.calcFunction.clearMemory(); } else { MyService.calcFunction.recallMemory(); } } ); } }
  void onButtonNumber(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.setOp( CalcData.opTypeSet ); go( 'calc.number', null ); } ); } }
  void onButtonCE(){ vibrate(); setState( (){ MyService.calcFunction.clearEntry( false ); } ); }
  void onButtonC(){ vibrate(); setState( (){ MyService.calcFunction.clearEntry( true ); } ); }
  void onButtonAngle(){ if( !isError() ){ vibrate(); setState( (){ changeAngle(); } ); } }
  void onButtonSqrt(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcSqrt(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
  void onButtonSin(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcSin(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
  void onButtonCos(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcCos(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
  void onButtonTan(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcTan(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
  void onButtonArcSin(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcArcSin(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
  void onButtonArcCos(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcArcCos(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
  void onButtonArcTan(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcArcTan(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
  void onButtonLog(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcLog(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
  void onButtonLog10(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcLog10(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
  void onButtonSqr(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcSqr(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
  void onButtonExp(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcExp(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
  void onButtonExp10(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcExp10(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
  void onButtonInt(){ if( !isError() ){ vibrate(); setState( (){ MyService.calcFunction.funcInt(); MyService.calcFunction.setOp( CalcData.opTypeSet ); } ); } }
}
