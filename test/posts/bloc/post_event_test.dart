import 'package:flutter_infinite_list/posts/bloc/post_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostEvent', () {
    group('PostFetched', () {
      test('supports value equality', () {
        expect(PostFetched(), equals(PostFetched()));
      });

      test('props are correct', () {
        expect(PostFetched().props, equals([]));
      });
    });
  });
}
