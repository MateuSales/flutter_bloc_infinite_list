import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/widgets/bottom_loader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BottomLoader', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BottomLoader())),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('has correct size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BottomLoader())),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(CircularProgressIndicator),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.height, equals(24));
      expect(sizedBox.width, equals(24));
    });

    testWidgets('circular progress indicator has correct stroke width', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BottomLoader())),
      );

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );

      expect(progressIndicator.strokeWidth, equals(1.5));
    });
  });
}
