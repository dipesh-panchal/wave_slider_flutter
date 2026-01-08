/// Controls the behavior and animation characteristics of a WaveSlider.
///
/// This controller allows fine-grained customization of how the wave
/// responds to user interaction and animation direction.
class WaveSliderController {
  /// Whether the wave animation is enabled.
  ///
  /// If set to `false`, the wave remains static even when the slider value
  /// changes.
  final bool animateWave;

  /// Whether the wave flattens while the user is dragging the slider.
  ///
  /// When enabled, the wave becomes a flat line during drag interaction,
  /// improving visual clarity and responsiveness.
  final bool flatlineOnDrag;

  /// Whether the wave animation direction is reversed.
  ///
  /// Useful for creating mirrored or inverted wave effects.
  final bool reverseDirection;

  /// Creates a [WaveSliderController] with configurable wave behavior.
  ///
  /// All parameters are optional and have sensible defaults.
  const WaveSliderController({
    this.animateWave = true,
    this.flatlineOnDrag = true,
    this.reverseDirection = false,
  });
}
