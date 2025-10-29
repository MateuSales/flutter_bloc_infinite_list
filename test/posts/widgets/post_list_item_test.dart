import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/post.dart';
import 'package:flutter_infinite_list/posts/widgets/post_list_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostListItem', () {
    const mockPost = Post(id: 1, title: 'Test Title', body: 'Test Body');

    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PostListItem(post: mockPost)),
        ),
      );

      expect(find.text('1'), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Body'), findsOneWidget);
    });

    testWidgets('displays post id as leading text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PostListItem(post: mockPost)),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.leading, isA<Text>());
    });

    testWidgets('displays post title as title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PostListItem(post: mockPost)),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.title, isA<Text>());
    });

    testWidgets('displays post body as subtitle', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PostListItem(post: mockPost)),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.subtitle, isA<Text>());
      expect(listTile.isThreeLine, isTrue);
    });
  });
}
