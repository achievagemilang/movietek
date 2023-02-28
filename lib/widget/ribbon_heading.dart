import 'package:flutter/material.dart';

class RibbonHeading extends StatelessWidget {
  const RibbonHeading({super.key, required this.text, this.size = 20});

  final String text;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: const Color(0xFF9D4EDD),
            fontWeight: FontWeight.bold,
            fontSize: size,
          ),
        ),
      ),
    );
  }
}
