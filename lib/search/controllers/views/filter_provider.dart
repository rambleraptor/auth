import 'package:auth/search/controllers/data/filers.dart';
import 'package:riverpod/riverpod.dart';

class FilterTypeNotifier extends StateNotifier<FilterType> {
  FilterTypeNotifier() : super(FilterType.website);

  void changeFilter(FilterType t) {
    state = t;
  }
}

final filtersProvider = StateNotifierProvider<FilterTypeNotifier, FilterType>(
  (ref) {
    return FilterTypeNotifier();
  },
);
