import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../app/brand.dart';
import '../app/theme.dart';
import 'plonix_store.dart';
import 'screens.dart';

class ProductApp extends StatefulWidget {
  const ProductApp({super.key});
  @override
  State<ProductApp> createState() => _ProductAppState();
}

class _ProductAppState extends State<ProductApp> {
  final store = PlonixStore();
  final PageController _controller = PageController();
  
  @override
  void initState() {
    super.initState();
    _init();
  }
  
  Future<void> _init() async {
    try {
      final content = await rootBundle.loadString('packages/plonix/product/content.json');
      await store.load(content);
    } catch (e) {
      await store.load('{"presets":[]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: cBg,
          appBar: AppBar(title: Text('Plonix Tuner', style: AppTheme.display(cSurface)), backgroundColor: cBg),
          body: PageView(
            controller: _controller,
            children: const [
              PitchGenScreen(),
              ToneDialScreen(),
              ScaleIntervalScreen(),
              TuningPresetsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
