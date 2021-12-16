import 'calc_service.dart';
import '../data/calc_data.dart';
import '../state/number_state.dart';

class CalcNumberService extends CalcService {
  MyNumberState? state;
  void initWithState( MyNumberState state ){
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
  void clearDispLog(){
    state!.dispLog = "";
  }
  @override
  void setDispLog( value, opType ){
    if( opType == CalcData.opTypeDiv ){ state!.dispLog = valueToString( value, 10 ) + " ÷"; }
    if( opType == CalcData.opTypeMul ){ state!.dispLog = valueToString( value, 10 ) + " ×"; }
    if( opType == CalcData.opTypeSub ){ state!.dispLog = valueToString( value, 10 ) + " -"; }
    if( opType == CalcData.opTypeAdd ){ state!.dispLog = valueToString( value, 10 ) + " +"; }
  }
  @override
  void addDispLog( value ){
    state!.dispLog += " " + valueToString( value, 10 ) + " =";
  }
  @override
  void setDispAnswer( value ){
    state!.dispAnswer = valueToString( value, 10 );
  }
  @override
  void setDispMemory( value ){
    state!.dispMemory = valueToString( value, 10 );
  }
  @override
  void memoryRecalled( bool flag ){
    state!.mrcButtonText = flag ? "MC" : "MR";
  }
}
