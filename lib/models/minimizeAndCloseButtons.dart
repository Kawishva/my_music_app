import 'package:flutter/material.dart';

class MinimizeAndCloseButtons extends StatelessWidget {
  final IconData? buttonIcon;
  final Function()? onPressed;
  final Color? buttonBackgroundColor, buttonOverlayColor;

  const MinimizeAndCloseButtons({
    super.key,
    required this.buttonIcon,
    required this.onPressed,
    required this.buttonBackgroundColor,
    required this.buttonOverlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      height: 20,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          buttonIcon,
          size: 15,
          color: Colors.white,
        ),
        // Adjusted to use ButtonStyle with MaterialStateProperty
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(buttonBackgroundColor),
          overlayColor: WidgetStateProperty.all(buttonOverlayColor),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Rounded corners.
            ),
          ),
        ),
      ),
    );
  }
}
