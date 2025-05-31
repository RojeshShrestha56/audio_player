# Flutter Audio Player

A Flutter application that demonstrates audio playback functionality with welcome sound and background music features.

## Features

- 🎵 Welcome Sound: Plays a welcome audio once when the app starts
- 🔄 Background Music: Automatically transitions to looping background music
- ⏯️ Playback Controls: Play/pause, seek, and speed adjustment
- 📱 Responsive UI: Adapts to different screen sizes
- 🎛️ State Management: Uses MobX for efficient state handling

## Getting Started

### Prerequisites

- Flutter SDK (^3.8.0)
- Dart SDK (^3.8.0)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/RojeshShrestha56/audio_player.git
```

2. Navigate to the project directory:
```bash
cd audio_player
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/                  # Screen widgets
│   └── audio_player_screen.dart
├── components/              # Reusable components
│   └── audio_player_controls.dart
└── stores/                  # MobX stores
    └── audio_store.dart     # Audio playback state management
```

## Dependencies

- [just_audio](https://pub.dev/packages/just_audio): Audio playback
- [mobx](https://pub.dev/packages/mobx): State management
- [flutter_screenutil](https://pub.dev/packages/flutter_screenutil): Responsive UI

## Audio Files

Place your audio files in the `assets/audio/` directory:
- `welcome.mp3`: Welcome sound that plays once
- `main.m4a`: Background music that loops

## Usage

The audio player starts automatically when the app launches:
1. Plays the welcome sound once
2. Transitions to looping background music
3. Use the UI controls to:
   - Play/pause the background music
   - Seek to different positions
   - Adjust playback speed


