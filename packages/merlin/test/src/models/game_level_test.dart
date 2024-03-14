// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:merlin/merlin.dart';

void main() {
  group('MerlinGameLevel', () {
    test('can be instantiated', () {
      expect(
        MerlinGameLevel(
          scrollLength: 10,
          scrollSpeed: 10,
        ),
        isA<MerlinGameLevel>(),
      );
    });

    test('can serialize to json', () {
      expect(
        MerlinGameLevel(
          scrollLength: 10,
          scrollSpeed: 10,
        ).toJson(),
        {
          'scrollLength': 10,
          'scrollSpeed': 10,
        },
      );
    });

    test('can deserialize from json', () {
      expect(
        MerlinGameLevel.fromJson(const {
          'scrollLength': 10,
          'scrollSpeed': 10,
        }),
        MerlinGameLevel(
          scrollLength: 10,
          scrollSpeed: 10,
        ),
      );
    });

    test('supports equality', () {
      final instance = MerlinGameLevel(
        scrollLength: 10,
        scrollSpeed: 10,
      );
      expect(
        instance,
        equals(
          MerlinGameLevel(
            scrollLength: 10,
            scrollSpeed: 10,
          ),
        ),
      );

      expect(
        instance,
        isNot(
          equals(
            MerlinGameLevel(
              scrollLength: 20,
              scrollSpeed: 10,
            ),
          ),
        ),
      );

      expect(
        instance,
        isNot(
          equals(
            MerlinGameLevel(
              scrollLength: 10,
              scrollSpeed: 20,
            ),
          ),
        ),
      );
    });
  });
}
