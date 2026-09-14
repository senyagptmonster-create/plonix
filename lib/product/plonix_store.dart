import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlonixStore extends ChangeNotifier {
  List<dynamic> presets = [];
  bool isLoading = true;

  Future<void> load(String jsonContent) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('plonix_data')) {
      await prefs.setString('plonix_data', jsonContent);
    }
    final data = json.decode(prefs.getString('plonix_data')!);
    presets = List.from(data['presets'] ?? []);
    isLoading = false;
    notifyListeners();
  }
}
