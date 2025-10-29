import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/posts/bloc/post_bloc.dart';
import 'package:flutter_infinite_list/posts/view/posts_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('PostsPage', () {
    late http.Client httpClient;

    setUp(() {
      httpClient = MockHttpClient();
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => PostBloc(httpClient: httpClient),
            child: const PostsPage(),
          ),
        ),
      );

      expect(find.byType(PostsPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);

      // Clean up pending timers
      await tester.pumpAndSettle(const Duration(milliseconds: 150));
    });

    testWidgets('is a StatelessWidget', (tester) async {
      expect(const PostsPage(), isA<StatelessWidget>());
    });
  });
}
