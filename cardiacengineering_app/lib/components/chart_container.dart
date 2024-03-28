import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final Color gradientColor;
  final Widget child;
  final EdgeInsets padding;

  const ChartContainer
({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(10.0),
    this.gradientColor = const Color(0xFFA7C2F7),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gradientColor, Colors.white],
            stops: const [0.0, 0.5],
        ),
      ),
      child: child,
    );
  }
}
