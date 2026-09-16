import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/plonix_theme.dart';

class PitchStrobeWheelPainter extends CustomPainter {
  final double centsOffset;
  final String noteName;
  final double frequencyHz;

  PitchStrobeWheelPainter({
    required this.centsOffset,
    required this.noteName,
    required this.frequencyHz,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) * 0.44;

    // Background track
    final trackPaint = Paint()
      ..color = PlonixTheme.edge
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(center, radius, trackPaint);

    // Strobe tick marks (12 semitone positions)
    for (int i = 0; i < 24; i++) {
      final angle = (i * 2 * pi) / 24;
      final tickStart = Offset(
        center.dx + (radius - 16) * cos(angle),
        center.dy + (radius - 16) * sin(angle),
      );
      final tickEnd = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      final tickPaint = Paint()
        ..color = (i % 2 == 0) ? PlonixTheme.accentLight : PlonixTheme.edge
        ..strokeWidth = (i % 2 == 0) ? 2.5 : 1.5;
      canvas.drawLine(tickStart, tickEnd, tickPaint);
    }

    // Cents deviation needle: -50 cents to +50 cents mapping to -pi/3 to +pi/3
    final needleAngle = -pi / 2 + (centsOffset / 50) * (pi / 3);
    final needleEnd = Offset(
      center.dx + (radius - 24) * cos(needleAngle),
      center.dy + (radius - 24) * sin(needleAngle),
    );

    final isInTune = centsOffset.abs() <= 3.0;
    final needlePaint = Paint()
      ..color = isInTune ? PlonixTheme.success : PlonixTheme.accent
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, needleEnd, needlePaint);

    // Center hub
    canvas.drawCircle(center, 22, Paint()..color = PlonixTheme.surface);
    canvas.drawCircle(
      center,
      22,
      Paint()..color = isInTune ? PlonixTheme.success : PlonixTheme.accent..style = PaintingStyle.stroke..strokeWidth = 2.5,
    );
  }

  @override
  bool shouldRepaint(covariant PitchStrobeWheelPainter oldDelegate) {
    return oldDelegate.centsOffset != centsOffset ||
        oldDelegate.noteName != noteName ||
        oldDelegate.frequencyHz != frequencyHz;
  }
}
