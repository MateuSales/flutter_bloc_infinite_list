import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/app.dart';
import 'package:flutter_infinite_list/posts/view/posts_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders PostsPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(PostsPage), findsOneWidget);

      // Clean up pending timers
      await tester.pumpAndSettle(const Duration(milliseconds: 150));
    });

    testWidgets('is a MaterialApp', (tester) async {
      expect(const App(), isA<MaterialApp>());
    });
  });
}
