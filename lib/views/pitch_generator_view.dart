import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pitch_tuner_viewmodel.dart';
import '../ui/plonix_decor.dart';

class PitchGeneratorView extends StatelessWidget {
  const PitchGeneratorView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PitchTunerViewModel>();
    final freq = vm.currentFrequency.toStringAsFixed(2);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
            decoration: BoxDecoration(
              color: PlonixDecor.cardSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: PlonixDecor.neonCyan.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(vm.selectedNote,
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                          color: PlonixDecor.neonCyan,
                        )),
                    Text('${vm.octave}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: PlonixDecor.vividOrange,
                        )),
                  ],
                ),
                const SizedBox(height: 8),
                Text('$freq Hz',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: PlonixDecor.lightText,
                    )),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => vm.toggleTone(),
                  icon: Icon(vm.isGeneratingTone ? Icons.stop : Icons.volume_up),
                  label: Text(vm.isGeneratingTone ? 'Mute Pitch' : 'Emit Sine Tone'),
                  style: FilledButton.styleFrom(
                    backgroundColor: vm.isGeneratingTone ? PlonixDecor.vividOrange : PlonixDecor.neonCyan,
                    foregroundColor: PlonixDecor.darkCharcoal,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PlonixDecor.cardSurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('Concert Pitch Calibration: ${vm.a4Reference.toStringAsFixed(1)} Hz',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    TextButton(
                      onPressed: () => vm.setA4Reference(440.0),
                      child: const Text('Reset 440'),
                    ),
                  ],
                ),
                Slider(
                  value: vm.a4Reference,
                  min: 430.0,
                  max: 450.0,
                  divisions: 40,
                  activeColor: PlonixDecor.neonCyan,
                  onChanged: (val) => vm.setA4Reference(val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PlonixDecor.cardSurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Octave Register', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  onPressed: vm.octave > 1 ? () => vm.setOctave(vm.octave - 1) : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('${vm.octave}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: vm.octave < 7 ? () => vm.setOctave(vm.octave + 1) : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
