import 'package:flutter_riverpod/flutter_riverpod.dart';

class TugasState {
  final String searchQuery;
  final String selectedFilter;

  TugasState({this.searchQuery = '', this.selectedFilter = 'Semua'});

  TugasState copyWith({String? searchQuery, String? selectedFilter}) {
    return TugasState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}

// Menggunakan Notifier menggantikan StateNotifier
class TugasViewModel extends Notifier<TugasState> {
  @override
  TugasState build() {
    return TugasState(); // Initial state
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
  }
}

// Provider menggunakan NotifierProvider
final tugasViewModelProvider = NotifierProvider<TugasViewModel, TugasState>(
  TugasViewModel.new,
);
