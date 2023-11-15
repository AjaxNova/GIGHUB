import 'package:flutter/foundation.dart';

class SearchScreenProvider extends ChangeNotifier {
  bool isSearching = false;

  String searchName = "";

  isSearchingToFalse() {
    isSearching = false;
    notifyListeners();
  }

  isSearchinTotrue() {
    isSearching = true;
    notifyListeners();
  }

  setSearchName(String query) {
    searchName = query;
    notifyListeners();
  }

  clearSearchName() {
    searchName = "";
    notifyListeners();
  }
}
