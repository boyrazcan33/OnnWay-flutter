// lib/providers/form_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/city.dart';
import '../data/models/activity_type.dart';
import '../data/models/budget_range.dart';
import '../data/models/duration.dart';

// Form state providers
final selectedCityProvider = StateProvider<City?>((ref) => null);
final selectedActivityProvider = StateProvider<ActivityType?>((ref) => null);
final selectedBudgetProvider = StateProvider<BudgetRange?>((ref) => null);
final selectedDurationProvider = StateProvider<Duration?>((ref) => null);

// Form validation provider
final isFormValidProvider = Provider<bool>((ref) {
  final city = ref.watch(selectedCityProvider);
  final activity = ref.watch(selectedActivityProvider);
  final budget = ref.watch(selectedBudgetProvider);
  final duration = ref.watch(selectedDurationProvider);

  return city != null &&
      activity != null &&
      budget != null &&
      duration != null;
});