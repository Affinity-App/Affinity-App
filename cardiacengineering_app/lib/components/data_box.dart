// data_box.dart

import 'package:flutter/material.dart';

typedef OnDataBoxPressedCallback = void Function(BuildContext context);

class DataBox extends StatelessWidget {
  final String label;
  final String value;
  final String iconPath;
  final double iconSize;
  final double labelFontSize;
  final double valueFontSize;
  final double borderRadius;
  final OnDataBoxPressedCallback onPressed;

  const DataBox({
    super.key,
    required this.label,
    required this.value,
    required this.iconPath,
    this.iconSize = 50.0,
    this.labelFontSize = 20.0,
    this.valueFontSize = 20.0,
    this.borderRadius = 20.0,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: GestureDetector(
        onTap: () => onPressed(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                height: iconSize,
                width: iconSize,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: labelFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: valueFontSize,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 86, 140, 234),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
