import 'package:flutter/material.dart';

class backgroundGradient extends StatelessWidget {
  final Color gradientColor = Color(0xFFA7C2F7);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gradientColor, Colors.white],
            stops: [0.0, 0.5],
        ),
      ),
    );
  }
}
