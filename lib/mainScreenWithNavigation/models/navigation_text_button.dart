import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationTextButton extends StatelessWidget {
  final List<BoxShadow>? buttonBoxShadow;
  final Color? buttonColor;
  final Function()? buttonOnPressed;
  final String buttonName;
  final double buttonFontSize, buttonLetterSpacing;
  final FontWeight? fontWeight;

  const NavigationTextButton({
    super.key,
    required this.buttonBoxShadow,
    required this.buttonColor,
    required this.buttonOnPressed,
    required this.buttonName,
    required this.buttonFontSize,
    required this.buttonLetterSpacing,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 120,
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: buttonOnPressed,
            style: ButtonStyle(
              // Fixed the error by changing WidgetStateProperty to MaterialStateProperty
              elevation: WidgetStateProperty.all(0),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
            child: Text(
              buttonName,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.alatsi(
                letterSpacing: buttonLetterSpacing,
                color: Colors.white,
                fontWeight: fontWeight,
                fontSize: buttonFontSize,
              ),
            ),
          ),
        ),
        Container(
          width: 5,
          height: 20,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: buttonBoxShadow,
          ),
        ),
      ],
    );
  }
}
