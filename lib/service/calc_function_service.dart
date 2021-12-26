import 'dart:math';

import 'calc_service.dart';
import '../data.dart';
import '../data/calc_data.dart';
import '../state/function_state.dart';

class CalcFunctionService extends CalcService {
  MyFunctionState? state;
  void initWithState( MyFunctionState state ){
    this.state = state;

    super.init();
    _angleChanged( MyData.calc.angleType );
  }

  @override
  void setDispError( int type ){
    if( type == CalcData.errorTypeDivideByZero ){
      state!.dispStr = "Divide by zero";
    } else if( type == CalcData.errorTypePositiveInfinity ){
      state!.dispStr = "Infinity";
    } else if( type == CalcData.errorTypeNegativeInfinity ){
      state!.dispStr = "-Infinity";
    } else if( type == CalcData.errorTypeNotANumber ){
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
    if( type == CalcData.angleTypeRad ){
      state!.dispAngle = "RAD";
      state!.angleButtonText = "DEG";
    } else if( type == CalcData.angleTypeDeg ){
      state!.dispAngle = "DEG";
      state!.angleButtonText = "GRAD";
    } else if( type == CalcData.angleTypeGrad ){
      state!.dispAngle = "GRAD";
      state!.angleButtonText = "RAD";
    }
  }

  final double _pi        = 3.14159265358979323846264;	// 円周率
  final double _normalize = 0.434294481903251816668;	// 1/log(10)

  // 角度の種類
  void setAngle( int type ){
    MyData.calc.angleType = type;
    MyData.calc.save( CalcData.saveAngleType );

    _angleChanged( MyData.calc.angleType );
  }
  double _angleToRad( double value ){
    return (MyData.calc.angleType == CalcData.angleTypeRad) ? value : value * _pi / ((MyData.calc.angleType == CalcData.angleTypeDeg) ? 180.0 : 200.0);
  }
  double _radToAngle( double value ){
    return (MyData.calc.angleType == CalcData.angleTypeRad) ? value : value * ((MyData.calc.angleType == CalcData.angleTypeDeg) ? 180.0 : 200.0) / _pi;
  }
  int angle(){
    return MyData.calc.angleType;
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
}
