// lib/ui/components/city_card.dart
import 'package:flutter/material.dart';
import '../../data/models/city.dart';

class CityCard extends StatelessWidget {
  final City city;
  final String title;
  final String subtitle;
  final bool isSelected;
  final bool isBlurred;
  final Color backgroundColor;
  final VoidCallback onTap;

  const CityCard({
    super.key,
    required this.city,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.isBlurred,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imagePath = city == City.TALLINN
        ? 'assets/images/tallinn.jpg'
        : 'assets/images/istanbul.jpg';

    return Opacity(
      opacity: isBlurred ? 0.4 : 1.0,
      child: Card(
        elevation: isSelected ? 8 : 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isSelected
              ? BorderSide(color: backgroundColor, width: 3)
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: isBlurred ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: backgroundColor.withOpacity(0.3),
                        child: Icon(
                          Icons.location_city,
                          size: 100,
                          color: backgroundColor,
                        ),
                      );
                    },
                  ),
                ),

                // Dark Overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}