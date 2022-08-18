import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ローカライゼーション
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config.dart';

void main() async {
  if( MyConfig.fullScreen ){
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
  runApp( MyApp() );
}

class MyApp extends StatelessWidget {
  MyApp( { Key? key } ) : super( key: key );

  // ローカライゼーション
  final List<LocalizationsDelegate> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  final List<Locale> supportedLocales = [
    const Locale('en', ''), // 英語
    const Locale('ja', ''), // 日本語
  ];

  @override
  Widget build( BuildContext context ){
    return MaterialApp(
        localizationsDelegates: localizationsDelegates, // ローカライゼーション
        supportedLocales: supportedLocales, // ローカライゼーション
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        routes: MyConfig.routes // ページ一覧
    );
  }
}

class MyState extends State with WidgetsBindingObserver {
  MyView view; // ページの画面用
  MyState( this.view );

  String? routeName; // ページ識別子
  Object? arguments; // goパラメータ

  // viewサイズ
  double contentWidth = 0.0;
  double contentHeight = 0.0;

  // 自動スクロール用
  ScrollController? scrollController;

  // アプリ仮想サイズをviewサイズに変換するための係数
  double scale(){
    return contentWidth / MyConfig.contentWidth.toDouble();
  }

  // アプリ仮想サイズをviewサイズに変換する
  double size( int value ){
    return value.toDouble() * scale();
  }

  // アプリの仮想の高さを取得する
  int getContentHeight(){
    return contentHeight ~/ scale();
  }

  // 各ページでオーバーライドする関数群
  bool autoScroll(){
    // キーボード表示による自動スクロールをさせるかどうか
    return false;
  }
  void onInit(){
    // このページの構築時
  }
  void onDispose(){
    // このページの解放時
  }
  void onReady(){
    // ウィジェットのビルド完了時
  }
  void onEnter(){
    // このページに入ってきた
  }
  void onLeave(){
    // このページから離れた
  }
  void onPause(){
    // アプリがバックグラウンドになった
  }
  void onResume(){
    // アプリがフォアグラウンドになった
  }
  void onBack(){
    // 端末の「戻る」ボタンがタップされた
  }

  // 指定したページへ遷移する
  void go( String routeName, { Object? arguments } ){
    onLeave();
//    Navigator.pushNamedAndRemoveUntil(context, routeName, (_) => false, arguments: arguments);
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }
  void goNoDuration( String routeName, { Object? arguments } ){
    onLeave();
    Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
      settings: RouteSettings(name: routeName, arguments: arguments),
      pageBuilder: (_,__,___) => MyConfig.routes[routeName]!(context),
      transitionDuration: const Duration(seconds: 0),
    ), (_) => false);
  }

  // ダイアログを閉じる
  void closeDialog(){
    Navigator.pop(context);
  }

  // アプリを終了させる
  void finish(){
    SystemNavigator.pop();
  }

  @override
  void initState() {
    super.initState();
    onInit();
    WidgetsBinding.instance.addObserver(this);
    if( autoScroll() ) {
      scrollController = ScrollController();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if( autoScroll() ) {
        scrollController!.jumpTo(scrollController!.position.maxScrollExtent);
      }
      onReady();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if( autoScroll() ){
      scrollController!.dispose();
    }
    onDispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeName = ModalRoute.of(context)!.settings.name;
    arguments = ModalRoute.of(context)!.settings.arguments;
    onEnter();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.detached){
      onLeave();
    }else if(state == AppLifecycleState.paused) {
      onPause();
    }else if(state == AppLifecycleState.resumed){
      onResume();
    }
  }

  Future<bool> _willPopCallback() async {
    onBack();
    return false;
  }

  @override
  Widget build( BuildContext context ){
    contentWidth  = MediaQuery.of( context ).size.width;
    contentHeight = MediaQuery.of( context ).size.height;
    if( !MyConfig.fullScreen ){
      contentHeight -= MediaQuery.of( context ).padding.top + MediaQuery.of( context ).padding.bottom;
    }

    AppBar appBar = AppBar(
        toolbarHeight: 0
    );
    WillPopScope body = WillPopScope(
        onWillPop: _willPopCallback,
        child: SizedBox(
          width: contentWidth,
          height: contentHeight,
          child: view.build( this ), // ページの画面を構築する
        )
    );

    if( autoScroll() ){
      return Scaffold(
        appBar: MyConfig.fullScreen ? null : appBar,
        resizeToAvoidBottomInset: false, // 自前で高さ対応する
        body: SingleChildScrollView(
          controller: scrollController,
          reverse: true, // スクロールの向きを逆にする
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of( context ).viewInsets.bottom,
            ),
            child: body,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: MyConfig.fullScreen ? null : appBar,
        body: body,
      );
    }
  }
}

class MyView {
  Widget build( MyState state ){
    return Container(); // 仮のウィジェット
  }
}
