import 'package:intl/intl.dart';

abstract class Utils {
  
  static String convCurrency(double value) => NumberFormat.simpleCurrency().format(value);

}