import 'service/calc_function_service.dart';
import 'service/calc_number_service.dart';

class MyService {
  static CalcNumberService calcNumber = CalcNumberService();
  static CalcFunctionService calcFunction = CalcFunctionService();
}
