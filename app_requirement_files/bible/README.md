# దైవ వాక్యం — Divine Word
### Telugu AI Spiritual Confessional App

> *"Speak your heart. Hear God's Word."*
> A voice-to-voice AI spiritual companion for Telugu-speaking Christians.

---

## Table of Contents

- [What Is This App](#what-is-this-app)
- [How It Works](#how-it-works)
- [Screenshots](#screenshots)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Setup & Installation](#setup--installation)
- [API Keys](#api-keys)
- [AI System Prompt](#ai-system-prompt)
- [Design System](#design-system)
- [App States](#app-states)
- [Key Constraints](#key-constraints)
- [Known Limitations (POC)](#known-limitations-poc)
- [Roadmap](#roadmap)
- [Contributing](#contributing)

---

## What Is This App

**దైవ వాక్యం (Divine Word)** is a mobile app inspired by the Christian confessional booth.

Telugu-speaking users speak their problems, sins, fears, or seek motivation — and the app responds **as if God (the Heavenly Father) is speaking directly back to them**, in Telugu, using only real stories and verses from the Holy Bible.

It is not a chatbot. It is not a generic AI assistant.
It is a private, sacred, voice-first spiritual experience.

```
User speaks in Telugu  →  AI understands  →  God responds in Telugu  →  User hears the Word
```

---

## How It Works

```
┌─────────────────────────────────────────────────────┐
│                                                     │
│   [1] User presses mic and speaks in Telugu         │
│        ↓                                            │
│   [2] speech_to_text captures voice → text         │
│        ↓                                            │
│   [3] Text sent to Gemini API with Telugu           │
│       system prompt (God persona + Bible only)      │
│        ↓                                            │
│   [4] Gemini returns Telugu Bible-based response   │
│        ↓                                            │
│   [5] flutter_tts reads response aloud in Telugu   │
│        ↓                                            │
│   [6] User sees + hears God's Word                 │
│                                                     │
└─────────────────────────────────────────────────────┘
```

No backend. No login. No data stored. Fully serverless.

---

## Screenshots

| Idle | Listening | Processing | Speaking |
|------|-----------|------------|----------|
| Cross glow, mic ready | Waveform + transcript preview | Orbit rings, scripture search | Full Bible response card |
| Silver `#A8C4E0` | Sky Blue `#6EC6FF` | Soft Indigo `#8BA7FF` | Teal `#7DD4B8` |

> Figma file: [View UI Screens →](https://www.figma.com/design/TSoj1gUGosGjirFcLNMBvO)

---

## Tech Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| **Framework** | Flutter 3.x (Dart) | Cross-platform mobile (Android first) |
| **AI** | Google Gemini 1.5 Flash | Telugu understanding + Bible response |
| **Speech → Text** | `speech_to_text` | Capture user's Telugu voice |
| **Text → Speech** | `flutter_tts` | Read God's response aloud |
| **HTTP** | `http` / `dio` | REST calls to Gemini API |
| **Env Config** | `flutter_dotenv` | Secure API key storage |
| **Audio (optional)** | `just_audio` | Google Cloud TTS neural voices (upgrade path) |

---

## Project Structure

```
lib/
├── main.dart                    # App entry point + theme setup
├── screens/
│   └── home_screen.dart         # Single screen (mic + response display)
├── services/
│   ├── gemini_service.dart      # Gemini API call logic
│   ├── tts_service.dart         # Text-to-speech logic
│   └── stt_service.dart         # Speech-to-text logic
├── widgets/
│   ├── mic_button.dart          # Animated mic button (4 states)
│   └── response_display.dart   # Telugu response card with Bible verse
├── constants/
│   └── prompt_constants.dart   # System prompt + user message builder
└── utils/
    ├── app_colors.dart          # Full color palette
    ├── app_text_styles.dart     # Typography (Cinzel, Lora, Nunito)
    ├── app_spacing.dart         # Spacing system (4dp base unit)
    ├── app_animations.dart      # Animation durations + curves
    └── app_theme.dart           # Flutter ThemeData (dark only)

assets/
├── images/
│   ├── logo.png                 # Cross + Bible + Dove logo
│   └── logo_small.png          # AppBar version
└── .env                         # API keys (never commit)

docs/
├── STACK.md                     # Tech stack documentation
├── DESIGN_SYSTEM.md            # Full design tokens
├── PROMPT.md                   # Gemini system prompt design
└── README.md                   # This file
```

---

## Setup & Installation

### Prerequisites

- Flutter 3.x installed ([flutter.dev](https://flutter.dev))
- Android Studio or VS Code with Flutter plugin
- Android device with **Google TTS + Telugu language pack** installed
- Gemini API key from [aistudio.google.com](https://aistudio.google.com)

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/your-username/daiva-vakyam.git
cd daiva-vakyam

# 2. Install Flutter dependencies
flutter pub get

# 3. Create .env file in assets/
touch assets/.env
```

Add your API keys to `assets/.env`:

```env
GEMINI_API_KEY=your_gemini_api_key_here
GOOGLE_CLOUD_TTS_KEY=optional_for_neural_voices
```

```bash
# 4. Register .env in pubspec.yaml (already done)
# assets:
#   - assets/.env

# 5. Run on connected Android device
flutter run

# 6. Build APK for release
flutter build apk --release
```

### Android Device Setup

The app requires Google TTS with Telugu language pack:

```
Settings → General Management → Language → Text-to-Speech
→ Google Text-to-Speech Engine → Install "Telugu" language data
```

---

## API Keys

| Key | Required | Where to Get | Used For |
|-----|----------|-------------|---------|
| `GEMINI_API_KEY` | ✅ Yes | [aistudio.google.com](https://aistudio.google.com) | AI responses |
| `GOOGLE_CLOUD_TTS_KEY` | ⬜ Optional | [console.cloud.google.com](https://console.cloud.google.com) | Neural Telugu voice (upgrade) |

> ⚠️ **Never commit `.env` to Git.** It is listed in `.gitignore` by default.

---

## AI System Prompt

The Gemini system prompt is the **soul of the app**. It instructs Gemini to:

- Speak **only in Telugu** (te-IN)
- Respond **only using real Bible stories and verses** (Old + New Testament)
- Never fabricate or invent any scripture
- Always cite the **Book name, Chapter, and Verse** number
- Speak **as God addressing His child** — with love, warmth, and power
- Never judge or condemn — always show grace and hope
- End every response with a **closing blessing from the Bible**

**Temperature is fixed at `0.4`** — low enough to prevent hallucinated Bible verses, warm enough for emotional resonance.

### Response Structure

Every Gemini response follows this flow:

```
1. Acknowledgement  → God recognises the user's pain (2–3 sentences)
2. Bible Story      → A real, relevant story told warmly (5–7 sentences)
3. Scripture Verse  → Exact verse with Book:Chapter:Verse reference
4. Application      → How this applies to the user's situation (3–4 sentences)
5. Blessing         → Short closing blessing or encouraging word (1–2 sentences)
```

> Full prompt in [`docs/PROMPT.md`](./PROMPT.md)

---

## Design System

### Aesthetic: **CELESTIAL**

> *"Like looking at the night sky just before dawn — deep, peaceful, holy."*

Dark-only theme. Deep navy base with silver-blue divine light breaking through.

### Core Colors

| Token | Hex | Usage |
|-------|-----|-------|
| `backgroundDeep` | `#0D1628` | Main screen background |
| `silverBlue` | `#A8C4E0` | Primary accent, idle mic |
| `silverBlueLight` | `#D0E8FF` | Headings, highlights |
| `doveWhite` | `#F0F6FF` | Primary text |
| `micListening` | `#6EC6FF` | Listening state |
| `micProcessing` | `#8BA7FF` | Processing state |
| `micSpeaking` | `#7DD4B8` | God speaking state |

### Typography

| Font | Role | Usage |
|------|------|-------|
| **Cinzel** | Display / Title | App name, screen headings |
| **Lora** | Body / Scripture | God's response, Bible verses |
| **Nunito** | UI / Labels | Mic label, status text, hints |

> Telugu text renders using the device's system font (Noto Sans Telugu). Minimum 16sp.

> Full tokens in [`docs/DESIGN_SYSTEM.md`](./DESIGN_SYSTEM.md)

---

## App States

The entire app is a **single screen** with 4 distinct states:

### 1. Idle State `#A8C4E0`
- Silver-blue glowing cross at center
- Subtle divine radial glow + star particles
- Hint text: *"మీ మాటలు చెప్పండి..."*
- Mic button: silver metallic gradient, soft glow

### 2. Listening State `#6EC6FF`
- Live audio waveform visualization
- Transcript preview card shows what is being heard
- Mic button: bright sky-blue with pulsing rings
- Status pill: *"వింటున్నాను..."*

### 3. Processing State `#8BA7FF`
- 5 dashed orbital rings animate around central cross
- Progress bar + loading dots
- Mic button: dimmed, non-interactive
- Status pill: *"ఆలోచిస్తున్నాను..."*

### 4. Speaking State `#7DD4B8`
- Full glass response card with God's message
- Bible verse highlighted in a teal-accented block
- Closing blessing
- Mic button: teal with expanding sound-wave rings
- Status pill: *"దేవుడు మాట్లాడుతున్నాడు"*

---

## Key Constraints

These are **non-negotiable** for the POC:

1. **Telugu only** — no multilingual support
2. **Bible only** — Gemini strictly instructed, no creative invention
3. **No user data** — zero accounts, zero storage, zero analytics
4. **Temperature ≤ 0.4** — prevents hallucinated Bible content
5. **Android first** — device must have Google TTS with Telugu pack
6. **No internet = no functionality** — fully cloud-dependent

---

## Known Limitations (POC)

| Limitation | Impact | Upgrade Path |
|------------|--------|--------------|
| `flutter_tts` basic voice | Voice doesn't feel "divine" | Google Cloud Neural2 / custom TTS model |
| No conversation memory | Each session is fresh | Gemini multi-turn + local history |
| No offline support | Needs internet always | On-device small model (future) |
| Gemini may hallucinate rarely | Wrong Bible reference | Strict prompt + post-processing validation |
| Telugu STT accuracy | Noisy environments fail | Upgrade to Google Cloud Speech-to-Text v2 |

---

## Roadmap

### Phase 1 — POC (Current)
- [x] Voice input (speech_to_text)
- [x] Gemini AI integration with Telugu system prompt
- [x] Voice output (flutter_tts)
- [x] 4-state UI (Idle / Listening / Processing / Speaking)
- [x] Bible-only response constraint

### Phase 2 — Beta
- [ ] Google Cloud TTS Neural2 Telugu voice (`te-IN-Wavenet-A`)
- [ ] Conversation history (Gemini multi-turn)
- [ ] Verse bookmarking (local SQLite)
- [ ] Offline grace message fallback
- [ ] Suicidal ideation safety layer (auto-route to pastor contact)

### Phase 3 — Production
- [ ] Custom fine-tuned Telugu TTS voice model
- [ ] Firebase backend (optional analytics + crash reporting)
- [ ] Church / pastor community features
- [ ] Daily Bible verse notification
- [ ] Multi-denomination support (Catholic, Protestant, Pentecostal)

---

## Safety Handling

### Suicidal Thoughts / Severe Distress

If the user expresses suicidal ideation, the system prompt instructs Gemini to:

1. First comfort with God's love and grace
2. Recommend contacting a trusted pastor or counselor nearby
3. Never provide harmful information

This is a **Gemini-level instruction**, not a keyword filter.

### Off-topic Messages

If a user speaks about unrelated topics (cricket, weather, etc.), the system prompt naturally re-anchors the conversation to a spiritual perspective through the Bible.

---

## Contributing

This is a POC project. Contributions welcome in these areas:

- Improving Telugu STT accuracy
- Testing Gemini prompt for hallucination edge cases
- UI animations (Flutter AnimationController implementations)
- Telugu TTS voice quality research
- Bible verse accuracy validation

```bash
# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format lib/
```

---

## License

This project is for spiritual and educational purposes.
All Bible verses used belong to their respective translations.
AI responses are generated — always verify scripture references independently.

---

## Acknowledgements

- Holy Bible (Old Testament + New Testament)
- Google Gemini API
- Flutter & Dart team
- Google TTS Engine
- The Telugu Christian community this app is built for

---

<div align="center">

**దేవుడు మీకు దీవించుగాక 🙏**

*May God bless you*

Built with faith, code, and love for Telugu-speaking Christians.

</div>
