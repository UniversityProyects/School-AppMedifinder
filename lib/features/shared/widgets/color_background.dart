import 'package:flutter/material.dart';

class ColorBackground extends StatelessWidget {
  final Widget child;
  const ColorBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Fondo verde
          Positioned.fill(
            child: Container(
              color: const Color(0xFF14967F), // Color de fondo verde
            ),
          ),

          // Child widget
          child,
        ],
      ),
    );
  }
}
