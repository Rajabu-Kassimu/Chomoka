import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyProvider with ChangeNotifier {
  String _currencyCode = 'TZS';

  CurrencyProvider() {
    _initCurrency();
  }

  String get currencyCode => _currencyCode;

  Future<void> _initCurrency() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedCountry = prefs.getString('selected_country');
      if (savedCountry != null) {
        _currencyCode = _getCurrencyForCountry(savedCountry);
        notifyListeners();
      }
    } catch (e) {
      print('Error initializing currency: $e');
    }
  }

  void setCurrency(String code) {
    _currencyCode = code;
    notifyListeners();
  }

  // Helper to map country to currency code
  String _getCurrencyForCountry(String country) {
    switch (country) {
      case 'Tanzania':
        return 'TZS';
      case 'Kenya':
        return 'KES';
      case 'Uganda':
        return 'UGX';
      case 'Rwanda':
        return 'RWF';
      case 'Burundi':
        return 'BIF';
      case 'South Africa':
        return 'ZAR';
      case 'Ethiopia':
        return 'ETB';
      default:
        return 'TZS';
    }
  }
} 