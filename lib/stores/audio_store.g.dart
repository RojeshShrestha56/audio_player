// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AudioStore on _AudioStore, Store {
  late final _$isPlayingAtom = Atom(
    name: '_AudioStore.isPlaying',
    context: context,
  );

  @override
  bool get isPlaying {
    _$isPlayingAtom.reportRead();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.reportWrite(value, super.isPlaying, () {
      super.isPlaying = value;
    });
  }

  late final _$playbackSpeedAtom = Atom(
    name: '_AudioStore.playbackSpeed',
    context: context,
  );

  @override
  double get playbackSpeed {
    _$playbackSpeedAtom.reportRead();
    return super.playbackSpeed;
  }

  @override
  set playbackSpeed(double value) {
    _$playbackSpeedAtom.reportWrite(value, super.playbackSpeed, () {
      super.playbackSpeed = value;
    });
  }

  late final _$positionAtom = Atom(
    name: '_AudioStore.position',
    context: context,
  );

  @override
  Duration get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(Duration value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$durationAtom = Atom(
    name: '_AudioStore.duration',
    context: context,
  );

  @override
  Duration get duration {
    _$durationAtom.reportRead();
    return super.duration;
  }

  @override
  set duration(Duration value) {
    _$durationAtom.reportWrite(value, super.duration, () {
      super.duration = value;
    });
  }

  late final _$hasPlayedWelcomeAtom = Atom(
    name: '_AudioStore.hasPlayedWelcome',
    context: context,
  );

  @override
  bool get hasPlayedWelcome {
    _$hasPlayedWelcomeAtom.reportRead();
    return super.hasPlayedWelcome;
  }

  @override
  set hasPlayedWelcome(bool value) {
    _$hasPlayedWelcomeAtom.reportWrite(value, super.hasPlayedWelcome, () {
      super.hasPlayedWelcome = value;
    });
  }

  late final _$errorAtom = Atom(name: '_AudioStore.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$playWelcomeAudioAsyncAction = AsyncAction(
    '_AudioStore.playWelcomeAudio',
    context: context,
  );

  @override
  Future<void> playWelcomeAudio() {
    return _$playWelcomeAudioAsyncAction.run(() => super.playWelcomeAudio());
  }

  late final _$playMainAudioAsyncAction = AsyncAction(
    '_AudioStore.playMainAudio',
    context: context,
  );

  @override
  Future<void> playMainAudio() {
    return _$playMainAudioAsyncAction.run(() => super.playMainAudio());
  }

  late final _$togglePlayAsyncAction = AsyncAction(
    '_AudioStore.togglePlay',
    context: context,
  );

  @override
  Future<void> togglePlay() {
    return _$togglePlayAsyncAction.run(() => super.togglePlay());
  }

  late final _$seekAsyncAction = AsyncAction(
    '_AudioStore.seek',
    context: context,
  );

  @override
  Future<void> seek(Duration position) {
    return _$seekAsyncAction.run(() => super.seek(position));
  }

  late final _$setSpeedAsyncAction = AsyncAction(
    '_AudioStore.setSpeed',
    context: context,
  );

  @override
  Future<void> setSpeed(double speed) {
    return _$setSpeedAsyncAction.run(() => super.setSpeed(speed));
  }

  @override
  String toString() {
    return '''
isPlaying: ${isPlaying},
playbackSpeed: ${playbackSpeed},
position: ${position},
duration: ${duration},
hasPlayedWelcome: ${hasPlayedWelcome},
error: ${error}
    ''';
  }
}
