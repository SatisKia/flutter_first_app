import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../model.dart';
import '../view/loading_view.dart';

class MyLoadingWidget extends StatefulWidget {
  const MyLoadingWidget({Key? key}) : super(key: key);

  @override
  State createState() => MyLoadingState();
}

class MyLoadingState extends MyState {
  MyLoadingState() : super( LoadingView() );

  @override
  void onEnter() async {
    debugPrint( 'loading onEnter' );

    // バックグラウンド画像
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyModel.app.imageFlag = prefs.getBool( 'imageFlag' ) ?? false;
    MyModel.app.imageData = prefs.getString( 'imageData') ?? '';
    MyModel.app.imageX = prefs.getDouble( 'imageX_${MyModel.app.imageData.hashCode}') ?? 0.0;
    MyModel.app.imageY = prefs.getDouble( 'imageY_${MyModel.app.imageData.hashCode}') ?? 0.0;
    if( MyModel.app.imageData.isNotEmpty ) {
      MyModel.app.image = MemoryImage( base64.decode( MyModel.app.imageData ) );
    }

    await MyModel.calc.load();

//    await Future.delayed( const Duration( seconds: 3 ), (){ return true; } );

    go( '/number' );
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
