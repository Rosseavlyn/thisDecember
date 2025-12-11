import 'package:flutter/material.dart';

class PalindromeProvider extends ChangeNotifier {
  bool _isPalindrome = false;

  bool get isPalindromeResult => _isPalindrome;

  bool checkPalindrome(String text) {
    String clean = text.replaceAll(" ", "").toLowerCase();
    String reversed = clean.split('').reversed.join('');
    _isPalindrome = clean == reversed;
    notifyListeners();
    return _isPalindrome;
  }
}
