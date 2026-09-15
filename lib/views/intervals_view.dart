import 'package:flutter/material.dart';
import '../ui/plonix_decor.dart';

class IntervalsView extends StatelessWidget {
  const IntervalsView({super.key});

  @override
  Widget build(BuildContext context) {
    final intervals = [
      {'name': 'Unison', 'ratio': '1:1', 'semitones': '0'},
      {'name': 'Minor Second', 'ratio': '16:15', 'semitones': '1'},
      {'name': 'Major Second', 'ratio': '9:8', 'semitones': '2'},
      {'name': 'Minor Third', 'ratio': '6:5', 'semitones': '3'},
      {'name': 'Major Third', 'ratio': '5:4', 'semitones': '4'},
      {'name': 'Perfect Fourth', 'ratio': '4:3', 'semitones': '5'},
      {'name': 'Tritone / Diminished 5th', 'ratio': '45:32', 'semitones': '6'},
      {'name': 'Perfect Fifth', 'ratio': '3:2', 'semitones': '7'},
      {'name': 'Minor Sixth', 'ratio': '8:5', 'semitones': '8'},
      {'name': 'Major Sixth', 'ratio': '5:3', 'semitones': '9'},
      {'name': 'Minor Seventh', 'ratio': '9:5', 'semitones': '10'},
      {'name': 'Major Seventh', 'ratio': '15:8', 'semitones': '11'},
      {'name': 'Octave', 'ratio': '2:1', 'semitones': '12'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: intervals.length,
      itemBuilder: (context, idx) {
        final item = intervals[idx];
        return Card(
          color: PlonixDecor.cardSurface,
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${item['semitones']} semitones away', style: const TextStyle(color: PlonixDecor.subtleText, fontSize: 12)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: PlonixDecor.darkCharcoal,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: PlonixDecor.neonCyan.withValues(alpha: 0.4)),
              ),
              child: Text(item['ratio']!,
                  style: const TextStyle(color: PlonixDecor.neonCyan, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
        );
      },
    );
  }
}
