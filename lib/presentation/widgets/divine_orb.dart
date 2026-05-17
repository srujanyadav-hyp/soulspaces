import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/entities/live_phase.dart';

/// A glowing orb at the heart of the screen. Its colour and motion respond
/// to the conversation [phase] — calm when idle, alive when God speaks.
class DivineOrb extends StatefulWidget {
  const DivineOrb({super.key, required this.phase, this.size = 220});

  final LivePhase phase;
  final double size;

  @override
  State<DivineOrb> createState() => _DivineOrbState();
}

class _DivineOrbState extends State<DivineOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _glowColor => switch (widget.phase) {
        LivePhase.idle => AppColors.silverBlue,
        LivePhase.connecting => AppColors.micProcessing,
        LivePhase.listening => AppColors.micListening,
        LivePhase.speaking => AppColors.micSpeaking,
        LivePhase.error => AppColors.errorRed,
      };

  /// How energetic the pulse is — speaking is the most alive.
  double get _intensity => switch (widget.phase) {
        LivePhase.speaking => 1.0,
        LivePhase.listening => 0.7,
        LivePhase.connecting => 0.7,
        LivePhase.idle => 0.4,
        LivePhase.error => 0.35,
      };

  @override
  Widget build(BuildContext context) {
    final color = _glowColor;
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Stack(
          alignment: Alignment.center,
          children: [
            _ring(_controller.value, color, 0.0),
            _ring(_controller.value, color, 0.5),
            child!,
          ],
        ),
        child: _core(color),
      ),
    );
  }

  /// One expanding, fading halo. [offset] phase-shifts a second ring.
  Widget _ring(double t, Color color, double offset) {
    final p = (t + offset) % 1.0;
    final scale = 0.5 + p * 0.5 * _intensity;
    final opacity = ((1.0 - p) * 0.5 * _intensity).clamp(0.0, 1.0);
    return Opacity(
      opacity: opacity,
      child: Container(
        width: widget.size * scale,
        height: widget.size * scale,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 24),
          ],
        ),
      ),
    );
  }

  /// The solid centre — the logo, haloed by the phase colour.
  Widget _core(Color color) {
    final coreSize = widget.size * 0.55;
    return Container(
      width: coreSize,
      height: coreSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.30), AppColors.backgroundCard],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.45),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipOval(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Image.asset('assets/images/logo.jpeg', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
