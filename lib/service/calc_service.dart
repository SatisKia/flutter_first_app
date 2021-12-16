import 'dart:math';

import '../data/calc_data.dart';
import '../data.dart';

class CalcService {
  final double _pi        = 3.14159265358979323846264;	// 円周率
  final double _normalize = 0.434294481903251816668;	// 1/log(10)

  void setDispError( int type ){}
  void setDispResult( double value ){}
  void setDispEntry( String entry ){}
  void clearDispLog(){}
  void setDispLog( double value, int opType ){}
  void addDispLog( double value ){}
  void setDispAnswer( double value ){}
  void setDispMemory( double value ){}
  void memoryRecalled( bool flag ){}
  void angleChanged( int type ){}
  void entryChanged( bool flag ){}
  void errorChanged( bool flag ){}

  void init(){
    setEntry( MyData.calc.answer );	// 計算結果をセット
    updateEntryStr( true );
    MyData.calc.opFlag = true;	// 次に数値入力ボタンが押された場合に_procOpが発動するように
    MyData.calc.opType = CalcData.opTypeSet;
    MyData.calc.nextOpType = CalcData.opTypeSet;
    MyData.calc.errorFlag = false;

    clearDispLog();	// 最初に実行する
    setDispEntry( MyData.calc.entryStr );
    setDispAnswer( MyData.calc.answer );
    setDispMemory( MyData.calc.memory );
    memoryRecalled( MyData.calc.memoryRecalled );
    angleChanged( MyData.calc.angleType );
    entryChanged( MyData.calc.entryFlag );
    errorChanged( MyData.calc.errorFlag );
  }

  // 浮動小数点数表記文字列の最適化
  String valueToString( double value, int prec ){
    String str1 = value.toStringAsPrecision( prec );
    String str2 = "";
    int top = str1.indexOf( "e" );
    if( top >= 0 ){
      str2 = str1.substring( top, str1.length );
      str1 = str1.substring( 0, top );
    }
    int min = str1.indexOf( "." );
    if( min >= 0 ){
      int len = str1.length;
      while( len > min ){
        String tmp = str1.substring( len - 1, len );
        if( tmp != "0" && tmp != "." ){
          break;
        }
        len--;
      }
      str1 = str1.substring( 0, len );
    }
    return str1 + str2;
  }

  // 入力値
  void updateEntryStr( testFlag ){
    if( !MyData.calc.entryFlag ){
      MyData.calc.entryStr = valueToString( MyData.calc.entry, 15 );
      if( !testFlag ){
        MyData.calc.entryFlag = true;
        entryChanged( MyData.calc.entryFlag );
      }
    }
  }
  void setEntry( double value ){
    MyData.calc.entry = value;
    MyData.calc.entryFlag = false;
    entryChanged( MyData.calc.entryFlag );

    if( MyData.calc.entry.isInfinite ){
      MyData.calc.errorFlag = true;
      MyData.calc.errorType = (MyData.calc.entry == double.negativeInfinity) ? CalcData.errorTypeNegativeInfinity : CalcData.errorTypePositiveInfinity;
      errorChanged( MyData.calc.errorFlag );
    } else if( MyData.calc.entry.isNaN ){
      MyData.calc.errorFlag = true;
      MyData.calc.errorType = CalcData.errorTypeNotANumber;
      errorChanged( MyData.calc.errorFlag );
    }
  }
  double getEntry(){
    return MyData.calc.entryFlag ? double.parse( MyData.calc.entryStr ) : MyData.calc.entry;
  }
  bool isEntry(){
    return MyData.calc.entryFlag;
  }

  // メモリーの操作
  void setMemoryRecalled( bool recalled ){
    MyData.calc.memoryRecalled = recalled;
    memoryRecalled( recalled );
  }
  void addMemory(){
    MyData.calc.memory += MyData.calc.answer;
    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemory | CalcData.saveMemoryRecalled );
    setDispMemory( MyData.calc.memory );
  }
  void subMemory(){
    MyData.calc.memory -= MyData.calc.answer;
    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemory | CalcData.saveMemoryRecalled );
    setDispMemory( MyData.calc.memory );
  }
  void recallMemory(){
    if( MyData.calc.opType == CalcData.opTypeSet ){
      clearDispLog();
    }

    setEntry( MyData.calc.memory );
    updateEntryStr( true );
    _setDispStr( false );

    setMemoryRecalled( true );
    MyData.calc.save( CalcData.saveMemoryRecalled );
  }
  void clearMemory(){
    MyData.calc.memory = 0.0;
    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemory | CalcData.saveMemoryRecalled );
    setDispMemory( MyData.calc.memory );
  }
  bool isMemoryRecalled(){
    return MyData.calc.memoryRecalled;
  }

  // 入力値の操作
  void clearEntry( allFlag ){
    setEntry( 0.0 );
    MyData.calc.entryStr = "0";
    MyData.calc.opFlag = false;
    MyData.calc.errorFlag = false;
    errorChanged( MyData.calc.errorFlag );

    setMemoryRecalled( false );

    if( MyData.calc.opType == CalcData.opTypeSet || allFlag ){
      MyData.calc.answer = 0.0;
      MyData.calc.save( CalcData.saveMemoryRecalled | CalcData.saveAnswer );
      setDispAnswer( MyData.calc.answer );
      MyData.calc.opType = CalcData.opTypeSet;
      clearDispLog();
    } else {
      MyData.calc.save( CalcData.saveMemoryRecalled );
    }
    _setDispStr( false );
  }
  void delEntry(){
    updateEntryStr( false );
    if( MyData.calc.entryStr.length == 1 ){
      MyData.calc.entryStr = "0";
    } else {
      MyData.calc.entryStr = MyData.calc.entryStr.substring( 0, MyData.calc.entryStr.length - 1 );
    }
    _setDispStr( false );

    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemoryRecalled );
  }
  void clearAndSetEntry( double value ){
    if( MyData.calc.opType == CalcData.opTypeSet ){
      clearDispLog();
    }

    setEntry( value );
    updateEntryStr( true );
    _setDispStr( false );

    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemoryRecalled );
  }
  void addNumber( chr ){
    _procOp();
    updateEntryStr( false );
    if( MyData.calc.entryStr.contains( "." ) ){
      MyData.calc.entryStr += chr;
    } else if( double.parse( MyData.calc.entryStr ) == 0.0 ){
      MyData.calc.entryStr = chr;
    } else {
      MyData.calc.entryStr += chr;
    }
    _setDispStr( false );

    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemoryRecalled );
  }
  void addPoint(){
    _procOp();
    updateEntryStr( false );
    if( !MyData.calc.entryStr.contains( "." ) ){
      MyData.calc.entryStr += ".";
    }
    _setDispStr( false );

    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemoryRecalled );
  }

  // 符号反転
  void negative(){
    clearAndSetEntry( 0.0 - getEntry() );
  }

  void setAngle( int type ){
    MyData.calc.angleType = type;
    MyData.calc.save( CalcData.saveAngleType );

    angleChanged( MyData.calc.angleType );
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
    clearAndSetEntry( getEntry().toInt().toDouble() );
  }

  // 演算の予約
  void setOp( type ){
    MyData.calc.opFlag = true;
    MyData.calc.nextOpType = type;
    _procOp();	// 前回の演算を実行
    if( type == CalcData.opTypeSet ){
      setEntry( MyData.calc.answer );	// 計算結果をセット
      updateEntryStr( true );
      MyData.calc.opFlag = true;	// 次に数値入力ボタンが押された場合に_procOpが発動するように
    }
    _setDispStr( true );

    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemoryRecalled );
  }

  // 演算の実行
  bool _procOp(){
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
        return false;
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
    return true;
  }

  void _setDispStr( bool opFlag ){
    if( MyData.calc.errorFlag ){
      setDispError( MyData.calc.errorType );
    } else if( opFlag && double.parse( MyData.calc.entryStr ) == 0 && MyData.calc.answer != 0 ){
      setDispResult( MyData.calc.answer );
    } else {
      setDispEntry( MyData.calc.entryStr );
    }
  }

  bool isError(){
    return MyData.calc.errorFlag;
  }
}
