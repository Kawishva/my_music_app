import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_music_app/generalFunctions/audioAndVideoStream.dart';
import 'package:my_music_app/generalFunctions/moviesFunction.dart';
import 'package:provider/provider.dart';

class VolumePopUpSlider extends StatefulWidget {
  const VolumePopUpSlider({super.key});

  @override
  State<VolumePopUpSlider> createState() => _VolumePopUpSliderState();
}

class _VolumePopUpSliderState extends State<VolumePopUpSlider> {
  @override
  Widget build(BuildContext context) {
    final audioStreamInstance = Provider.of<AudiostreamFunctions>(context);
    final movieStreamInstance = Provider.of<MoviesFunction>(context);

    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      actionsAlignment: MainAxisAlignment.end,
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 130),
        child: Container(
          height: 225,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.7)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                audioStreamInstance.getPlayerState == PlayerState.playing ||
                        (audioStreamInstance.videoPlayer != null &&
                            audioStreamInstance.videoPlayer!.value.isPlaying)
                    ? (audioStreamInstance.getVolume * 100).toInt().toString()
                    : ((movieStreamInstance.volume * 100).toInt()).toString(),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: GoogleFonts.alatsi(
                  color: Colors.black,
                  //  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Slider(
                  value: audioStreamInstance.getPlayerState ==
                              PlayerState.playing ||
                          (audioStreamInstance.videoPlayer != null &&
                              audioStreamInstance.videoPlayer!.value.isPlaying)
                      ? audioStreamInstance.getVolume
                      : movieStreamInstance.volume,
                  thumbColor: Colors.black,
                  activeColor: Colors.black,
                  inactiveColor: Colors.black.withOpacity(0.3),
                  min: 0,
                  max: 1,
                  onChanged: (value) {
                    if (audioStreamInstance.getPlayerState ==
                            PlayerState.playing ||
                        (audioStreamInstance.videoPlayer != null &&
                            audioStreamInstance.videoPlayer!.value.isPlaying)) {
                      context.read<AudiostreamFunctions>().setVolume(value);
                    } else {
                      context.read<MoviesFunction>().setVolume(value);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
