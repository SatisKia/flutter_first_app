import 'calc_service.dart';
import '../data/calc_data.dart';
import '../state/function_state.dart';

class CalcFunctionService extends CalcService {
  MyFunctionState? state;
  void initWithState( MyFunctionState state ){
    this.state = state;
    super.init();
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
  @override
  void angleChanged( int type ){
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
}
