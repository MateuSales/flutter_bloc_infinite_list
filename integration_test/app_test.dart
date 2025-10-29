import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('app loads and displays posts', (tester) async {
      // Load app
      await tester.pumpWidget(const App());

      // Wait for initial loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for posts to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify posts are displayed
      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('infinite scroll loads more posts', (tester) async {
      // Load app
      await tester.pumpWidget(const App());

      // Wait for initial posts to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Count initial posts
      final initialPostCount = tester.widgetList(find.byType(ListTile)).length;

      // Scroll down to trigger loading more posts
      await tester.drag(find.byType(ListView), const Offset(0, -5000));

      // Wait for more posts to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify more posts were loaded
      final finalPostCount = tester.widgetList(find.byType(ListTile)).length;
      expect(finalPostCount, greaterThan(initialPostCount));
    });

    testWidgets('posts display correct information', (tester) async {
      // Load app
      await tester.pumpWidget(const App());

      // Wait for posts to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify at least one post is displayed with title and body
      final listTiles = tester.widgetList<ListTile>(find.byType(ListTile));
      expect(listTiles.isNotEmpty, isTrue);

      for (final listTile in listTiles) {
        expect(listTile.leading, isNotNull);
        expect(listTile.title, isNotNull);
        expect(listTile.subtitle, isNotNull);
      }
    });

    testWidgets('can scroll through all posts', (tester) async {
      // Load app
      await tester.pumpWidget(const App());

      // Wait for initial posts to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Scroll multiple times
      for (int i = 0; i < 5; i++) {
        await tester.drag(find.byType(ListView), const Offset(0, -3000));
        await tester.pumpAndSettle(const Duration(seconds: 3));
      }

      // Verify we can still see posts
      expect(find.byType(ListTile), findsWidgets);
    });
  });
}
