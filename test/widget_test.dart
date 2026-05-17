// Widget tests for දైవ వాక්യం.
//
// These cover the plugin-free presentation widgets. The full app is not
// pumped here because it depends on platform plugins (microphone, audio
// playback, Firebase) that are unavailable in the test environment.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:soulspace/domain/entities/live_phase.dart';
import 'package:soulspace/presentation/widgets/session_control_button.dart';

void main() {
  testWidgets('SessionControlButton shows the start label when idle',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SessionControlButton(
            phase: LivePhase.idle,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('దేవునితో మాట్లాడండి'), findsOneWidget);
  });

  testWidgets('SessionControlButton shows the end label during a session',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SessionControlButton(
            phase: LivePhase.listening,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('సంభాషణ ముగించు'), findsOneWidget);
  });
}
