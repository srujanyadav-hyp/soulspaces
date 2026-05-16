# STACK.md — Telugu Spiritual Confessional App (POC)

## Project Overview
A voice-to-voice AI-powered mobile app inspired by the Christian confessional booth.
Telugu-speaking users speak their problems, sins, or seek motivation.
The AI responds with positivity and Bible-based stories — delivered as if God is speaking.

---

## Platform
- **Type**: Mobile App (Android first for POC)
- **Target Language**: Telugu (te-IN)
- **Authentication**: None (No login, no signup)
- **Stage**: POC (Proof of Concept)

---

## Frontend Framework
- **Framework**: Flutter (Dart)
- **Version**: Flutter 3.x (latest stable)
- **Target**: Android (primary), iOS (secondary for POC)
- **State Management**: setState (simple, no complex state manager needed for POC)
- **Navigation**: Single screen app — no navigation needed for POC

---

## Flutter Packages

### Voice Input (Speech to Text)
- **Package**: `speech_to_text`
- **Version**: latest stable
- **Purpose**: Capture user's Telugu voice and convert to text
- **Language Code**: `te_IN`
- **Trigger**: Mic button press → start listening | release or silence → stop listening

### Voice Output (Text to Speech)
- **Package**: `flutter_tts`
- **Version**: latest stable
- **Purpose**: Convert Gemini's text response to Telugu audio
- **Language Code**: `te-IN`
- **Note**: Uses Google TTS engine on Android device
- **Limitation**: Voice quality is basic for POC — not divine quality, acceptable for concept proof

### HTTP Client
- **Package**: `http` or `dio`
- **Purpose**: Make REST API calls to Gemini API and Google Cloud TTS API
- **Used for**: Sending user text to Gemini, receiving response

### Audio Player (Optional)
- **Package**: `just_audio`
- **Purpose**: Play back audio from Google Cloud TTS if using cloud TTS instead of flutter_tts
- **Use only if**: Switching to Google Cloud TTS Neural2 voices

### Environment Variables
- **Package**: `flutter_dotenv`
- **Purpose**: Store API keys safely (Gemini API key, Google Cloud API key)

---

## AI — Gemini

### API
- **Provider**: Google Gemini
- **Model**: `gemini-1.5-flash` (fast, cost-effective for POC)
- **API Type**: REST API (direct HTTP call from Flutter)
- **Endpoint**: `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent`
- **Auth**: API Key (stored in .env file)

### Gemini Role in App
- Receives: Telugu text (transcribed from user's voice)
- Processes: Understands emotion, context, and intent
- Responds: Telugu text with Bible-based positive response
- Tone: As if God is speaking with love and wisdom
- Constraint: Must use ONLY Bible stories and scriptures — no AI creativity

### System Prompt Strategy
- Language instruction: Respond strictly in Telugu
- Tone instruction: Speak as God addressing a child with love
- Content restriction: Use only verified Bible stories and scripture references
- Format: Story-based, emotionally warm, ends with an encouraging message
- (Detailed prompt in PROMPT.md file)

---

## Text to Speech Strategy

### Option A — flutter_tts (Chosen for POC)
- Free, no extra API needed
- Uses device's Google TTS engine
- Telugu supported on Android
- Voice quality: Basic but functional for POC

### Option B — Google Cloud TTS (Upgrade path after POC)
- Neural2 Telugu voice (`te-IN-Standard-A` or `te-IN-Wavenet-A`)
- Much more natural sound
- Requires Google Cloud account + billing
- REST API call, returns audio bytes → play with just_audio

---

## No Backend — Direct API Architecture (POC)

```
[User Voice]
     ↓
[speech_to_text] → Telugu Text
     ↓
[Gemini API] → Telugu Response Text
     ↓
[flutter_tts / Google Cloud TTS] → Audio
     ↓
[User Hears Response]
```

- No server
- No database
- No authentication
- All API calls made directly from Flutter app

---

## API Keys Required
| Key | Purpose | Where to Get |
|-----|---------|--------------|
| Gemini API Key | Access Gemini AI model | aistudio.google.com |
| Google Cloud API Key (optional) | Google Cloud TTS Neural voices | console.cloud.google.com |

---

## Folder Structure (Flutter)
```
lib/
  main.dart               → App entry point
  screens/
    home_screen.dart      → Single main screen (mic button, response display)
  services/
    gemini_service.dart   → Gemini API call logic
    tts_service.dart      → Text to speech logic
    stt_service.dart      → Speech to text logic
  widgets/
    mic_button.dart       → Animated mic button widget
    response_display.dart → Shows response text on screen
  constants/
    prompt_constants.dart → System prompt and instruction strings
  utils/
    app_colors.dart       → Color palette
assets/
  .env                    → API keys (never commit to git)
pubspec.yaml
```

---

## UI/UX Summary (Single Screen)
- Background: Dark, calm, sacred feel (deep blue or dark gold)
- Center: Subtle cross or divine light animation (idle state)
- Bottom Center: Large mic button
  - Idle: Glowing mic icon
  - Listening: Pulsing animation with wave effect
  - Processing: Spinning / praying hands animation
  - Speaking: Audio wave animation (God is speaking)
- Text area (optional): Show response text in Telugu on screen

---

## Key Constraints for POC
1. Telugu only — no other language support
2. No user accounts or data storage
3. Bible-only responses — Gemini strictly instructed
4. No internet = no functionality (fully cloud dependent)
5. Android device must have Google TTS with Telugu language pack installed

---

## What is NOT in POC
- User history / conversation memory
- Offline mode
- Push notifications
- Multi-language support
- Custom divine voice model
- Backend server
- Analytics

---

## Future Upgrade Path (Post POC)
- Replace flutter_tts with a custom fine-tuned Telugu TTS voice model
- Add ElevenLabs or Azure Neural TTS if Telugu support improves
- Add conversation memory (Gemini multi-turn)
- Build a Node.js / Firebase backend
- Add church/pastor community features
