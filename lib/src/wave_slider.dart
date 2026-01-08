import 'dart:math';
import 'package:flutter/material.dart';

import 'wave_slider_controller.dart';
import 'wave_slider_painter.dart';
import 'wave_slider_theme.dart';

/// An animated, customizable wave-style slider widget.
///
/// The [WaveSlider] displays a horizontal slider where the active portion
/// is rendered as a sine wave. It supports animated waves, multiple thumb
/// shapes, and fine-grained visual customization via [WaveSliderTheme]
/// and [WaveSliderController].
///
/// The slider value is normalized between `0.0` and `1.0`.
class WaveSlider extends StatefulWidget {
  /// Current value of the slider, normalized between `0.0` and `1.0`.
  final double value;

  /// Called whenever the slider value changes due to user interaction.
  final ValueChanged<double> onChanged;

  /// Visual configuration for the wave slider.
  final WaveSliderTheme theme;

  /// Behavioral configuration for wave animation and interaction.
  final WaveSliderController controller;

  /// Height of the slider widget.
  ///
  /// This includes the wave track and the thumb.
  final double height;

  /// Creates a [WaveSlider].
  ///
  /// The [value] must be between `0.0` and `1.0`.
  const WaveSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.theme = const WaveSliderTheme(),
    this.controller = const WaveSliderController(),
    this.height = 40,
  });

  @override
  State<WaveSlider> createState() => _WaveSliderState();
}

/// Internal state for [WaveSlider].
class _WaveSliderState extends State<WaveSlider>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;
  bool _dragging = false;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  /// Updates the slider value based on the horizontal position.
  void _updateValue(Offset localPosition, double width) {
    final v = (localPosition.dx / width).clamp(0.0, 1.0);
    widget.onChanged(v);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return GestureDetector(
          onHorizontalDragStart: (_) => setState(() => _dragging = true),
          onHorizontalDragEnd: (_) => setState(() => _dragging = false),
          onHorizontalDragUpdate: (details) =>
              _updateValue(details.localPosition, constraints.maxWidth),
          onTapDown: (details) =>
              _updateValue(details.localPosition, constraints.maxWidth),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return CustomPaint(
                size: Size(double.infinity, widget.height),
                painter: WaveSliderPainter(
                  progress: widget.value,
                  phase: widget.controller.animateWave
                      ? _animation.value * 2 * pi
                      : 0,
                  flat: widget.controller.flatlineOnDrag && _dragging,
                  theme: widget.theme,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
