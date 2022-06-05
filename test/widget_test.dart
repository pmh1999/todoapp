// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:get/get.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/controller/todo_controller.dart';

void main() {
  final TodosController controller = Get.put(TodosController());

  testWidgets('add todo smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('All'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    await tester.enterText(find.byKey(Key("title")), 'test title1');
    await tester.pump();
    await tester.enterText(find.byKey(Key("task")), 'test task1');
    await tester.pump();
    await tester.tap(find.byType(DialogButton));
    await tester.pump();
    expect(find.text('test title1'), findsOneWidget);
    expect(find.text('test task1'), findsOneWidget);

    // Verify that our counter has incremented.
  });

  testWidgets('update todo smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('All'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    await tester.enterText(find.byKey(Key("title")), 'test title');
    await tester.pump();
    await tester.enterText(find.byKey(Key("task")), 'test task');
    await tester.pump();
    await tester.tap(find.text("Submit"));
    await tester.pump();

    expect(find.text('test title'), findsOneWidget);
    expect(find.text('test task'), findsOneWidget);

    //expect(find.byType(Checkbox), findsOneWidget);
    await tester.tap(find.byType(Checkbox));

    // Verify that our counter has incremented.
  });
}
