import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/posts/bloc/post_bloc.dart';
import 'package:flutter_infinite_list/posts/bloc/post_event.dart';
import 'package:flutter_infinite_list/posts/bloc/post_state.dart';
import 'package:flutter_infinite_list/posts/models/post.dart';
import 'package:flutter_infinite_list/posts/view/posts_list.dart';
import 'package:flutter_infinite_list/posts/widgets/bottom_loader.dart';
import 'package:flutter_infinite_list/posts/widgets/post_list_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostBloc extends MockBloc<PostEvent, PostState> implements PostBloc {}

extension on WidgetTester {
  Future<void> pumpPostsList(PostBloc postBloc) {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(value: postBloc, child: const PostsList()),
        ),
      ),
    );
  }
}

void main() {
  group('PostsList', () {
    const mockPosts = [
      Post(id: 1, title: 'Post 1', body: 'Body 1'),
      Post(id: 2, title: 'Post 2', body: 'Body 2'),
      Post(id: 3, title: 'Post 3', body: 'Body 3'),
    ];

    late PostBloc postBloc;

    setUpAll(() {
      registerFallbackValue(PostFetched());
    });

    setUp(() {
      postBloc = MockPostBloc();
    });

    testWidgets('renders CircularProgressIndicator when state is initial', (
      tester,
    ) async {
      when(() => postBloc.state).thenReturn(const PostState());

      await tester.pumpPostsList(postBloc);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders error text when state is failure', (tester) async {
      when(
        () => postBloc.state,
      ).thenReturn(const PostState(status: PostStatus.failure));

      await tester.pumpPostsList(postBloc);

      expect(find.text('failed to fetch posts'), findsOneWidget);
    });

    testWidgets('renders list of posts when state is success', (tester) async {
      when(() => postBloc.state).thenReturn(
        const PostState(status: PostStatus.success, posts: mockPosts),
      );

      await tester.pumpPostsList(postBloc);

      expect(find.byType(PostListItem), findsNWidgets(3));
    });

    testWidgets('renders BottomLoader when hasReachedMax is false', (
      tester,
    ) async {
      when(() => postBloc.state).thenReturn(
        const PostState(
          status: PostStatus.success,
          posts: mockPosts,
          hasReachedMax: false,
        ),
      );

      await tester.pumpPostsList(postBloc);

      expect(find.byType(BottomLoader), findsOneWidget);
    });

    testWidgets('does not render BottomLoader when hasReachedMax is true', (
      tester,
    ) async {
      when(() => postBloc.state).thenReturn(
        const PostState(
          status: PostStatus.success,
          posts: mockPosts,
          hasReachedMax: true,
        ),
      );

      await tester.pumpPostsList(postBloc);

      expect(find.byType(BottomLoader), findsNothing);
    });

    testWidgets('scroll controller is attached', (tester) async {
      when(() => postBloc.state).thenReturn(
        const PostState(
          status: PostStatus.success,
          posts: mockPosts,
          hasReachedMax: false,
        ),
      );

      await tester.pumpPostsList(postBloc);

      // Verify ListView is rendered which uses the scroll controller
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('disposes scroll controller', (tester) async {
      when(() => postBloc.state).thenReturn(
        const PostState(status: PostStatus.success, posts: mockPosts),
      );

      await tester.pumpPostsList(postBloc);

      // Remove the widget
      await tester.pumpWidget(const SizedBox.shrink());

      // Should not throw an error
      expect(tester.takeException(), isNull);
    });
  });
}
