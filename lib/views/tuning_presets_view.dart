import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pitch_tuner_viewmodel.dart';
import '../ui/plonix_decor.dart';

class TuningPresetsView extends StatelessWidget {
  const TuningPresetsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PitchTunerViewModel>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vm.instruments.length,
      itemBuilder: (context, idx) {
        final inst = vm.instruments[idx];

        return Card(
          color: PlonixDecor.cardSurface,
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(inst.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Text(inst.category, style: const TextStyle(color: PlonixDecor.vividOrange, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (int i = 0; i < inst.notes.length; i++)
                      InkWell(
                        onTap: () {
                          final noteName = inst.notes[i].replaceAll(RegExp(r'[0-9]'), '');
                          final octStr = inst.notes[i].replaceAll(RegExp(r'[^0-9]'), '');
                          vm.selectNote(noteName);
                          if (octStr.isNotEmpty) {
                            vm.setOctave(int.tryParse(octStr) ?? 4);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected ${inst.notes[i]} (${inst.frequencies[i].toStringAsFixed(1)} Hz)')),
                          );
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: PlonixDecor.darkCharcoal,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: PlonixDecor.neonCyan.withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            children: [
                              Text(inst.notes[i], style: const TextStyle(fontWeight: FontWeight.bold, color: PlonixDecor.neonCyan)),
                              Text('${inst.frequencies[i].toStringAsFixed(0)} Hz', style: const TextStyle(fontSize: 10, color: PlonixDecor.subtleText)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
