import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed; // Callback function for button press
  final String text; // Button text label
  final Color backgroundColor; // Button background color
  final Color foregroundColor; // Text color
  final Duration animationDuration; // Duration of the shrink animation

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = const Color.fromRGBO(247, 169, 186, 1.0), // Default pink
    this.foregroundColor = Colors.black, // Default black text
    this.animationDuration = const Duration(milliseconds: 200), // Default animation duration
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: toButtonStyle(), // Call toButtonStyle method here
      child: Text(text),
    );
  }

  ButtonStyle toButtonStyle() {
    // Return the ButtonStyle object with the defined properties
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
      animationDuration: animationDuration,
      overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.white10; // Shrink and visually indicate press
        }
        return Colors.transparent; // Use default overlay color
      }),
      padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((states) {
        if (states.contains(MaterialState.pressed)) {
          return const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          );
        }
        return const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 12.0,
        );
      }),
    );
  }
}
