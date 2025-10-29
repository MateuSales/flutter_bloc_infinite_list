import 'package:flutter_infinite_list/posts/bloc/post_state.dart';
import 'package:flutter_infinite_list/posts/models/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostState', () {
    test('supports value equality', () {
      const state1 = PostState(
        status: PostStatus.initial,
        posts: [],
        hasReachedMax: false,
      );
      const state2 = PostState(
        status: PostStatus.initial,
        posts: [],
        hasReachedMax: false,
      );

      expect(state1, equals(state2));
    });

    test('props are correct', () {
      const state = PostState(
        status: PostStatus.success,
        posts: [],
        hasReachedMax: true,
      );

      expect(state.props, equals([PostStatus.success, [], true]));
    });

    group('copyWith', () {
      test('returns same object if no parameters are provided', () {
        const state = PostState();
        expect(state.copyWith(), equals(state));
      });

      test('returns object with updated status when provided', () {
        const state = PostState();
        final updated = state.copyWith(status: PostStatus.success);

        expect(updated.status, equals(PostStatus.success));
        expect(updated.posts, equals(state.posts));
        expect(updated.hasReachedMax, equals(state.hasReachedMax));
      });

      test('returns object with updated posts when provided', () {
        const state = PostState();
        const posts = [
          Post(id: 1, title: 'Title 1', body: 'Body 1'),
          Post(id: 2, title: 'Title 2', body: 'Body 2'),
        ];
        final updated = state.copyWith(posts: posts);

        expect(updated.posts, equals(posts));
        expect(updated.status, equals(state.status));
        expect(updated.hasReachedMax, equals(state.hasReachedMax));
      });

      test('returns object with updated hasReachedMax when provided', () {
        const state = PostState();
        final updated = state.copyWith(hasReachedMax: true);

        expect(updated.hasReachedMax, isTrue);
        expect(updated.status, equals(state.status));
        expect(updated.posts, equals(state.posts));
      });
    });

    test('toString returns correct value', () {
      const state = PostState(
        status: PostStatus.success,
        posts: [],
        hasReachedMax: true,
      );

      expect(
        state.toString(),
        equals(
          'PostState { status: PostStatus.success, hasReachedMax: true, posts: 0 }',
        ),
      );
    });
  });
}
