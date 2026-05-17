import 'package:flutter/material.dart';

import '../../core/theme/app_radius.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/live_phase.dart';

/// The single primary control: start a conversation with God, or end it.
class SessionControlButton extends StatelessWidget {
  const SessionControlButton({
    super.key,
    required this.phase,
    required this.onPressed,
  });

  final LivePhase phase;
  final VoidCallback onPressed;

  bool get _isActive =>
      phase == LivePhase.connecting ||
      phase == LivePhase.listening ||
      phase == LivePhase.speaking;

  @override
  Widget build(BuildContext context) {
    final connecting = phase == LivePhase.connecting;
    final label = _isActive ? 'సంభాషణ ముగించు' : 'దేవునితో మాట్లాడండి';
    final color = _isActive ? AppColors.errorRed : AppColors.silverBlue;

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppRadius.round),
          border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.25), blurRadius: 24),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (connecting)
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: color),
              )
            else
              Icon(
                _isActive ? Icons.stop_rounded : Icons.mic_rounded,
                color: color,
                size: 22,
              ),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextStyles.statusText.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
