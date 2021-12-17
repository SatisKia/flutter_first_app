import 'service/calc_function_service.dart';
import 'service/calc_number_service.dart';
import 'service/calc_service.dart';

class MyService {
  static CalcService calc = CalcService();
  static CalcNumberService calcNumber = CalcNumberService();
  static CalcFunctionService calcFunction = CalcFunctionService();
}
