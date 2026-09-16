import 'package:flutter/material.dart';
import 'theme/plonix_theme.dart';
import 'painters/pitch_strobe_wheel_painter.dart';

class PlonixApp extends StatefulWidget {
  const PlonixApp({super.key});

  @override
  State<PlonixApp> createState() => _PlonixAppState();
}

class _PlonixAppState extends State<PlonixApp> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _selectedNote = 'A';
  final int _octave = 4;
  double _a4CalibrationHz = 440.0;
  double _centsOffset = 0.0;

  final List<String> _notes = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plonix Tuner',
      debugShowCheckedModeBanner: false,
      theme: PlonixTheme.themeData,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PLONIX PITCH TUNER',
              style: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold, fontSize: 16)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (idx) => setState(() => _currentPage = idx),
                  children: [
                    _buildTunerPage(),
                    _buildPresetsPage(),
                    _buildIntervalsPage(),
                  ],
                ),
              ),
              // Indicators
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    final isSel = _currentPage == i;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isSel ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isSel ? PlonixTheme.accent : PlonixTheme.edge,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTunerPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Strobe Wheel Visualizer
          Center(
            child: SizedBox(
              width: 220,
              height: 220,
              child: CustomPaint(
                painter: PitchStrobeWheelPainter(
                  centsOffset: _centsOffset,
                  noteName: '$_selectedNote$_octave',
                  frequencyHz: _a4CalibrationHz,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$_selectedNote$_octave',
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: PlonixTheme.ink),
                      ),
                      Text(
                        '${_a4CalibrationHz.toStringAsFixed(1)} Hz',
                        style: const TextStyle(fontSize: 11, color: PlonixTheme.accent, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Cents Deviation Indicator
          Text(
            '${_centsOffset > 0 ? "+" : ""}${_centsOffset.round()} CENTS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _centsOffset.abs() <= 3 ? PlonixTheme.success : PlonixTheme.accent,
              letterSpacing: 1.2,
            ),
          ),
          Slider(
            value: _centsOffset,
            min: -50,
            max: 50,
            activeColor: PlonixTheme.accent,
            inactiveColor: PlonixTheme.edge,
            onChanged: (v) => setState(() => _centsOffset = v),
          ),
          const SizedBox(height: 16),
          // Note Selector Chips
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _notes.map((n) {
              final isSel = _selectedNote == n;
              return ChoiceChip(
                label: Text(n),
                selected: isSel,
                selectedColor: PlonixTheme.accent,
                labelStyle: TextStyle(color: isSel ? Colors.black : Colors.white, fontWeight: FontWeight.bold),
                onSelected: (_) => setState(() => _selectedNote = n),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // A440 Calibration Slider
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PlonixTheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: PlonixTheme.edge),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('A4 Calibration Base:'),
                    Text('${_a4CalibrationHz.toStringAsFixed(1)} Hz',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: PlonixTheme.accentLight)),
                  ],
                ),
                Slider(
                  value: _a4CalibrationHz,
                  min: 432.0,
                  max: 444.0,
                  activeColor: PlonixTheme.accent,
                  onChanged: (v) => setState(() => _a4CalibrationHz = v),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetsPage() {
    final presets = [
      {'inst': 'Guitar Standard', 'tuning': 'E2 - A2 - D3 - G3 - B3 - E4'},
      {'inst': 'Bass Standard', 'tuning': 'E1 - A1 - D2 - G2'},
      {'inst': 'Violin / Mandolin', 'tuning': 'G3 - D4 - A4 - E5'},
      {'inst': 'Ukulele C6', 'tuning': 'G4 - C4 - E4 - A4'},
      {'inst': 'Drop D Guitar', 'tuning': 'D2 - A2 - D3 - G3 - B3 - E4'},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Instrument Tuning Presets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...presets.map((p) => Card(
              color: PlonixTheme.surface,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: PlonixTheme.edge),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.music_note, color: PlonixTheme.accent),
                title: Text(p['inst']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(p['tuning']!, style: const TextStyle(color: PlonixTheme.muted, fontSize: 13)),
              ),
            )),
      ],
    );
  }

  Widget _buildIntervalsPage() {
    final intervals = [
      {'name': 'Unison', 'ratio': '1:1', 'cents': '0'},
      {'name': 'Perfect Fifth', 'ratio': '3:2', 'cents': '702'},
      {'name': 'Perfect Fourth', 'ratio': '4:3', 'cents': '498'},
      {'name': 'Major Third', 'ratio': '5:4', 'cents': '386'},
      {'name': 'Octave', 'ratio': '2:1', 'cents': '1200'},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Just Intonation Harmonic Ratios', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...intervals.map((inv) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: PlonixTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: PlonixTheme.edge),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(inv['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${inv['ratio']} (${inv['cents']} cents)',
                      style: const TextStyle(color: PlonixTheme.accentLight, fontWeight: FontWeight.bold)),
                ],
              ),
            )),
      ],
    );
  }
}
