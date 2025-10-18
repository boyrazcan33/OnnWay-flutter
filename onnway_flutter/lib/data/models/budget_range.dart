// lib/data/models/budget_range.dart
enum BudgetRange {
  BUDGET,
  MID_RANGE,
  PREMIUM;

  String get displayName {
    switch (this) {
      case BudgetRange.BUDGET:
        return 'Budget Friendly';
      case BudgetRange.MID_RANGE:
        return 'Mid Range';
      case BudgetRange.PREMIUM:
        return 'Premium';
    }
  }
}