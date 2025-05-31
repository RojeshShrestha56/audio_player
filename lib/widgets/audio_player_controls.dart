import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../stores/audio_store.dart';

class AudioPlayerControls extends StatelessWidget {
  final AudioStore audioStore;

  const AudioPlayerControls({super.key, required this.audioStore});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Speed: ${audioStore.playbackSpeed}x',
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(width: 10.w),
                DropdownButton<double>(
                  value: audioStore.playbackSpeed,
                  items: [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]
                      .map(
                        (speed) => DropdownMenuItem(
                          value: speed,
                          child: Text('${speed}x'),
                        ),
                      )
                      .toList(),
                  onChanged: (speed) {
                    if (speed != null) audioStore.setSpeed(speed);
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Column(
              children: [
                Slider(
                  value: audioStore.position.inSeconds.toDouble(),
                  max: audioStore.duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    audioStore.seek(Duration(seconds: value.toInt()));
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(audioStore.position)),
                      Text(_formatDuration(audioStore.duration)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    audioStore.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 48.w,
                  ),
                  onPressed: audioStore.togglePlay,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
