import 'package:flutter/cupertino.dart';

import 'view_model/function_view_model.dart';
import 'view_model/loading_view_model.dart';
import 'view_model/number_view_model.dart';
import 'view_model/option_view_model.dart';

class MyConfig {
  static bool fullScreen = false;

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
