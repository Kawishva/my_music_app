import 'package:flutter/material.dart';

class AudioButtons extends StatelessWidget {
  final Function()? onButtonPressed;
  final IconData? buttonIcon;
  final double buttonWidth,
      buttonHeight,
      buttonIconSize,
      buttonBorderRadiusSize;

  const AudioButtons({
    super.key,
    required this.onButtonPressed,
    required this.buttonIcon,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.buttonIconSize,
    required this.buttonBorderRadiusSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: IconButton(
        onPressed: onButtonPressed,
        icon: Icon(
          buttonIcon,
          size: buttonIconSize,
          color: Colors.white,
        ),
        // Adjusted to use ButtonStyle with MaterialStateProperty
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  buttonBorderRadiusSize), // Rounded corners.
            ),
          ),
        ),
      ),
    );
  }
}
