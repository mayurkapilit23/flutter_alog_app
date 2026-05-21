import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_alog_app/main.dart';

void main() {
  testWidgets('Number Grid App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NumberGridApp());

    // Verify that the title is visible.
    expect(find.text('Number Grid'), findsOneWidget);
  });
}
