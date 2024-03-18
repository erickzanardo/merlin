// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:merlin/merlin.dart';
import 'package:merlin_editor/app/app.dart';

void main() {
  group('AppState', () {
    test('can be instantiated', () {
      final appState = InitialAppState();
      expect(appState, isA<AppState>());

      final loadingFailedAppState = LoadingFailedAppState(error: 'error');
      expect(loadingFailedAppState, isA<AppState>());

      final loadedAppState = LoadedAppState(
        projectPath: 'projectPath',
        gameData: MerlinGameData(
          name: '',
          resolutionWidth: 1,
          resolutionHeight: 1,
          gridSize: 1,
        ),
        levels: const {},
      );
      expect(loadedAppState, isA<AppState>());
    });

    test('InitialAppState supports value comparison', () {
      expect(InitialAppState(), InitialAppState());
    });

    test('LoadingFailedAppState supports value comparison', () {
      expect(
        LoadingFailedAppState(error: 'error'),
        LoadingFailedAppState(error: 'error'),
      );

      expect(
        LoadingFailedAppState(error: 'error'),
        isNot(LoadingFailedAppState(error: 'error2')),
      );
    });

    test('LoadedAppState supports value comparison', () {
      expect(
        LoadedAppState(
          projectPath: 'projectPath',
          gameData: MerlinGameData(
            name: '',
            resolutionWidth: 1,
            resolutionHeight: 1,
            gridSize: 1,
          ),
          levels: const {},
        ),
        LoadedAppState(
          projectPath: 'projectPath',
          gameData: MerlinGameData(
            name: '',
            resolutionWidth: 1,
            resolutionHeight: 1,
            gridSize: 1,
          ),
          levels: const {},
        ),
      );

      expect(
        LoadedAppState(
          projectPath: 'projectPath',
          gameData: MerlinGameData(
            name: '',
            resolutionWidth: 1,
            resolutionHeight: 1,
            gridSize: 1,
          ),
          levels: const {},
        ),
        isNot(
          LoadedAppState(
            projectPath: 'projectPath2',
            gameData: MerlinGameData(
              name: '',
              resolutionWidth: 1,
              resolutionHeight: 1,
              gridSize: 1,
            ),
            levels: const {},
          ),
        ),
      );

      expect(
        LoadedAppState(
          projectPath: 'projectPath',
          gameData: MerlinGameData(
            name: '',
            resolutionWidth: 1,
            resolutionHeight: 1,
            gridSize: 1,
          ),
          levels: const {},
        ),
        isNot(
          LoadedAppState(
            projectPath: 'projectPath',
            gameData: MerlinGameData(
              name: 'name',
              resolutionWidth: 1,
              resolutionHeight: 1,
              gridSize: 1,
            ),
            levels: const {},
          ),
        ),
      );

      expect(
        LoadedAppState(
          projectPath: 'projectPath',
          gameData: MerlinGameData(
            name: 'name',
            resolutionWidth: 1,
            resolutionHeight: 1,
            gridSize: 1,
          ),
          levels: const {},
        ),
        isNot(
          LoadedAppState(
            projectPath: 'projectPath',
            gameData: MerlinGameData(
              name: 'name',
              resolutionWidth: 1,
              resolutionHeight: 1,
              gridSize: 1,
            ),
            levels: const {
              '': MerlinGameLevel(
                scrollLength: 1,
                scrollSpeed: 2,
              ),
            },
          ),
        ),
      );
    });

    test('LoadedAppState copyWith returns a new instance', () {
      final loadedAppState = LoadedAppState(
        projectPath: 'projectPath',
        gameData: MerlinGameData(
          name: '',
          resolutionWidth: 1,
          resolutionHeight: 1,
          gridSize: 1,
        ),
        levels: const {},
      );

      final newLoadedAppState = loadedAppState.copyWith(
        projectPath: 'projectPath2',
        gameData: MerlinGameData(
          name: 'name',
          resolutionWidth: 2,
          resolutionHeight: 2,
          gridSize: 2,
        ),
        levels: const {
          '': MerlinGameLevel(
            scrollLength: 1,
            scrollSpeed: 2,
          ),
        },
      );

      expect(newLoadedAppState, isA<LoadedAppState>());
      expect(newLoadedAppState, isNot(loadedAppState));
    });
  });
}
