// lib/ui/screens/city_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/city.dart';
import '../../data/models/activity_type.dart';
import '../../data/models/budget_range.dart';
import '../../data/models/duration.dart';
import '../../providers/form_provider.dart';
import '../components/city_card.dart';
import '../theme/colors.dart';

class CitySelectionScreen extends ConsumerWidget {
  final VoidCallback onApply;
  final bool isLoading;

  const CitySelectionScreen({
    super.key,
    required this.onApply,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCity = ref.watch(selectedCityProvider);
    final selectedActivity = ref.watch(selectedActivityProvider);
    final selectedBudget = ref.watch(selectedBudgetProvider);
    final selectedDuration = ref.watch(selectedDurationProvider);
    final isFormValid = ref.watch(isFormValidProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // City Cards
          Row(
            children: [
              // Tallinn
              Expanded(
                child: CityCard(
                  city: City.TALLINN,
                  title: '🇪🇪 Tallinn',
                  subtitle: "Explore Estonia's medieval capital",
                  isSelected: selectedCity == City.TALLINN,
                  isBlurred: selectedCity != null && selectedCity != City.TALLINN,
                  backgroundColor: tallinnColor,
                  onTap: () => ref.read(selectedCityProvider.notifier).state = City.TALLINN,
                ),
              ),

              const SizedBox(width: 16),

              // Istanbul
              Expanded(
                child: CityCard(
                  city: City.ISTANBUL,
                  title: '🇹🇷 Istanbul',
                  subtitle: 'Where Europe meets Asia',
                  isSelected: selectedCity == City.ISTANBUL,
                  isBlurred: selectedCity != null && selectedCity != City.ISTANBUL,
                  backgroundColor: istanbulColor,
                  onTap: () => ref.read(selectedCityProvider.notifier).state = City.ISTANBUL,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Parameters Section
          if (selectedCity != null) ...[
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Your Preferences',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    const SizedBox(height: 24),

                    // Activity Type
                    _ParameterSection(
                      title: 'Activity Type',
                      options: ActivityType.values,
                      selectedOption: selectedActivity,
                      onSelect: (value) => ref.read(selectedActivityProvider.notifier).state = value,
                      getLabel: (type) => type.displayName,
                    ),

                    const SizedBox(height: 24),

                    // Budget Range
                    _ParameterSection(
                      title: 'Budget Range',
                      options: BudgetRange.values,
                      selectedOption: selectedBudget,
                      onSelect: (value) => ref.read(selectedBudgetProvider.notifier).state = value,
                      getLabel: (budget) => budget.displayName,
                    ),

                    const SizedBox(height: 24),

                    // Duration
                    _ParameterSection(
                      title: 'Trip Duration',
                      options: Duration.values,
                      selectedOption: selectedDuration,
                      onSelect: (value) => ref.read(selectedDurationProvider.notifier).state = value,
                      getLabel: (duration) => duration.displayName,
                    ),

                    const SizedBox(height: 32),

                    // Apply Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isFormValid && !isLoading ? onApply : null,
                        child: Text(
                          isLoading ? 'CREATING ROUTE...' : 'CREATE MY ROUTE',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _ParameterSection<T> extends StatelessWidget {
  final String title;
  final List<T> options;
  final T? selectedOption;
  final Function(T) onSelect;
  final String Function(T) getLabel;

  const _ParameterSection({
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onSelect,
    required this.getLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        ...options.map((option) => _ParameterOption(
          label: getLabel(option),
          isSelected: option == selectedOption,
          onTap: () => onSelect(option),
        )),
      ],
    );
  }
}

class _ParameterOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ParameterOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? primaryColor.withOpacity(0.1)
                : lightGrayColor,
            borderRadius: BorderRadius.circular(8),
            border: isSelected
                ? Border.all(color: primaryColor, width: 2)
                : null,
          ),
          child: Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: isSelected,
                onChanged: (_) => onTap(),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? primaryColor : darkGrayColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}