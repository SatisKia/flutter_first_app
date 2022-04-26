import 'package:flutter/cupertino.dart';

import '../main.dart';
import '../model.dart';
import '../model/calc_model.dart';
import '../view/option_view.dart';

class MyOptionArguments {
  String? returnRoute;
}

class MyOptionWidget extends StatefulWidget {
  const MyOptionWidget({Key? key}) : super(key: key);

  @override
  State createState() => MyOptionState();
}

class MyOptionState extends MyState {
  MyOptionState() : super( OptionView() );

  @override
  bool autoScroll(){ return true; }

  String returnRoute = '';

  // イタリック
  bool italic = MyModel.calc.italicFlag;
  void setItalic(bool flag){
    setState(() {
      italic = flag;
    });

    MyModel.calc.italicFlag = italic;
    MyModel.calc.save( CalcModel.saveItalicFlag );
  }

  // 桁区切り
  int separator = MyModel.calc.separatorType;
  void setSeparator(int value){
    setState(() {
      separator = value;
    });

    MyModel.calc.separatorType = separator;
    MyModel.calc.save( CalcModel.saveSeparatorType );
  }

  // 戻る
  void onButtonBack(){
    go( returnRoute );
  }

  @override
  void onEnter(){
    debugPrint( 'option onEnter' );

    MyOptionArguments arguments = this.arguments as MyOptionArguments;
    returnRoute = arguments.returnRoute!;
  }

  @override
  void onBack(){
    debugPrint( 'option onBack' );

    onButtonBack();
  }

  @override
  void onInit(){
    debugPrint( 'option onInit' );
  }
  @override
  void onDispose(){
    debugPrint( 'option onDispose' );
  }
  @override
  void onReady(){
    debugPrint( 'option onReady' );
  }
  @override
  void onLeave(){
    debugPrint( 'option onLeave' );
  }
  @override
  void onPause(){
    debugPrint( 'option onPause' );
  }
  @override
  void onResume(){
    debugPrint( 'option onResume' );
  }
}
