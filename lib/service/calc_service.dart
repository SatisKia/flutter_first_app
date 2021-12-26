import '../data.dart';
import '../data/calc_data.dart';

class CalcService {
  void setDispError( int type ){}
  void setDispResult( double value ){}
  void setDispEntry( String entry ){}
  void clearDispLog(){}
  void setDispLog( double value, int opType ){}
  void addDispLog( double value ){}
  void setDispAnswer( double value ){}
  void setDispMemory( double value ){}
  void memoryRecalled( bool flag ){}
  void entryChanged( bool flag ){}
  void errorChanged( bool flag ){}

  void init(){
    setEntry( MyData.calc.answer );	// 計算結果をセット
    updateEntryStr( true );
    MyData.calc.opFlag = true;	// 次に数値入力ボタンが押された場合にprocOpが発動するように
    MyData.calc.opType = CalcData.opTypeSet;
    MyData.calc.nextOpType = CalcData.opTypeSet;
    MyData.calc.errorFlag = false;

    clearDispLog();	// 最初に実行する
    setDispEntry( MyData.calc.entryStr );
    setDispAnswer( MyData.calc.answer );
    setDispMemory( MyData.calc.memory );
    memoryRecalled( MyData.calc.memoryRecalled );
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

  // 桁区切り
  String sepString( String str, String sep ){
    try {
      double tmp = double.parse(str);
      if( tmp.isInfinite || tmp.isNaN ){
        return str;
      }
    } catch( e ){
      return str;
    }

    String src = '';
    String dst = '';
    int top;
    int end;
    bool _float;
    bool _break;
    int len;

    src = str;
    dst = '';
    top = 0;
    while( true ){
      _float = false;

      // 先頭を求める
      _break = false;
      for( ; top < src.length; top++ ){
        switch( src.substring( top, top + 1 ) ){
          case '+':
          case '-':
          case '.':
          case 'e':
          case 'E':
            if( src.substring( top, top + 1 ) == '.' ){
              _float = true;
            }
            dst += src.substring( top, top + 1 );
            break;
          default:
            _break = true;
            break;
        }
        if( _break ){
          break;
        }
      }
      if( top >= src.length ){
        break;
      }

      // 末尾を求める
      _break = false;
      for( end = top + 1; end < src.length; end++ ){
        switch( src.substring( end, end + 1 ) ){
          case '+':
          case '-':
          case '.':
          case 'e':
          case 'E':
            _break = true;
            break;
        }
        if( _break ){
          break;
        }
      }

      for( len = end - top; len > 0; len-- ){
        dst += src.substring( top, top + 1 );
        top++;
        if( !_float && (len != 1) && ((len % 3) == 1) ){
          dst += sep;
        }
      }
    }

    return dst;
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
    setDispStr( false );

    setMemoryRecalled( true );
    MyData.calc.save( CalcData.saveMemoryRecalled );
  }
  void clearMemory(){
    MyData.calc.memory = 0.0;
    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemory | CalcData.saveMemoryRecalled );
    setDispMemory( MyData.calc.memory );
  }

  // 入力値の操作
  void clearEntry( bool allFlag ){
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
    setDispStr( false );
  }
  void clearAndSetEntry( double value ){
    if( MyData.calc.opType == CalcData.opTypeSet ){
      clearDispLog();
    }

    setEntry( value );
    updateEntryStr( true );
    setDispStr( false );

    setMemoryRecalled( false );
    MyData.calc.save( CalcData.saveMemoryRecalled );
  }
  void setDispStr( bool opFlag ){
    if( MyData.calc.errorFlag ){
      setDispError( MyData.calc.errorType );
    } else if( opFlag && double.parse( MyData.calc.entryStr ) == 0 && MyData.calc.answer != 0 ){
      setDispResult( MyData.calc.answer );
    } else {
      setDispEntry( MyData.calc.entryStr );
    }
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
  bool procOp(){
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
}
