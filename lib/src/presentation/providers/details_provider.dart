import 'package:flutter/material.dart';

class DetailsProvider extends ChangeNotifier {
  int count = 1;
  String? selectedSize;

  void selectSize(String size) {
    count = 1;
    selectedSize = size;
    notifyListeners();
  }

  void incrementCounter() {
    if (count == 99) {
      return;
    }

    ++count;
    notifyListeners();
  }

  void decrementCounter() {
    if (count == 1) {
      return;
    }

    --count;
    notifyListeners();
  }

  void clear() {
    count = 1;
    selectedSize = null;
    notifyListeners();
  }
}
