import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_popup_window_widget/on_popup_window_widget.dart';

class PopUpWindowHolder extends StatelessWidget {
  // Properties for the create and close buttons, text field controller, hint text, icon, and focus node
  final void Function()? onPressedCreateButton;
  final void Function()? onPressedCloseButton;
  final TextEditingController? newPlaylistNameController;
  final String? hintText;
  final IconData? icon;

  // Constructor to initialize the properties
  const PopUpWindowHolder({
    super.key,
    required this.onPressedCreateButton,
    required this.onPressedCloseButton,
    required this.newPlaylistNameController,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OnPopupWindowWidget(
      duration: Duration.zero,
      backgroundColor: Colors.transparent,
      windowElevation: 0,
      intend: 1,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF022B35).withOpacity(0.6),
              Color(0xFF030B21).withOpacity(0.7),
              Color(0xFF000000).withOpacity(0.8),
              Color(0xFF260000).withOpacity(0.8),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlueAccent.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 0), // changes position of shadow
            )
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.09),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        icon,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: TextField(
                          showCursor: true,
                          cursorColor: Colors.white,
                          controller: newPlaylistNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: hintText,
                            hintStyle: GoogleFonts.alatsi(
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.normal,
                              fontSize: 11,
                            ),
                            fillColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                          ),
                          maxLines: 1,
                          minLines: 1,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.alatsi(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Create button
                  ElevatedButton(
                    onPressed: onPressedCreateButton,
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      backgroundColor: WidgetStateProperty.all(
                          Colors.white.withOpacity(0.06)),
                      overlayColor: WidgetStateProperty.all(
                          Colors.white.withOpacity(0.05)),
                      elevation: WidgetStateProperty.all(0),
                    ),
                    child: Text(
                      "Create",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.alatsi(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  // Close button
                  ElevatedButton(
                    onPressed: onPressedCloseButton,
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      backgroundColor: WidgetStateProperty.all(
                          Colors.white.withOpacity(0.06)),
                      overlayColor: WidgetStateProperty.all(
                          Colors.white.withOpacity(0.05)),
                      elevation: WidgetStateProperty.all(0),
                    ),
                    child: Text(
                      "Close",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.alatsi(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
