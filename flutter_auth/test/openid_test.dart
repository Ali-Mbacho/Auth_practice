import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' hide expect;
import 'package:test/test.dart';
import '../lib/main.dart';

//The response if it prints anything

void main() {
  testWidgets("Given params the acces token is not null",
      (WidgetTester tester) async {
    //Finds the widget
    final acessString = find.byKey(const ValueKey("Authenticate"));

    //The actual test
    await tester.pumpWidget(const MyApp());
    await tester.tap(acessString);
    await tester.pump();

    //Check the outputs
    expect(find.textContaining(RegExp(r"^[\w-]*\.[\w-]*\.[\w-]*$")),
        findsOneWidget);
    ;
  });
}
