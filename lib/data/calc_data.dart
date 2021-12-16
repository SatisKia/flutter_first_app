import 'package:shared_preferences/shared_preferences.dart';

class CalcData {
  // 演算子の種類
  static int opTypeSet = 0;
  static int opTypeDiv = 1;
  static int opTypeMul = 2;
  static int opTypeSub = 3;
  static int opTypeAdd = 4;

  // 角度の種類
  static int angleTypeRad  = 0;	// ラジアン
  static int angleTypeDeg  = 1;	// 度
  static int angleTypeGrad = 2;	// グラジアン

  // エラーの種類
  static int errorTypeDivideByZero     = 0;
  static int errorTypePositiveInfinity = 1;
  static int errorTypeNegativeInfinity = 2;
  static int errorTypeNotANumber       = 3;

  // 計算結果
  double answer = 0.0;

  // メモリー
  double memory = 0.0;
  bool memoryRecalled = false;

  // 入力値
  double entry = 0.0;
  bool entryFlag = false;
  String entryStr = "0";

  // 演算子
  bool opFlag = false;
  int opType = opTypeSet;
  int nextOpType = opTypeSet;

  // 角度
  int angleType = angleTypeRad;

  // エラー
  bool errorFlag = false;
  int errorType = -1;

  Future<bool> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    answer = prefs.getDouble( "answer" ) ?? 0.0;
    memory = prefs.getDouble( "memory" ) ?? 0.0;
    memoryRecalled = prefs.getBool( "memoryRecalled" ) ?? false;
    angleType = prefs.getInt( "angleType" ) ?? angleTypeRad;
    return true;
  }

  static int saveAnswer         = 0x00000001;
  static int saveMemory         = 0x00000002;
  static int saveMemoryRecalled = 0x00000004;
  static int saveAngleType      = 0x00000008;
  void save( int flag ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if( (flag & saveAnswer        ) != 0 ){ await prefs.setDouble( "answer", answer ); }
    if( (flag & saveMemory        ) != 0 ){ await prefs.setDouble( "memory", memory ); }
    if( (flag & saveMemoryRecalled) != 0 ){ await prefs.setBool( "memoryRecalled", memoryRecalled ); }
    if( (flag & saveAngleType     ) != 0 ){ await prefs.setInt( "angleType", angleType ); }
  }
}
