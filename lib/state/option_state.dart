import 'package:flutter/cupertino.dart';

import '../data/calc_data.dart';
import '../data.dart';
import '../main.dart';
import '../view/option_view.dart';

class MyOptionWidget extends StatefulWidget {
  const MyOptionWidget({Key? key}) : super(key: key);

  @override
  State createState() => MyOptionState();
}

class MyOptionState extends MyState {
  MyOptionState() : super(optionView);

  @override
  bool autoScroll(){ return true; }

  String returnRoute = '';

  // イタリック
  bool italic = MyData.calc.italicFlag;
  void setItalic(bool flag){
    setState(() {
      italic = flag;
    });

    MyData.calc.italicFlag = italic;
    MyData.calc.save( CalcData.saveItalicFlag );
  }

  // 桁区切り
  int separator = MyData.calc.separatorType;
  void setSeparator(int value){
    setState(() {
      separator = value;
    });

    MyData.calc.separatorType = separator;
    MyData.calc.save( CalcData.saveSeparatorType );
  }

  // 戻る
  void onButtonBack(){
    go( returnRoute, null );
  }

  @override
  void onEnter(){
    debugPrint( 'option onEnter' );

    returnRoute = arguments as String;
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
