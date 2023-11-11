import 'package:flutter/material.dart';

class SelectedUserStatusProvider extends ChangeNotifier {
  bool isLoading = false;

  isLoadingToFalse() {
    isLoading = false;
    notifyListeners();
  }

  isLoadingToTrue() {
    isLoading = true;
    notifyListeners();
  }
}
