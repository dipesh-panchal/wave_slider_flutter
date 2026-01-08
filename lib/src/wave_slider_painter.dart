import 'dart:math';
import 'package:flutter/material.dart';
import 'wave_slider_theme.dart';

/// @nodoc
/// Custom painter responsible for rendering the wave slider track and thumb.
///
/// This painter draws:
/// - The inactive baseline after the thumb
/// - The active animated wave before the thumb
/// - The thumb in various supported shapes
class WaveSliderPainter extends CustomPainter {
  /// Normalized slider progress in the range `0.0` to `1.0`.
  final double progress;

  /// Current animation phase used to animate the wave.
  final double phase;

  /// Whether the wave should be rendered as a flat line.
  ///
  /// Typically enabled while dragging to improve visual stability.
  final bool flat;

  /// Visual configuration for the wave slider.
  final WaveSliderTheme theme;

  /// Creates a [WaveSliderPainter].
  WaveSliderPainter({
    required this.progress,
    required this.phase,
    required this.flat,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;
    final clampedProgress = progress.clamp(0.0, 1.0);
    final thumbX = size.width * clampedProgress;

    final inactivePaint = Paint()
      ..color = theme.inactiveColor
      ..strokeWidth = theme.strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final activePaint = Paint()
      ..color = theme.activeColor
      ..strokeWidth = theme.strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    // ─────────────────────────────
    // Inactive baseline (after thumb)
    // ─────────────────────────────
    if (thumbX < size.width) {
      canvas.drawLine(
        Offset(thumbX, centerY),
        Offset(size.width, centerY),
        inactivePaint,
      );
    }

    // ─────────────────────────────
    // Active wave path
    // ─────────────────────────────
    final path = Path();

    for (double x = 0; x <= thumbX; x++) {
      final wave = flat
          ? 0.0
          : sin(
                (x / size.width * theme.frequency * 2 * pi) + phase,
              ) *
              theme.amplitude;

      final y = centerY + wave;

      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, activePaint);

    // ─────────────────────────────
    // Thumb rendering
    // ─────────────────────────────
    if (theme.thumbShape != WaveSliderThumbShape.none) {
      final thumbPaint = Paint()
        ..color = theme.thumbColor
        ..style = PaintingStyle.fill;

      switch (theme.thumbShape) {
        case WaveSliderThumbShape.circle:
          canvas.drawCircle(
            Offset(thumbX, centerY),
            theme.thumbRadius,
            thumbPaint,
          );
          break;

        case WaveSliderThumbShape.bar:
          final rect = RRect.fromRectAndRadius(
            Rect.fromCenter(
              center: Offset(thumbX, centerY),
              width: theme.thumbBarWidth,
              height: theme.thumbBarHeight,
            ),
            Radius.circular(theme.thumbBarWidth),
          );
          canvas.drawRRect(rect, thumbPaint);
          break;

        case WaveSliderThumbShape.diamond:
          final r = theme.thumbRadius;
          final path = Path()
            ..moveTo(thumbX, centerY - r)
            ..lineTo(thumbX + r, centerY)
            ..lineTo(thumbX, centerY + r)
            ..lineTo(thumbX - r, centerY)
            ..close();
          canvas.drawPath(path, thumbPaint);
          break;

        case WaveSliderThumbShape.star:
          final r = theme.thumbRadius;
          final innerR = r * 0.45;
          final path = Path();

          for (int i = 0; i < 10; i++) {
            final radius = i.isEven ? r : innerR;
            final angle = (pi / 5) * i - pi / 2;
            final x = thumbX + cos(angle) * radius;
            final y = centerY + sin(angle) * radius;

            if (i == 0) {
              path.moveTo(x, y);
            } else {
              path.lineTo(x, y);
            }
          }

          path.close();
          canvas.drawPath(path, thumbPaint);
          break;

        case WaveSliderThumbShape.none:
          break;
      }
    }
  }

  @override
  bool shouldRepaint(covariant WaveSliderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.phase != phase ||
        oldDelegate.flat != flat ||
        oldDelegate.theme != theme;
  }
}
