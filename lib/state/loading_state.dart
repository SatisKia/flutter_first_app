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
    await MyData.calc.load();
//    await Future.delayed( Duration( seconds: 3 ), (){ return true; } );
    go( 'calc.number', null );
  }
}
