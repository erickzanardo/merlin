// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:merlin/merlin.dart';

void main() {
  group('MerlinGameData', () {
    test('can be instantiated', () {
      expect(
        MerlinGameData(
          name: 'name',
          resolutionWidth: 10,
          resolutionHeight: 10,
          gridSize: 10,
          scrollSize: 10,
          scrollingSpeed: 10,
        ),
        isA<MerlinGameData>(),
      );
    });

    test('can serialize to json', () {
      expect(
        MerlinGameData(
          name: 'name',
          resolutionWidth: 10,
          resolutionHeight: 10,
          gridSize: 10,
          scrollSize: 10,
          scrollingSpeed: 10,
        ).toJson(),
        {
          'name': 'name',
          'resolutionWidth': 10,
          'resolutionHeight': 10,
          'gridSize': 10,
          'scrollSize': 10,
          'scrollingSpeed': 10,
        },
      );
    });

    test('can deserialize from json', () {
      expect(
        MerlinGameData.fromJson(const {
          'name': 'name',
          'resolutionWidth': 10,
          'resolutionHeight': 10,
          'gridSize': 10,
          'scrollSize': 10,
          'scrollingSpeed': 10,
        }),
        MerlinGameData(
          name: 'name',
          resolutionWidth: 10,
          resolutionHeight: 10,
          gridSize: 10,
          scrollSize: 10,
          scrollingSpeed: 10,
        ),
      );
    });

    test('supports equality', () {
      final instance = MerlinGameData(
        name: 'name',
        resolutionWidth: 10,
        resolutionHeight: 10,
        gridSize: 10,
        scrollSize: 10,
        scrollingSpeed: 10,
      );

      expect(
        instance,
        equals(
          MerlinGameData(
            name: 'name',
            resolutionWidth: 10,
            resolutionHeight: 10,
            gridSize: 10,
            scrollSize: 10,
            scrollingSpeed: 10,
          ),
        ),
      );

      expect(
        instance,
        isNot(
          equals(
            MerlinGameData(
              name: 'name2',
              resolutionWidth: 10,
              resolutionHeight: 10,
              gridSize: 10,
              scrollSize: 10,
              scrollingSpeed: 10,
            ),
          ),
        ),
      );

      expect(
        instance,
        isNot(
          equals(
            MerlinGameData(
              name: 'name',
              resolutionWidth: 20,
              resolutionHeight: 10,
              gridSize: 10,
              scrollSize: 10,
              scrollingSpeed: 10,
            ),
          ),
        ),
      );

      expect(
        instance,
        isNot(
          equals(
            MerlinGameData(
              name: 'name',
              resolutionWidth: 10,
              resolutionHeight: 20,
              gridSize: 10,
              scrollSize: 10,
              scrollingSpeed: 10,
            ),
          ),
        ),
      );

      expect(
        instance,
        isNot(
          equals(
            MerlinGameData(
              name: 'name',
              resolutionWidth: 10,
              resolutionHeight: 10,
              gridSize: 20,
              scrollSize: 10,
              scrollingSpeed: 10,
            ),
          ),
        ),
      );

      expect(
        instance,
        isNot(
          equals(
            MerlinGameData(
              name: 'name',
              resolutionWidth: 10,
              resolutionHeight: 10,
              gridSize: 10,
              scrollSize: 20,
              scrollingSpeed: 10,
            ),
          ),
        ),
      );
    });
  });
}
