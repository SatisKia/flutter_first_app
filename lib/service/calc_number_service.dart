import '../model.dart';
import '../model/calc_model.dart';
import '../view_model/number_view_model.dart';
import 'calc_service.dart';

class CalcNumberService extends CalcService {
  MyNumberState? state;
  void initWithState( MyNumberState state ){
    this.state = state;

    super.init();
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
  void clearDispLog(){
    state!.dispLog = "";
  }
  @override
  void setDispLog( value, opType ){
    if( opType == CalcModel.opTypeDiv ){ state!.dispLog = valueToString( value, 10 ) + " ÷"; }
    if( opType == CalcModel.opTypeMul ){ state!.dispLog = valueToString( value, 10 ) + " ×"; }
    if( opType == CalcModel.opTypeSub ){ state!.dispLog = valueToString( value, 10 ) + " -"; }
    if( opType == CalcModel.opTypeAdd ){ state!.dispLog = valueToString( value, 10 ) + " +"; }
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
    if( MyModel.calc.entryStr.length == 1 ){
      MyModel.calc.entryStr = "0";
    } else {
      MyModel.calc.entryStr = MyModel.calc.entryStr.substring( 0, MyModel.calc.entryStr.length - 1 );
    }
    setDispStr( false );

    setMemoryRecalled( false );
    MyModel.calc.save( CalcModel.saveMemoryRecalled );
  }
  void addNumber( chr ){
    procOp();
    updateEntryStr( false );
    if( MyModel.calc.entryStr.contains( "." ) ){
      MyModel.calc.entryStr += chr;
    } else if( double.parse( MyModel.calc.entryStr ) == 0.0 ){
      MyModel.calc.entryStr = chr;
    } else {
      MyModel.calc.entryStr += chr;
    }
    setDispStr( false );

    setMemoryRecalled( false );
    MyModel.calc.save( CalcModel.saveMemoryRecalled );
  }
  void addPoint(){
    procOp();
    updateEntryStr( false );
    if( !MyModel.calc.entryStr.contains( "." ) ){
      MyModel.calc.entryStr += ".";
    }
    setDispStr( false );

    setMemoryRecalled( false );
    MyModel.calc.save( CalcModel.saveMemoryRecalled );
  }

  // 符号反転
  void negative(){
    clearAndSetEntry( 0.0 - getEntry() );
  }

  // 演算の予約
  void setOp( type ){
    MyModel.calc.opFlag = true;
    MyModel.calc.nextOpType = type;
    procOp();	// 前回の演算を実行

    if( type == CalcModel.opTypeSet ){
      setEntry( MyModel.calc.answer );	// 計算結果をセット
      updateEntryStr( true );
      MyModel.calc.opFlag = true;	// 次に数値入力ボタンが押された場合にprocOpが発動するように
    }
    setDispStr( true );

    setMemoryRecalled( false );
    MyModel.calc.save( CalcModel.saveMemoryRecalled );
  }

  // 演算の実行
  void procOp(){
    if( MyModel.calc.opFlag ){
      if( MyModel.calc.opType == CalcModel.opTypeSet ){
        MyModel.calc.answer = getEntry();
        MyModel.calc.save( CalcModel.saveAnswer );
      } else if( MyModel.calc.opType == CalcModel.opTypeDiv ){
        double value = getEntry();
        if( value == 0.0 ){
          MyModel.calc.errorFlag = true;
          MyModel.calc.errorType = CalcModel.errorTypeDivideByZero;
          errorChanged( MyModel.calc.errorFlag );
        } else {
          MyModel.calc.answer /= value;
          MyModel.calc.save( CalcModel.saveAnswer );
        }
      } else if( MyModel.calc.opType == CalcModel.opTypeMul ){
        MyModel.calc.answer *= getEntry();
        MyModel.calc.save( CalcModel.saveAnswer );
      } else if( MyModel.calc.opType == CalcModel.opTypeSub ){
        MyModel.calc.answer -= getEntry();
        MyModel.calc.save( CalcModel.saveAnswer );
      } else if( MyModel.calc.opType == CalcModel.opTypeAdd ){
        MyModel.calc.answer += getEntry();
        MyModel.calc.save( CalcModel.saveAnswer );
      }
      if( MyModel.calc.errorFlag ){
        return;
      }
      setDispAnswer( MyModel.calc.answer );

      if( MyModel.calc.opType != CalcModel.opTypeSet && MyModel.calc.nextOpType == CalcModel.opTypeSet ){
        updateEntryStr( true );
        addDispLog( getEntry() );
      } else {
        if( MyModel.calc.nextOpType == CalcModel.opTypeSet ){
          clearDispLog();
        } else {
          setDispLog( MyModel.calc.answer, MyModel.calc.nextOpType );
        }
      }

      // 計算が終わったらクリア
      setEntry( 0.0 );
      MyModel.calc.entryStr = "0";

      MyModel.calc.opFlag = false;
      MyModel.calc.opType = MyModel.calc.nextOpType;
    }
  }
}
