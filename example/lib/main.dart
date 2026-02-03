import 'package:flutter/material.dart';
import 'package:wave_slider_flutter/wave_slider_flutter.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WaveSliderExample(),
    );
  }
}

class WaveSliderExample extends StatefulWidget {
  const WaveSliderExample({super.key});

  @override
  State<WaveSliderExample> createState() => _WaveSliderExampleState();
}

class _WaveSliderExampleState extends State<WaveSliderExample> {
  double value = 0.35;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Wave Slider Example'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WaveSlider(
                value: value,
                onChanged: (v) => setState(() => value = v),
                theme: const WaveSliderTheme(
                  activeColor: Colors.red,
                  thumbColor: Colors.red,
                  amplitude: 4,
                  frequency: 5,
                  thumbShape: WaveSliderThumbShape.diamond,
                ),
                controller: const WaveSliderController(
                  animateWave: true,
                  flatlineOnDrag: true,
                ),
              ),
              WaveSlider(
                value: value,
                onChanged: (v) => setState(() => value = v),
                theme: const WaveSliderTheme(
                  activeColor: Colors.green,
                  thumbColor: Colors.green,
                  amplitude: 4,
                  frequency: 10,
                  thumbShape: WaveSliderThumbShape.circle,
                ),
                controller: const WaveSliderController(
                  animateWave: true,
                  flatlineOnDrag: true,
                ),
              ),
              WaveSlider(
                value: value,
                onChanged: (v) => setState(() => value = v),
                theme: const WaveSliderTheme(
                  amplitude: 4,
                  frequency: 15,
                  thumbShape: WaveSliderThumbShape.bar,
                ),
                controller: const WaveSliderController(
                  animateWave: true,
                  flatlineOnDrag: true,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Value: ${value.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
