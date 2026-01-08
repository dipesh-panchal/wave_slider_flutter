import 'package:flutter/material.dart';

/// Defines the shape used for the WaveSlider thumb.
enum WaveSliderThumbShape {
  /// No thumb is rendered.
  none,

  /// A circular thumb.
  circle,

  /// A vertical bar thumb (similar to Android 13 slider style).
  bar,

  /// A diamond-shaped thumb.
  diamond,

  /// A star-shaped thumb.
  star,
}

/// Visual configuration for the WaveSlider.
///
/// This class controls the appearance of the wave track, animation
/// characteristics, and the thumb style.
class WaveSliderTheme {
  /// Color of the active (filled) wave segment.
  final Color activeColor;

  /// Color of the inactive (unfilled) track segment.
  final Color inactiveColor;

  /// Height of the wave peaks.
  ///
  /// Higher values result in taller wave oscillations.
  final double amplitude;

  /// Number of wave cycles across the slider width.
  ///
  /// Higher values produce denser wave patterns.
  final double frequency;

  /// Stroke width used for drawing the wave and track.
  final double strokeWidth;

  /// Shape used for rendering the slider thumb.
  final WaveSliderThumbShape thumbShape;

  /// Radius of the thumb when using circular or diamond shapes.
  final double thumbRadius;

  /// Height of the thumb when using the bar shape.
  final double thumbBarHeight;

  /// Width of the thumb when using the bar shape.
  final double thumbBarWidth;

  /// Fill color of the slider thumb.
  final Color thumbColor;

  /// Creates a [WaveSliderTheme] with customizable visual properties.
  ///
  /// All parameters have sensible defaults and can be overridden
  /// individually.
  const WaveSliderTheme({
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.amplitude = 2,
    this.frequency = 12,
    this.strokeWidth = 2,

    // Thumb defaults
    this.thumbShape = WaveSliderThumbShape.circle,
    this.thumbRadius = 6,
    this.thumbBarHeight = 18,
    this.thumbBarWidth = 4,
    this.thumbColor = Colors.blue,
  });
}
