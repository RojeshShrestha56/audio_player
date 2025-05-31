import 'package:mobx/mobx.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';

part 'audio_store.g.dart';

class AudioStore = _AudioStore with _$AudioStore;

class _AudioStore with Store {
  late AudioPlayer _welcomePlayer;
  late AudioPlayer _mainPlayer;
  late StreamSubscription<Duration?> _durationSubscription;
  late StreamSubscription<Duration> _positionSubscription;

  static const String welcomePath = 'assets/audio/welcome.mp3';
  static const String mainPath = 'assets/audio/main.m4a';

  @observable
  String? error;

  @observable
  bool hasPlayedWelcome = false;

  @observable
  Duration position = Duration.zero;

  @observable
  Duration duration = Duration.zero;

  @observable
  bool isPlaying = false;

  @observable
  double playbackSpeed = 1.0;

  @observable
  bool isLoading = false;

  _AudioStore() {
    _welcomePlayer = AudioPlayer();
    _mainPlayer = AudioPlayer();

    _welcomePlayer.setLoopMode(LoopMode.off);

    _mainPlayer.setLoopMode(LoopMode.all);

    _welcomePlayer.playerStateStream.listen((state) {
      print('Welcome player state: ${state.processingState}');
      if (state.processingState == ProcessingState.completed) {
        hasPlayedWelcome = true;
        playMainAudio();
      }
    });

    _mainPlayer.playerStateStream.listen((state) {
      print('Main player state: ${state.processingState}');
      isPlaying = state.playing;
    });

    _durationSubscription = _mainPlayer.durationStream.listen((Duration? d) {
      if (d != null) {
        print('Duration updated: ${d.toString()}');
        duration = d;
      }
    });

    _positionSubscription = _mainPlayer.positionStream.listen((Duration p) {
      print('Position updated: ${p.toString()}');
      position = p;
    });

    _initializeAndPlay();
  }

  Future<void> _initializeAndPlay() async {
    try {
      await initializeAudio();
      if (!hasPlayedWelcome) {
        await playWelcomeAudio();
      }
    } catch (e) {
      print('Failed to initialize and play: $e');
    }
  }

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

  void dispose() {
    try {
      _durationSubscription.cancel();
      _positionSubscription.cancel();
      _welcomePlayer.dispose();
      _mainPlayer.dispose();
    } catch (e) {}
  }
}
