// lib/ui/components/dancing_tourist.dart
import 'package:flutter/material.dart';

class DancingTourist extends StatefulWidget {
  const DancingTourist({super.key});

  @override
  State<DancingTourist> createState() => _DancingTouristState();
}

class _DancingTouristState extends State<DancingTourist>
    with TickerProviderStateMixin {
  late AnimationController _moonwalkController;
  late AnimationController _textController;

  late Animation<double> _offsetX;
  late Animation<double> _scaleX;
  late Animation<double> _textOpacity;
  late Animation<double> _textOffsetY;

  @override
  void initState() {
    super.initState();

    // Moonwalk animation (4 seconds)
    _moonwalkController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat(reverse: true);

    _offsetX = Tween<double>(begin: 40, end: -40).animate(_moonwalkController);
    _scaleX = Tween<double>(begin: 1.0, end: 1.05).animate(_moonwalkController);

    // Text reveal animation
    _textController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat();

    _textOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 10),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 10),
    ]).animate(_textController);

    _textOffsetY = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(20.0), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 20.0, end: 0.0), weight: 10),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 10),
    ]).animate(_textController);
  }

  @override
  void dispose() {
    _moonwalkController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Character with moonwalk
          AnimatedBuilder(
            animation: _moonwalkController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_offsetX.value, 0),
                child: Transform.scale(
                  scaleX: _scaleX.value,
                  child: Image.asset(
                    'assets/images/mj_moonwalk.png',
                    width: 280,
                    height: 280,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 280);
                    },
                  ),
                ),
              );
            },
          ),

          // ONNWAY text
          Positioned(
            top: 30,
            right: 60,
            child: AnimatedBuilder(
              animation: _textController,
              builder: (context, child) {
                return Opacity(
                  opacity: _textOpacity.value,
                  child: Transform.translate(
                    offset: Offset(0, _textOffsetY.value),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        'ONNWAY',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4ECDC4),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}