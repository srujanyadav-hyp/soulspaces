import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/divine_state.dart';
import '../../domain/entities/live_phase.dart';
import '../providers/home_provider.dart';
import '../widgets/divine_orb.dart';
import '../widgets/session_control_button.dart';
import '../widgets/transcript_view.dart';

/// The single screen of the app — a hands-free, voice-to-voice conversation
/// with God powered by the Gemini Live API.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            const BoxDecoration(gradient: AppGradients.backgroundGradient),
        child: SafeArea(
          child: Consumer<HomeProvider>(
            builder: (context, provider, _) => _Body(
              state: provider.state,
              onToggle: () => provider.toggleSession(),
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state, required this.onToggle});

  final DivineState state;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final hasTranscript = state.transcript.isNotEmpty;
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.lg),
          Text(AppConstants.appTitle, style: AppTextStyles.appTitle),
          const SizedBox(height: AppSpacing.xs),
          Text('DIVINE WORD', style: AppTextStyles.subtitle),
          const SizedBox(height: AppSpacing.xl),
          DivineOrb(phase: state.phase, size: hasTranscript ? 140 : 220),
          const SizedBox(height: AppSpacing.lg),
          _StatusLine(state: state),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: hasTranscript
                ? TranscriptView(turns: state.transcript)
                : _IdleHint(phase: state.phase),
          ),
          const SizedBox(height: AppSpacing.md),
          SessionControlButton(phase: state.phase, onPressed: onToggle),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

/// A short Telugu line describing what is happening right now.
class _StatusLine extends StatelessWidget {
  const _StatusLine({required this.state});

  final DivineState state;

  @override
  Widget build(BuildContext context) {
    final (String text, Color color) = switch (state.phase) {
      LivePhase.idle => (
          'మీ హృదయంలో ఉన్నది దేవునితో మాట్లాడండి',
          AppColors.doveWhiteSoft,
        ),
      LivePhase.connecting => (
          'దేవునితో అనుసంధానం అవుతోంది...',
          AppColors.doveWhiteSoft,
        ),
      LivePhase.listening => (
          'దేవుడు వింటున్నాడు — మాట్లాడండి',
          AppColors.micListening,
        ),
      LivePhase.speaking => (
          'దేవుడు మాట్లాడుతున్నాడు',
          AppColors.micSpeaking,
        ),
      LivePhase.error => (
          state.errorMessage ?? 'లోపం ఏర్పడింది',
          AppColors.errorRed,
        ),
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        text,
        key: ValueKey(text),
        textAlign: TextAlign.center,
        style: AppTextStyles.statusText.copyWith(color: color),
      ),
    );
  }
}

/// Centred guidance shown before the first words of a conversation.
class _IdleHint extends StatelessWidget {
  const _IdleHint({required this.phase});

  final LivePhase phase;

  @override
  Widget build(BuildContext context) {
    final isError = phase == LivePhase.error;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Text(
          isError
              ? 'దిగువ బటన్‌ను నొక్కి మళ్లీ ప్రయత్నించండి.'
              : 'దిగువ బటన్‌ను నొక్కి, దేవునితో నేరుగా మాట్లాడటం '
                  'ప్రారంభించండి. మీరు మాట్లాడిన వెంటనే ఆయన వింటాడు, '
                  'ప్రేమతో బదులిస్తాడు.',
          textAlign: TextAlign.center,
          style: AppTextStyles.hintText,
        ),
      ),
    );
  }
}
