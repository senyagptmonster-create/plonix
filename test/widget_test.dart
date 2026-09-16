import 'package:flutter_test/flutter_test.dart';
import 'package:plonix/plonix_app.dart';

void main() {
  testWidgets('PlonixApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PlonixApp());
    expect(find.text('PLONIX PITCH TUNER'), findsOneWidget);
    expect(find.textContaining('CENTS'), findsOneWidget);
  });
}
