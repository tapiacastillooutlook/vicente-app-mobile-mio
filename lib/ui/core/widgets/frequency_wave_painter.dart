import 'package:flutter/material.dart';
import 'dart:math';

class FrequencyWavePainter extends CustomPainter {
  final double animationValue;
  final Color waveColor;
  final int waveCount;

  FrequencyWavePainter({
    required this.animationValue,
    required this.waveColor,
    this.waveCount = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (int j = 0; j < waveCount; j++) {
      final path = Path();
      // Calculate a phase shift for each wave to create an offset effect
      final phase = animationValue * 2 * pi + (j * pi / 2);
      
      // Decrease amplitude for outer waves
      final amplitude = (size.height / 3) * (1.0 - (j * 0.2));

      path.moveTo(0, size.height / 2);
      for (double i = 0; i <= size.width; i++) {
        // frequency is related to waveCount, higher waveCount = more waves
        final y = size.height / 2 +
            sin((i / size.width * 2 * pi * (2 + j)) + phase) * amplitude;
        path.lineTo(i, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant FrequencyWavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
           oldDelegate.waveColor != waveColor;
  }
}
