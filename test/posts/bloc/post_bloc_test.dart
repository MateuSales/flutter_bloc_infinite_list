import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_infinite_list/posts/bloc/post_bloc.dart';
import 'package:flutter_infinite_list/posts/bloc/post_event.dart';
import 'package:flutter_infinite_list/posts/bloc/post_state.dart';
import 'package:flutter_infinite_list/posts/models/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('PostBloc', () {
    const mockPosts = [
      Post(id: 1, title: 'Post 1', body: 'Body 1'),
      Post(id: 2, title: 'Post 2', body: 'Body 2'),
      Post(id: 3, title: 'Post 3', body: 'Body 3'),
    ];

    late http.Client httpClient;

    setUpAll(() {
      registerFallbackValue(Uri());
    });

    setUp(() {
      httpClient = MockHttpClient();
    });

    test('initial state is PostState()', () {
      expect(PostBloc(httpClient: httpClient).state, equals(const PostState()));
    });

    group('PostFetched', () {
      blocTest<PostBloc, PostState>(
        'emits nothing when posts has reached maximum amount',
        build: () => PostBloc(httpClient: httpClient),
        seed: () => const PostState(hasReachedMax: true),
        act: (bloc) => bloc.add(PostFetched()),
        expect: () => [],
      );

      blocTest<PostBloc, PostState>(
        'emits successful state when http fetches initial posts',
        setUp: () {
          when(() => httpClient.get(any())).thenAnswer((_) async {
            return http.Response('''[
                {"id": 1, "title": "Post 1", "body": "Body 1"},
                {"id": 2, "title": "Post 2", "body": "Body 2"},
                {"id": 3, "title": "Post 3", "body": "Body 3"}
              ]''', 200);
          });
        },
        build: () => PostBloc(httpClient: httpClient),
        act: (bloc) => bloc.add(PostFetched()),
        expect: () => const <PostState>[
          PostState(
            status: PostStatus.success,
            posts: mockPosts,
            hasReachedMax: false,
          ),
        ],
      );

      blocTest<PostBloc, PostState>(
        'drops new events when processing current event',
        setUp: () {
          when(() => httpClient.get(any())).thenAnswer((_) async {
            return http.Response('''[
                {"id": 1, "title": "Post 1", "body": "Body 1"},
                {"id": 2, "title": "Post 2", "body": "Body 2"},
                {"id": 3, "title": "Post 3", "body": "Body 3"}
              ]''', 200);
          });
        },
        build: () => PostBloc(httpClient: httpClient),
        act: (bloc) => bloc
          ..add(PostFetched())
          ..add(PostFetched())
          ..add(PostFetched()),
        expect: () => const <PostState>[
          PostState(
            status: PostStatus.success,
            posts: mockPosts,
            hasReachedMax: false,
          ),
        ],
      );

      blocTest<PostBloc, PostState>(
        'throttles events',
        setUp: () {
          when(() => httpClient.get(any())).thenAnswer((_) async {
            return http.Response('''[
                {"id": 1, "title": "Post 1", "body": "Body 1"}
              ]''', 200);
          });
        },
        build: () => PostBloc(httpClient: httpClient),
        act: (bloc) async {
          bloc.add(PostFetched());
          await Future<void>.delayed(Duration.zero);
          bloc.add(PostFetched());
          await Future<void>.delayed(Duration.zero);
          bloc.add(PostFetched());
        },
        expect: () => const <PostState>[
          PostState(
            status: PostStatus.success,
            posts: [Post(id: 1, title: 'Post 1', body: 'Body 1')],
            hasReachedMax: false,
          ),
        ],
      );

      blocTest<PostBloc, PostState>(
        'emits failure state when http fetches posts and throws',
        setUp: () {
          when(
            () => httpClient.get(any()),
          ).thenAnswer((_) async => http.Response('', 500));
        },
        build: () => PostBloc(httpClient: httpClient),
        act: (bloc) => bloc.add(PostFetched()),
        expect: () => const <PostState>[PostState(status: PostStatus.failure)],
      );

      blocTest<PostBloc, PostState>(
        'emits successful state with hasReachedMax true when 0 additional posts are fetched',
        setUp: () {
          when(
            () => httpClient.get(any()),
          ).thenAnswer((_) async => http.Response('[]', 200));
        },
        build: () => PostBloc(httpClient: httpClient),
        act: (bloc) => bloc.add(PostFetched()),
        expect: () => const <PostState>[PostState(hasReachedMax: true)],
      );

      blocTest<PostBloc, PostState>(
        'emits successful state and appends posts when more posts are fetched',
        setUp: () {
          when(() => httpClient.get(any())).thenAnswer((_) async {
            return http.Response('''[
                {"id": 4, "title": "Post 4", "body": "Body 4"},
                {"id": 5, "title": "Post 5", "body": "Body 5"}
              ]''', 200);
          });
        },
        build: () => PostBloc(httpClient: httpClient),
        seed: () =>
            const PostState(status: PostStatus.success, posts: mockPosts),
        act: (bloc) => bloc.add(PostFetched()),
        expect: () => const <PostState>[
          PostState(
            status: PostStatus.success,
            posts: [
              ...mockPosts,
              Post(id: 4, title: 'Post 4', body: 'Body 4'),
              Post(id: 5, title: 'Post 5', body: 'Body 5'),
            ],
          ),
        ],
      );
    });
  });
}
