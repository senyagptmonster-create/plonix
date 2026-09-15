import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pitch_tuner_viewmodel.dart';
import '../ui/plonix_decor.dart';

class ToneDialView extends StatelessWidget {
  const ToneDialView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PitchTunerViewModel>();

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: vm.chromaticScale.length,
      itemBuilder: (context, idx) {
        final note = vm.chromaticScale[idx];
        final isSelected = note == vm.selectedNote;

        return InkWell(
          onTap: () => vm.selectNote(note),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? PlonixDecor.neonCyan.withValues(alpha: 0.2) : PlonixDecor.cardSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? PlonixDecor.neonCyan : Colors.transparent,
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              note,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isSelected ? PlonixDecor.neonCyan : PlonixDecor.lightText,
              ),
            ),
          ),
        );
      },
    );
  }
}
