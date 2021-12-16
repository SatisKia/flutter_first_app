import 'package:flutter/cupertino.dart';

import 'state/function_state.dart';
import 'state/loading_state.dart';
import 'state/number_state.dart';

class MyConfig {
  // アプリの仮想幅
  static int contentWidth = 320;

  // 初期ページ
  static String initialRoute = 'calc.loading';

  // ページ一覧
  static Map<String, StatefulWidget Function(BuildContext context)> routes = {
    'calc.loading': (BuildContext context) => const MyLoadingWidget(),
    'calc.number': (BuildContext context) => const MyNumberWidget(),
    'calc.function': (BuildContext context) => const MyFunctionWidget(),
  };
}
