import 'package:intl/intl.dart';

String formatCurrency(dynamic amount, String currencyCode) {
  if (amount == null) return '0';
  
  final formatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: currencyCode + ' ',
    decimalDigits: 0, // Set to 0 to remove decimal places
  );
  
  try {
    // Convert to double first to handle both int and double inputs
    double numericAmount = double.parse(amount.toString());
    return formatter.format(numericAmount);
  } catch (e) {
    print('Error formatting currency: $e');
    return '$currencyCode 0';
  }
} 