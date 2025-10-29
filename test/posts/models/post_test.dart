import 'package:flutter_infinite_list/posts/models/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Post', () {
    test('supports value equality', () {
      const post1 = Post(id: 1, title: 'Title', body: 'Body');
      const post2 = Post(id: 1, title: 'Title', body: 'Body');

      expect(post1, equals(post2));
    });

    test('props are correct', () {
      const post = Post(id: 1, title: 'Title', body: 'Body');

      expect(post.props, equals([1, 'Title', 'Body']));
    });

    test('different posts are not equal', () {
      const post1 = Post(id: 1, title: 'Title 1', body: 'Body 1');
      const post2 = Post(id: 2, title: 'Title 2', body: 'Body 2');

      expect(post1, isNot(equals(post2)));
    });
  });
}
