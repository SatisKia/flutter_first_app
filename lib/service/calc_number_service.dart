import 'calc_service.dart';
import '../data.dart';
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

  // 入力値の操作
  void delEntry(){
    updateEntryStr( false );
    if( MyData.calc.entryStr.length == 1 ){
      MyData.calc.entryStr = "0";
    } else {
      MyData.calc.entryStr = MyData.calc.entryStr.substring( 0, MyData.calc.entryStr.length - 1 );
    }
    setDispStr( false );

    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemoryRecalled );
  }
  void addNumber( chr ){
    procOp();
    updateEntryStr( false );
    if( MyData.calc.entryStr.contains( "." ) ){
      MyData.calc.entryStr += chr;
    } else if( double.parse( MyData.calc.entryStr ) == 0.0 ){
      MyData.calc.entryStr = chr;
    } else {
      MyData.calc.entryStr += chr;
    }
    setDispStr( false );

    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemoryRecalled );
  }
  void addPoint(){
    procOp();
    updateEntryStr( false );
    if( !MyData.calc.entryStr.contains( "." ) ){
      MyData.calc.entryStr += ".";
    }
    setDispStr( false );

    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemoryRecalled );
  }

  // 符号反転
  void negative(){
    clearAndSetEntry( 0.0 - getEntry() );
  }

  // 演算の予約
  void setOp( type ){
    MyData.calc.opFlag = true;
    MyData.calc.nextOpType = type;
    procOp();	// 前回の演算を実行

    if( type == CalcData.opTypeSet ){
      setEntry( MyData.calc.answer );	// 計算結果をセット
      updateEntryStr( true );
      MyData.calc.opFlag = true;	// 次に数値入力ボタンが押された場合にprocOpが発動するように
    }
    setDispStr( true );

    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemoryRecalled );
  }

  // 演算の実行
  void procOp(){
    if( MyData.calc.opFlag ){
      if( MyData.calc.opType == CalcData.opTypeSet ){
        MyData.calc.answer = getEntry();
        MyData.calc.save( CalcData.saveAnswer );
      } else if( MyData.calc.opType == CalcData.opTypeDiv ){
        double value = getEntry();
        if( value == 0.0 ){
          MyData.calc.errorFlag = true;
          MyData.calc.errorType = CalcData.errorTypeDivideByZero;
          errorChanged( MyData.calc.errorFlag );
        } else {
          MyData.calc.answer /= value;
          MyData.calc.save( CalcData.saveAnswer );
        }
      } else if( MyData.calc.opType == CalcData.opTypeMul ){
        MyData.calc.answer *= getEntry();
        MyData.calc.save( CalcData.saveAnswer );
      } else if( MyData.calc.opType == CalcData.opTypeSub ){
        MyData.calc.answer -= getEntry();
        MyData.calc.save( CalcData.saveAnswer );
      } else if( MyData.calc.opType == CalcData.opTypeAdd ){
        MyData.calc.answer += getEntry();
        MyData.calc.save( CalcData.saveAnswer );
      }
      if( MyData.calc.errorFlag ){
        return;
      }
      setDispAnswer( MyData.calc.answer );

      if( MyData.calc.opType != CalcData.opTypeSet && MyData.calc.nextOpType == CalcData.opTypeSet ){
        updateEntryStr( true );
        addDispLog( getEntry() );
      } else {
        if( MyData.calc.nextOpType == CalcData.opTypeSet ){
          clearDispLog();
        } else {
          setDispLog( MyData.calc.answer, MyData.calc.nextOpType );
        }
      }

      // 計算が終わったらクリア
      setEntry( 0.0 );
      MyData.calc.entryStr = "0";

      MyData.calc.opFlag = false;
      MyData.calc.opType = MyData.calc.nextOpType;
    }
  }
}
