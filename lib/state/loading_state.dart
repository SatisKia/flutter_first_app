import 'package:flutter/cupertino.dart';

import '../data.dart';
import '../main.dart';
import '../view/loading_view.dart';

class MyLoadingWidget extends StatefulWidget {
  const MyLoadingWidget({Key? key}) : super(key: key);

  @override
  State createState() => MyLoadingState();
}

class MyLoadingState extends MyState {
  MyLoadingState() : super(loadingView);

  @override
  void onEnter() async {
    debugPrint( 'loading onEnter' );

    await MyData.calc.load();
//    await Future.delayed( const Duration( seconds: 3 ), (){ return true; } );
    go( '/number', null );
  }

  @override
  void onInit(){
    debugPrint( 'loading onInit' );
  }
  @override
  void onDispose(){
    debugPrint( 'loading onDispose' );
  }
  @override
  void onReady(){
    debugPrint( 'loading onReady' );
  }
  @override
  void onLeave(){
    debugPrint( 'loading onLeave' );
  }
  @override
  void onPause(){
    debugPrint( 'loading onPause' );
  }
  @override
  void onResume(){
    debugPrint( 'loading onResume' );
  }
  @override
  void onBack(){
    debugPrint( 'loading onBack' );
  }
}
