import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationTextButton extends StatelessWidget {
  final List<BoxShadow>? buttonBoxShadow;
  final Color? buttonColor;
  final Function()? buttonOnPressed;
  final String buttonName;
  final double buttonFontSize, buttonLetterSpacing;
  final Color? fontColor;
  final FontWeight? fontWeight;

  const NavigationTextButton({
    super.key,
    required this.buttonBoxShadow,
    required this.buttonColor,
    required this.buttonOnPressed,
    required this.buttonName,
    required this.buttonFontSize,
    required this.buttonLetterSpacing,
    required this.fontColor,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          alignment: Alignment.center,
          child: TextButton(
              onPressed: buttonOnPressed,
              style: ButtonStyle(
                  elevation: WidgetStateProperty.all(0),
                  overlayColor: WidgetStateProperty.all(Colors.transparent)),
              child: Text(
                buttonName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.alatsi(
                  letterSpacing: buttonLetterSpacing,
                  color: fontColor,
                  fontWeight: fontWeight,
                  fontSize: buttonFontSize,
                ),
              )),
        ),
        Container(
          width: 5,
          height: 20,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: buttonBoxShadow),
        ),
      ],
    );
  }
}
