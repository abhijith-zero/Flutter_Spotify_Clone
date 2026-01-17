import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioWave extends StatefulWidget {
  final String audioPath;
  const AudioWave({super.key, required this.audioPath});

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController playercontroller = PlayerController();

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  Future<void> playAndPause() async {
    if (!playercontroller.playerState.isPlaying) {
      if (playercontroller.playerState == PlayerState.stopped) {
        await playercontroller.seekTo(0);
      }
      await playercontroller.startPlayer();
    } else if (!playercontroller.playerState.isPaused) {
      await playercontroller.pausePlayer();
    }
    setState(() {});
  }

  void initAudioPlayer() async {
    await playercontroller.preparePlayer(path: widget.audioPath);
  }

  @override
  void dispose() {
    playercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            playAndPause();
          },
          icon: Icon(
            playercontroller.playerState.isPlaying
                ? CupertinoIcons.pause_solid
                : CupertinoIcons.play_arrow_solid,
            size: 40,
          ),
        ),
        Expanded(
          child: AudioFileWaveforms(
            size: Size(double.infinity, 100),
            playerController: playercontroller,
            playerWaveStyle: const PlayerWaveStyle(
              fixedWaveColor: Pallete.borderColor,
              liveWaveColor: Pallete.gradient2,
              spacing: 6,
              showSeekLine: false,
            ),
            enableSeekGesture: true,
          ),
        ),
      ],
    );
  }
}
