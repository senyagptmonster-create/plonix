import 'package:flutter_test/flutter_test.dart';
import 'package:plonix/plonix_app.dart';

void main() {
  testWidgets('PlonixApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PlonixApp());
    await tester.pump();
    expect(find.text('Pitch Generator'), findsWidgets);
  });
}
