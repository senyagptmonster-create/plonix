import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pitch_preset.dart';

class PitchTunerViewModel extends ChangeNotifier {
  double _a4Reference = 440.0;
  String _selectedNote = 'A';
  int _octave = 4;
  bool _isGeneratingTone = false;

  final List<String> chromaticScale = [
    'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'
  ];

  final List<TuningInstrument> instruments = const [
    TuningInstrument(
      name: 'Guitar (Standard)',
      category: 'Strings',
      notes: ['E2', 'A2', 'D3', 'G3', 'B3', 'E4'],
      frequencies: [82.41, 110.00, 146.83, 196.00, 246.94, 329.63],
    ),
    TuningInstrument(
      name: 'Violin',
      category: 'Bowed',
      notes: ['G3', 'D4', 'A4', 'E5'],
      frequencies: [196.00, 293.66, 440.00, 659.25],
    ),
    TuningInstrument(
      name: 'Cello',
      category: 'Bowed',
      notes: ['C2', 'G2', 'D3', 'A3'],
      frequencies: [65.41, 98.00, 146.83, 220.00],
    ),
    TuningInstrument(
      name: 'Ukulele (Standard C)',
      category: 'Fretted',
      notes: ['G4', 'C4', 'E4', 'A4'],
      frequencies: [392.00, 261.63, 329.63, 440.00],
    ),
    TuningInstrument(
      name: 'Bass (4-String)',
      category: 'Bass',
      notes: ['E1', 'A1', 'D2', 'G2'],
      frequencies: [41.20, 55.00, 73.42, 98.00],
    ),
  ];

  PitchTunerViewModel() {
    _loadPrefs();
  }

  double get a4Reference => _a4Reference;
  String get selectedNote => _selectedNote;
  int get octave => _octave;
  bool get isGeneratingTone => _isGeneratingTone;

  double get currentFrequency {
    final noteIndex = chromaticScale.indexOf(_selectedNote);
    final aIndex = chromaticScale.indexOf('A');
    final semitonesFromA4 = (noteIndex - aIndex) + (_octave - 4) * 12;
    return _a4Reference * pow(2.0, semitonesFromA4 / 12.0);
  }

  void setA4Reference(double ref) {
    _a4Reference = ref;
    _savePrefs();
    notifyListeners();
  }

  void selectNote(String note) {
    _selectedNote = note;
    notifyListeners();
  }

  void setOctave(int oct) {
    _octave = oct.clamp(1, 7);
    notifyListeners();
  }

  void toggleTone() {
    _isGeneratingTone = !_isGeneratingTone;
    notifyListeners();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _a4Reference = prefs.getDouble('plonix_a4') ?? 440.0;
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('plonix_a4', _a4Reference);
  }
}
