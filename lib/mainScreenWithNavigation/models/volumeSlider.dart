import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_music_app/generalFunctions/audioStream.dart';
import 'package:provider/provider.dart';

import '../../generalFunctions/navigationBarChange.dart';

class VolumePopUpSlider extends StatefulWidget {
  const VolumePopUpSlider({super.key});

  @override
  State<VolumePopUpSlider> createState() => _VolumePopUpSliderState();
}

class _VolumePopUpSliderState extends State<VolumePopUpSlider> {
  @override
  Widget build(BuildContext context) {
    final audioStreamInstance = Provider.of<AudiostreamFunctions>(context);
    final navigationBarChangeInstance =
        Provider.of<NavigationBarChange>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 820, right: 0),
      child: AlertDialog(
        surfaceTintColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: 40,
          height: 225,
          padding: EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF022B35).withOpacity(0.8),
                Color(0xFF030B21).withOpacity(0.7),
                Color(0xFF000000).withOpacity(0.8),
                Color(0xFF260000).withOpacity(0.9),
              ],
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (audioStreamInstance.getVolume * 100).toInt().toString(),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.alatsi(
                    color: Colors.white,
                    //  letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                    value: audioStreamInstance.getVolume,
                    min: 0,
                    max: 1,
                    onChanged: (value) {
                      context.read<AudiostreamFunctions>().setVolume(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
