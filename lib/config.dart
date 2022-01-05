import 'package:flutter/cupertino.dart';

import 'state/function_state.dart';
import 'state/loading_state.dart';
import 'state/number_state.dart';
import 'state/option_state.dart';

class MyConfig {
  // アプリの仮想幅
  static int contentWidth = 320;

  // ページ一覧
  static Map<String, StatefulWidget Function(BuildContext context)> routes = {
    '/': (BuildContext context) => const MyLoadingWidget(),
    '/number': (BuildContext context) => const MyNumberWidget(),
    '/function': (BuildContext context) => const MyFunctionWidget(),
    '/option': (BuildContext context) => const MyOptionWidget(),
  };
}
