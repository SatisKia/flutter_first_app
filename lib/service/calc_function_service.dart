import 'dart:math';

import '../model.dart';
import '../model/calc_model.dart';
import '../view_model/function_view_model.dart';
import 'calc_service.dart';

class CalcFunctionService extends CalcService {
  MyFunctionState? state;
  void initWithState( MyFunctionState state ){
    this.state = state;

    super.init();
    _angleChanged( MyModel.calc.angleType );
  }

  @override
  void setDispError( int type ){
    if( type == CalcModel.errorTypeDivideByZero ){
      state!.dispStr = "Divide by zero";
    } else if( type == CalcModel.errorTypePositiveInfinity ){
      state!.dispStr = "Infinity";
    } else if( type == CalcModel.errorTypeNegativeInfinity ){
      state!.dispStr = "-Infinity";
    } else if( type == CalcModel.errorTypeNotANumber ){
      state!.dispStr = "NaN";
    }
  }
  @override
  void setDispResult( double value ){
    state!.dispStr = valueToString( value, 15 );
  }
  @override
  void setDispEntry( String entry ){
    state!.dispStr = entry;
  }
  @override
  void setDispMemory( value ){
    state!.dispMemory = valueToString( value, 10 );
  }
  @override
  void memoryRecalled( bool flag ){
    state!.mrcButtonText = flag ? "MC" : "MR";
  }

  void _angleChanged( int type ){
    if( type == CalcModel.angleTypeRad ){
      state!.dispAngle = "RAD";
      state!.angleButtonText = "DEG";
    } else if( type == CalcModel.angleTypeDeg ){
      state!.dispAngle = "DEG";
      state!.angleButtonText = "GRAD";
    } else if( type == CalcModel.angleTypeGrad ){
      state!.dispAngle = "GRAD";
      state!.angleButtonText = "RAD";
    }
  }

  final double _pi        = 3.14159265358979323846264;	// 円周率
  final double _normalize = 0.434294481903251816668;	// 1/log(10)

  // 角度の種類
  void setAngle( int type ){
    MyModel.calc.angleType = type;
    MyModel.calc.save( CalcModel.saveAngleType );

    _angleChanged( MyModel.calc.angleType );
  }
  double _angleToRad( double value ){
    return (MyModel.calc.angleType == CalcModel.angleTypeRad) ? value : value * _pi / ((MyModel.calc.angleType == CalcModel.angleTypeDeg) ? 180.0 : 200.0);
  }
  double _radToAngle( double value ){
    return (MyModel.calc.angleType == CalcModel.angleTypeRad) ? value : value * ((MyModel.calc.angleType == CalcModel.angleTypeDeg) ? 180.0 : 200.0) / _pi;
  }
  int angle(){
    return MyModel.calc.angleType;
  }

  // 数学関数
  void funcSin(){
    clearAndSetEntry( sin( _angleToRad( getEntry() ) ) );
  }
  void funcCos(){
    clearAndSetEntry( cos( _angleToRad( getEntry() ) ) );
  }
  void funcTan(){
    clearAndSetEntry( tan( _angleToRad( getEntry() ) ) );
  }
  void funcArcSin(){
    clearAndSetEntry( _radToAngle( asin( getEntry() ) ) );
  }
  void funcArcCos(){
    clearAndSetEntry( _radToAngle( acos( getEntry() ) ) );
  }
  void funcArcTan(){
    clearAndSetEntry( _radToAngle( atan( getEntry() ) ) );
  }
  void funcLog(){
    clearAndSetEntry( log( getEntry() ) );
  }
  void funcLog10(){
    clearAndSetEntry( log( getEntry() ) * _normalize );
  }
  void funcExp(){
    clearAndSetEntry( exp( getEntry() ) );
  }
  void funcExp10(){
    clearAndSetEntry( exp( getEntry() / _normalize ) );
  }
  void funcSqr(){
    double value = getEntry();
    clearAndSetEntry( value * value );
  }
  void funcSqrt(){
    clearAndSetEntry( sqrt( getEntry() ) );
  }

  void funcInt(){
    try {
      clearAndSetEntry( getEntry().toInt().toDouble() );
      // ignore: empty_catches
    } catch(e){
    }
  }

  void setOp(){
    MyModel.calc.answer = getEntry();
    setDispAnswer( MyModel.calc.answer );

    setEntry( MyModel.calc.answer );
    updateEntryStr( true );
    setDispStr( true );

    MyModel.calc.opFlag = true;	// 次に数値入力ボタンが押された場合にprocOpが発動するように

    setMemoryRecalled( false );
    MyModel.calc.save( CalcModel.saveAnswer | CalcModel.saveMemoryRecalled );
  }
}
