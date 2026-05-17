import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/conversation_turn.dart';

/// A scrolling view of the conversation. The child's words sit on the
/// right, God's words on the left. Auto-scrolls to the newest turn.
class TranscriptView extends StatefulWidget {
  const TranscriptView({super.key, required this.turns});

  final List<ConversationTurn> turns;

  @override
  State<TranscriptView> createState() => _TranscriptViewState();
}

class _TranscriptViewState extends State<TranscriptView> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
  }

  @override
  void didUpdateWidget(TranscriptView oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
  }

  void _scrollToEnd() {
    if (!_controller.hasClients) return;
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      itemCount: widget.turns.length,
      itemBuilder: (context, index) => _TurnBubble(turn: widget.turns[index]),
    );
  }
}

class _TurnBubble extends StatelessWidget {
  const _TurnBubble({required this.turn});

  final ConversationTurn turn;

  @override
  Widget build(BuildContext context) {
    final isGod = turn.speaker == Speaker.god;
    return Align(
      alignment: isGod ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        decoration: BoxDecoration(
          color: isGod ? AppColors.backgroundCard : AppColors.silverBlueGhost,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: isGod ? AppColors.borderSilver : AppColors.borderSubtle,
          ),
        ),
        child: Text(
          turn.text,
          style: isGod
              ? AppTextStyles.responseText.copyWith(fontSize: 15, height: 1.6)
              : AppTextStyles.statusText.copyWith(
                  color: AppColors.doveWhite,
                  fontWeight: FontWeight.w400,
                ),
        ),
      ),
    );
  }
}
