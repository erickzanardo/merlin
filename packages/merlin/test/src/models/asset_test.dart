// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:merlin/merlin.dart';

void main() {
  group('MerlingSpriteAsset', () {
    test('can be instantiated', () {
      expect(
        MerlinSpriteAsset(
          path: 'path',
          srcX: 0,
          srcY: 0,
          srcWidth: 0,
          srcHeight: 0,
        ),
        isA<MerlinSpriteAsset>(),
      );
    });

    test('can be serialized to JSON', () {
      expect(
        MerlinSpriteAsset(
          path: 'path',
          srcX: 0,
          srcY: 0,
          srcWidth: 0,
          srcHeight: 0,
        ).toJson(),
        {
          'type': 'sprite',
          'path': 'path',
          'srcX': 0,
          'srcY': 0,
          'srcWidth': 0,
          'srcHeight': 0,
        },
      );
    });

    test('can be deserialized from JSON', () {
      expect(
        MerlinAsset.fromJson(const {
          'type': 'sprite',
          'path': 'path',
          'srcX': 0,
          'srcY': 0,
          'srcWidth': 0,
          'srcHeight': 0,
        }),
        isA<MerlinSpriteAsset>(),
      );
    });

    test('supports equality', () {
      final asset = MerlinSpriteAsset(
        path: 'path',
        srcX: 0,
        srcY: 0,
        srcWidth: 0,
        srcHeight: 0,
      );

      expect(
        asset,
        equals(
          MerlinSpriteAsset(
            path: 'path',
            srcX: 0,
            srcY: 0,
            srcWidth: 0,
            srcHeight: 0,
          ),
        ),
      );

      expect(
        asset,
        isNot(
          equals(
            MerlinSpriteAsset(
              path: 'path',
              srcX: 1,
              srcY: 0,
              srcWidth: 0,
              srcHeight: 0,
            ),
          ),
        ),
      );

      expect(
        asset,
        isNot(
          equals(
            MerlinSpriteAsset(
              path: 'path',
              srcX: 0,
              srcY: 1,
              srcWidth: 0,
              srcHeight: 0,
            ),
          ),
        ),
      );

      expect(
        asset,
        isNot(
          equals(
            MerlinSpriteAsset(
              path: 'path',
              srcX: 0,
              srcY: 0,
              srcWidth: 1,
              srcHeight: 0,
            ),
          ),
        ),
      );

      expect(
        asset,
        isNot(
          equals(
            MerlinSpriteAsset(
              path: 'path',
              srcX: 0,
              srcY: 0,
              srcWidth: 0,
              srcHeight: 1,
            ),
          ),
        ),
      );
    });
  });
}
