// lib/ui/components/loading_modal.dart
import 'package:flutter/material.dart';
import 'dancing_tourist.dart';

class LoadingModal extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onDismiss;

  const LoadingModal({
    super.key,
    required this.isVisible,
    required this.onDismiss,
  });

  @override
  State<LoadingModal> createState() => _LoadingModalState();
}

class _LoadingModalState extends State<LoadingModal> {
  int _currentMessageIndex = 0;

  final List<String> _messages = [
    'Teaching the map to dance too...',
    'Finding the best spots for you...',
    'Calculating walking distances...',
    'Optimizing your perfect route...',
    'Adding some travel magic...',
    'Almost ready for your adventure!',
  ];

  @override
  void initState() {
    super.initState();
    _startMessageRotation();
  }

  void _startMessageRotation() {
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted && widget.isVisible) {
        setState(() {
          _currentMessageIndex = (_currentMessageIndex + 1) % _messages.length;
        });
        _startMessageRotation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return const SizedBox.shrink();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dancing Tourist Animation
            const DancingTourist(),

            const SizedBox(height: 24),

            // Loading Message
            SizedBox(
              height: 60,
              child: Center(
                child: Text(
                  _messages[_currentMessageIndex],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Loading Dots
            const _LoadingDots(),

            const SizedBox(height: 24),

            // Cancel Button
            OutlinedButton(
              onPressed: widget.onDismiss,
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final delay = index * 0.16;
            final value = (_controller.value - delay).clamp(0.0, 1.0);

            return Opacity(
              opacity: value,
              child: Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}