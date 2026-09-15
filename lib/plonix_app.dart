import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/plonix_decor.dart';
import 'viewmodels/pitch_tuner_viewmodel.dart';
import 'views/pitch_generator_view.dart';
import 'views/tone_dial_view.dart';
import 'views/intervals_view.dart';
import 'views/tuning_presets_view.dart';

class PlonixApp extends StatelessWidget {
  const PlonixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PitchTunerViewModel(),
      child: MaterialApp(
        title: 'Plonix Pitch Tuner',
        theme: PlonixDecor.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const PlonixHomeScaffold(),
      ),
    );
  }
}

class PlonixHomeScaffold extends StatefulWidget {
  const PlonixHomeScaffold({super.key});

  @override
  State<PlonixHomeScaffold> createState() => _PlonixHomeScaffoldState();
}

class _PlonixHomeScaffoldState extends State<PlonixHomeScaffold> {
  int _currentIndex = 0;

  final _titles = ['Pitch Generator', 'Chromatic Dial', 'Interval Ratios', 'Instrument Tunings'];
  final _views = const [
    PitchGeneratorView(),
    ToneDialView(),
    IntervalsView(),
    TuningPresetsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: _views[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.music_note_outlined), selectedIcon: Icon(Icons.music_note), label: 'Pitch'),
          NavigationDestination(icon: Icon(Icons.dialpad_outlined), selectedIcon: Icon(Icons.dialpad), label: 'Dial'),
          NavigationDestination(icon: Icon(Icons.linear_scale_outlined), selectedIcon: Icon(Icons.linear_scale), label: 'Intervals'),
          NavigationDestination(icon: Icon(Icons.tune_outlined), selectedIcon: Icon(Icons.tune), label: 'Presets'),
        ],
      ),
    );
  }
}
