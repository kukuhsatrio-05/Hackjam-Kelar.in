import 'package:flutter/material.dart';

class TugasViewModel extends ChangeNotifier {
  String _searchQuery = '';
  String _selectedFilter = 'Semua';

  String get searchQuery => _searchQuery;
  String get selectedFilter => _selectedFilter;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }
}
