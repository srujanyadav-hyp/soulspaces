import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/gemini_remote_datasource.dart';
import 'data/repositories/confession_repository_impl.dart';
import 'data/services/stt_service.dart';
import 'data/services/tts_service.dart';
import 'domain/usecases/get_confession_response_usecase.dart';
import 'presentation/providers/home_provider.dart';
import 'presentation/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    await dotenv.load(fileName: "assets/.env");
  } catch (e) {
    debugPrint("Could not load .env file. Ensure it exists in assets/");
  }

  // Dependency Injection Setup
  final geminiDataSource = GeminiRemoteDataSource();
  final repository = ConfessionRepositoryImpl(geminiDataSource);
  final useCase = GetConfessionResponseUseCase(repository);
  final sttService = SttService();
  final ttsService = TtsService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(
            useCase: useCase,
            sttService: sttService,
            ttsService: ttsService,
          ),
        ),
      ],
      child: const SoulSpaceApp(),
    ),
  );
}

class SoulSpaceApp extends StatelessWidget {
  const SoulSpaceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'దైవ వాక్యం',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
