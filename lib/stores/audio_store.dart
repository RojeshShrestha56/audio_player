import 'package:mobx/mobx.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';

part 'audio_store.g.dart';

/// AudioStore manages the audio playback functionality of the application.
///
/// Features:
/// - Plays a welcome sound once when the app starts
/// - Automatically transitions to looping background music
/// - Controls for play/pause, seek, and playback speed
/// - Tracks playback state, duration, and position
///
/// Usage:
/// ```dart
/// final audioStore = AudioStore();
/// // Audio will start playing automatically
///
/// // Control playback
/// audioStore.togglePlay();
/// audioStore.seek(Duration(seconds: 30));
/// audioStore.setSpeed(1.5);
/// ```
class AudioStore = _AudioStore with _$AudioStore;

class _AudioStore with Store {
  // Audio players for welcome and main sounds
  late AudioPlayer _welcomePlayer;
  late AudioPlayer _mainPlayer;

  // Stream subscriptions for tracking audio state
  late StreamSubscription<Duration?> _durationSubscription;
  late StreamSubscription<Duration> _positionSubscription;

  // Asset paths for audio files
  static const String welcomePath = 'assets/audio/welcome.mp3';
  static const String mainPath = 'assets/audio/main.m4a';

  /// Current error message, if any
  @observable
  String? error;

  /// Whether the welcome sound has finished playing
  @observable
  bool hasPlayedWelcome = false;

  /// Current playback position of the main audio
  @observable
  Duration position = Duration.zero;

  /// Total duration of the main audio
  @observable
  Duration duration = Duration.zero;

  /// Whether the main audio is currently playing
  @observable
  bool isPlaying = false;

  /// Current playback speed (1.0 is normal speed)
  @observable
  double playbackSpeed = 1.0;

  /// Whether audio is currently being loaded
  @observable
  bool isLoading = false;

  /// Creates a new AudioStore instance and initializes audio playback.
  ///
  /// On creation:
  /// 1. Initializes both welcome and main audio players
  /// 2. Sets up welcome audio to play once
  /// 3. Sets up main audio to loop continuously
  /// 4. Configures state tracking
  /// 5. Starts playing welcome audio
  _AudioStore() {
    _welcomePlayer = AudioPlayer();
    _mainPlayer = AudioPlayer();

    _welcomePlayer.setLoopMode(LoopMode.off);
    _mainPlayer.setLoopMode(LoopMode.all);

    _welcomePlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        hasPlayedWelcome = true;
        playMainAudio();
      }
    });

    _mainPlayer.playerStateStream.listen((state) {
      isPlaying = state.playing;
    });

    _durationSubscription = _mainPlayer.durationStream.listen((Duration? d) {
      if (d != null) {
        duration = d;
      }
    });

    _positionSubscription = _mainPlayer.positionStream.listen((Duration p) {
      position = p;
    });

    _initializeAndPlay();
  }

  /// Initializes audio files and starts playback.
  Future<void> _initializeAndPlay() async {
    try {
      await initializeAudio();
      if (!hasPlayedWelcome) {
        await playWelcomeAudio();
      }
    } catch (e) {
      error = 'Failed to initialize and play: ${e.toString()}';
    }
  }

  /// Loads both welcome and main audio files.
  @action
  Future<void> initializeAudio() async {
    try {
      isLoading = true;
      error = null;

      await _welcomePlayer.setAsset(welcomePath);
      await _mainPlayer.setAsset(mainPath);

      if (_mainPlayer.duration != null) {
        duration = _mainPlayer.duration!;
      }

      isLoading = false;
    } catch (e) {
      isLoading = false;
      error = 'Failed to initialize audio: ${e.toString()}';
    }
  }

  /// Plays the welcome audio from the beginning.
  @action
  Future<void> playWelcomeAudio() async {
    try {
      error = null;
      await _welcomePlayer.seek(Duration.zero);
      await _welcomePlayer.play();
    } catch (e) {
      error = 'Error playing welcome audio: ${e.toString()}';
      await playMainAudio();
    }
  }

  /// Starts or resumes the main audio playback.
  @action
  Future<void> playMainAudio() async {
    try {
      error = null;
      await _mainPlayer.seek(Duration.zero);
      await _mainPlayer.play();
      isPlaying = true;
    } catch (e) {
      error = 'Error playing main audio: ${e.toString()}';
      isPlaying = false;
    }
  }

  /// Toggles play/pause state of the main audio.
  @action
  Future<void> togglePlay() async {
    try {
      if (_mainPlayer.playing) {
        await _mainPlayer.pause();
      } else {
        await _mainPlayer.play();
      }
      isPlaying = _mainPlayer.playing;
      error = null;
    } catch (e) {
      error = 'Error toggling playback: ${e.toString()}';
    }
  }

  /// Seeks to a specific position in the main audio.
  @action
  Future<void> seek(Duration position) async {
    try {
      await _mainPlayer.seek(position);
      this.position = position;
      error = null;
    } catch (e) {
      error = 'Error adjusting position: ${e.toString()}';
    }
  }

  /// Changes the playback speed of the main audio.
  ///
  /// [speed] should be greater than 0, where:
  /// - 1.0 is normal speed
  /// - 0.5 is half speed
  /// - 2.0 is double speed
  @action
  Future<void> setSpeed(double speed) async {
    try {
      await _mainPlayer.setSpeed(speed);
      playbackSpeed = speed;
      error = null;
    } catch (e) {
      error = 'Error changing playback speed: ${e.toString()}';
    }
  }

  /// Cleans up resources when the store is no longer needed.
  void dispose() {
    try {
      _durationSubscription.cancel();
      _positionSubscription.cancel();
      _welcomePlayer.dispose();
      _mainPlayer.dispose();
    } catch (e) {}
  }
}
