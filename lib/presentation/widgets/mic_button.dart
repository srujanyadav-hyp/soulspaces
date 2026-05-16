import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../providers/home_provider.dart';

class MicButton extends StatefulWidget {
  final AppState state;
  final VoidCallback onTap;

  const MicButton({Key? key, required this.state, required this.onTap}) : super(key: key);

  @override
  State<MicButton> createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color micColor;
    List<BoxShadow> shadows;
    String label;

    switch (widget.state) {
      case AppState.idle:
        micColor = AppColors.micIdle;
        shadows = AppShadows.micIdle;
        label = "ట్యాప్ చేయండి"; // Tap to speak
        break;
      case AppState.listening:
        micColor = AppColors.micListening;
        shadows = AppShadows.micListening;
        label = "వింటున్నాను..."; // Listening
        break;
      case AppState.processing:
        micColor = AppColors.micProcessing;
        shadows = [];
        label = "ఆలోచిస్తున్నాను..."; // Thinking
        break;
      case AppState.speaking:
        micColor = AppColors.micSpeaking;
        shadows = AppShadows.micSpeaking;
        label = "దేవుడు మాట్లాడుతున్నాడు"; // God is speaking
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: widget.state == AppState.processing ? null : widget.onTap,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double scale = (widget.state == AppState.listening) 
                  ? 1.0 + (_controller.value * 0.15) 
                  : 1.0;
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: AppSpacing.micButtonSize,
                  height: AppSpacing.micButtonSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: micColor,
                    boxShadow: shadows,
                  ),
                  child: Icon(
                    widget.state == AppState.listening ? AppIcons.micOn : AppIcons.micOff,
                    size: 32,
                    color: AppColors.backgroundDeep,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          label,
          style: AppTextStyles.micLabel,
        ),
      ],
    );
  }
}
