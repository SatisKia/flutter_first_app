import '../model.dart';
import '../model/calc_model.dart';

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
    setEntry( MyModel.calc.answer );	// 計算結果をセット
    updateEntryStr( true );
    MyModel.calc.opFlag = true;	// 次に数値入力ボタンが押された場合にprocOpが発動するように
    MyModel.calc.opType = CalcModel.opTypeSet;
    MyModel.calc.nextOpType = CalcModel.opTypeSet;
    MyModel.calc.errorFlag = false;

    clearDispLog();	// 最初に実行する
    setDispEntry( MyModel.calc.entryStr );
    setDispAnswer( MyModel.calc.answer );
    setDispMemory( MyModel.calc.memory );
    memoryRecalled( MyModel.calc.memoryRecalled );
    entryChanged( MyModel.calc.entryFlag );
    errorChanged( MyModel.calc.errorFlag );
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
    if( !MyModel.calc.entryFlag ){
      MyModel.calc.entryStr = valueToString( MyModel.calc.entry, 15 );
      if( !testFlag ){
        MyModel.calc.entryFlag = true;
        entryChanged( MyModel.calc.entryFlag );
      }
    }
  }
  void setEntry( double value ){
    MyModel.calc.entry = value;
    MyModel.calc.entryFlag = false;
    entryChanged( MyModel.calc.entryFlag );

    if( MyModel.calc.entry.isInfinite ){
      MyModel.calc.errorFlag = true;
      MyModel.calc.errorType = (MyModel.calc.entry == double.negativeInfinity) ? CalcModel.errorTypeNegativeInfinity : CalcModel.errorTypePositiveInfinity;
      errorChanged( MyModel.calc.errorFlag );
    } else if( MyModel.calc.entry.isNaN ){
      MyModel.calc.errorFlag = true;
      MyModel.calc.errorType = CalcModel.errorTypeNotANumber;
      errorChanged( MyModel.calc.errorFlag );
    }
  }
  double getEntry(){
    return MyModel.calc.entryFlag ? double.parse( MyModel.calc.entryStr ) : MyModel.calc.entry;
  }

  // メモリーの操作
  void setMemoryRecalled( bool recalled ){
    MyModel.calc.memoryRecalled = recalled;
    memoryRecalled( recalled );
  }
  void addMemory(){
    MyModel.calc.memory += MyModel.calc.answer;
    setMemoryRecalled( false );
    MyModel.calc.save( CalcModel.saveMemory | CalcModel.saveMemoryRecalled );
    setDispMemory( MyModel.calc.memory );
  }
  void subMemory(){
    MyModel.calc.memory -= MyModel.calc.answer;
    setMemoryRecalled( false );
    MyModel.calc.save( CalcModel.saveMemory | CalcModel.saveMemoryRecalled );
    setDispMemory( MyModel.calc.memory );
  }
  void recallMemory(){
    if( MyModel.calc.opType == CalcModel.opTypeSet ){
      clearDispLog();
    }

    setEntry( MyModel.calc.memory );
    updateEntryStr( true );
    setDispStr( false );

    setMemoryRecalled( true );
    MyModel.calc.save( CalcModel.saveMemoryRecalled );
  }
  void clearMemory(){
    MyModel.calc.memory = 0.0;
    setMemoryRecalled( false );
    MyModel.calc.save( CalcModel.saveMemory | CalcModel.saveMemoryRecalled );
    setDispMemory( MyModel.calc.memory );
  }

  // 入力値の操作
  void clearEntry( bool allFlag ){
    setEntry( 0.0 );
    MyModel.calc.entryStr = "0";
    MyModel.calc.opFlag = false;
    MyModel.calc.errorFlag = false;
    errorChanged( MyModel.calc.errorFlag );

    setMemoryRecalled( false );

    if( MyModel.calc.opType == CalcModel.opTypeSet || allFlag ){
      MyModel.calc.answer = 0.0;
      MyModel.calc.save( CalcModel.saveMemoryRecalled | CalcModel.saveAnswer );
      setDispAnswer( MyModel.calc.answer );
      MyModel.calc.opType = CalcModel.opTypeSet;
      clearDispLog();
    } else {
      MyModel.calc.save( CalcModel.saveMemoryRecalled );
    }
    setDispStr( false );
  }
  void clearAndSetEntry( double value ){
    if( MyModel.calc.opType == CalcModel.opTypeSet ){
      clearDispLog();
    }

    setEntry( value );
    updateEntryStr( true );
    setDispStr( false );

    setMemoryRecalled( false );
    MyModel.calc.save( CalcModel.saveMemoryRecalled );
  }
  void setDispStr( bool opFlag ){
    if( MyModel.calc.errorFlag ){
      setDispError( MyModel.calc.errorType );
    } else if( opFlag && double.parse( MyModel.calc.entryStr ) == 0 && MyModel.calc.answer != 0 ){
      setDispResult( MyModel.calc.answer );
    } else {
      setDispEntry( MyModel.calc.entryStr );
    }
  }
}
