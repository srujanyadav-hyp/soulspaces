import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../providers/home_provider.dart';
import '../widgets/mic_button.dart';
import '../widgets/response_card.dart';
import '../widgets/waveform_animation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SafeArea(
          child: Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return Stack(
                children: [
                  // Center Content
                  Positioned.fill(
                    child: Align(
                      alignment: provider.state == AppState.speaking ? Alignment.topCenter : Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: AppSpacing.screenPadding,
                          right: AppSpacing.screenPadding,
                          top: provider.state == AppState.speaking ? 100 : 0,
                        ),
                        child: _buildCenterContent(provider),
                      ),
                    ),
                  ),

                  // Top Title
                  Positioned(
                    top: AppSpacing.xl,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        children: [
                          Text("దైవ వాక్యం", style: AppTextStyles.appTitle),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Mic (Hidden while speaking)
                  if (provider.state != AppState.speaking)
                    Positioned(
                      bottom: AppSpacing.xxl,
                      left: 0,
                      right: 0,
                      child: MicButton(
                        state: provider.state,
                        onTap: provider.toggleListening,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCenterContent(HomeProvider provider) {
    switch (provider.state) {
      case AppState.idle:
        return Container(
          decoration: const BoxDecoration(gradient: AppGradients.divineGlow),
          child: ClipOval(
            child: Image.asset('assets/images/logo.jpeg', width: 120, height: 120, fit: BoxFit.cover),
          ),
        );
      
      case AppState.listening:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const WaveformAnimation(),
            const SizedBox(height: AppSpacing.xl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.backgroundCard.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderSilver),
              ),
              child: Text(
                provider.transcribedText.isEmpty ? "మీరు చెప్పండి..." : provider.transcribedText,
                style: AppTextStyles.hintText.copyWith(color: AppColors.doveWhiteSoft),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );

      case AppState.processing:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.silverBlue),
            const SizedBox(height: AppSpacing.xl),
            Text("వెతుకుతున్నాను... Searching Holy Bible scriptures", style: AppTextStyles.statusText),
          ],
        );

      case AppState.speaking:
        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
          child: ResponseCard(text: provider.godsResponse),
        );
    }
  }
}
