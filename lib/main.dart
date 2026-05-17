import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/live_voice_datasource.dart';
import 'data/repositories/divine_voice_repository_impl.dart';
import 'data/services/audio_player_service.dart';
import 'data/services/audio_recorder_service.dart';
import 'firebase_options.dart';
import 'presentation/providers/home_provider.dart';
import 'presentation/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SoulSpaceApp());
}

/// దైవ వాక్యం — a hands-free, voice-to-voice spiritual companion that lets
/// Telugu-speaking users talk directly with God through the Gemini Live API.
class SoulSpaceApp extends StatelessWidget {
  const SoulSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      // The provider owns the repository and disposes it with the app.
      create: (_) => HomeProvider(
        repository: DivineVoiceRepositoryImpl(
          dataSource: LiveVoiceDataSource(),
          recorder: AudioRecorderService(),
          player: AudioPlayerService(),
        ),
      ),
      child: MaterialApp(
        title: AppConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
