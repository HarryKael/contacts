import 'package:contacts/src/app.dart';
import 'package:contacts/src/consts/chars.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Contact App', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text(contactsString), findsOneWidget);
  });
}
