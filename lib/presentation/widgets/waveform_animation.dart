import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'dart:math';

class WaveformAnimation extends StatefulWidget {
  const WaveformAnimation({Key? key}) : super(key: key);

  @override
  State<WaveformAnimation> createState() => _WaveformAnimationState();
}

class _WaveformAnimationState extends State<WaveformAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
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
      children: List.generate(7, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Create a wave effect using sine wave offset by index
            double wave = sin((_controller.value * 2 * pi) + (index * 0.8));
            // Normalize wave to be between 0 and 1
            double normalizedWave = (wave + 1) / 2;
            
            // Height between 15 and 50
            double height = 15 + (normalizedWave * 35);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 6,
              height: height,
              decoration: BoxDecoration(
                color: AppColors.micListening,
                borderRadius: BorderRadius.circular(3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.micListening.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
