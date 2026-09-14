import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/brand.dart';
import '../app/theme.dart';
import 'plonix_store.dart';

class PitchGenScreen extends StatelessWidget {
  const PitchGenScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('A440 Calibration', style: AppTheme.display(cAccent)),
          Slider(value: 440, min: 430, max: 450, onChanged: (v) {}),
        ],
      ),
    );
  }
}

class ToneDialScreen extends StatelessWidget {
  const ToneDialScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200, height: 200,
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: cAccent, width: 4)),
        child: Center(child: Text('C#', style: AppTheme.display(cInk))),
      ),
    );
  }
}

class ScaleIntervalScreen extends StatelessWidget {
  const ScaleIntervalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Perfect 5th: 700 cents', style: AppTheme.display(cAccent2)),
    );
  }
}

class TuningPresetsScreen extends StatelessWidget {
  const TuningPresetsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = context.watch<PlonixStore>();
    return ListView.builder(
      itemCount: store.presets.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(store.presets[index]['name'], style: AppTheme.text(cInk)),
          trailing: Text(store.presets[index]['freq'], style: AppTheme.text(cEdge)),
        );
      },
    );
  }
}
