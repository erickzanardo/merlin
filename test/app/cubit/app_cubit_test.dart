// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merlin/merlin.dart';
import 'package:merlin_editor/app/app.dart';
import 'package:merlin_editor/clients/clients.dart';
import 'package:merlin_editor/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

class _MockDataClient extends Mock implements DataClient {}

class _MockGameDataRepository extends Mock implements GameDataRepository {}

void main() {
  group('AppCubit', () {
    late DataClient mockDataClient;
    late GameDataRepository mockGameDataRepository;

    setUpAll(() {
      registerFallbackValue(
        MerlinGameLevel(
          scrollSpeed: 0,
          scrollLength: 0,
        ),
      );
      registerFallbackValue(
        MerlinGameData(
          name: '',
          resolutionWidth: 0,
          resolutionHeight: 0,
          gridSize: 0,
        ),
      );
    });

    setUp(() {
      mockDataClient = _MockDataClient();
      mockGameDataRepository = _MockGameDataRepository();
    });

    blocTest<AppCubit, AppState>(
      'loadProject',
      build: () => AppCubit(
        dataClient: mockDataClient,
        gameDataRepository: mockGameDataRepository,
      ),
      setUp: () {
        when(() => mockDataClient.directoryPath()).thenAnswer(
          (_) async => 'project_path',
        );
        when(() => mockGameDataRepository.loadGameData('project_path'))
            .thenAnswer(
          (_) async => MerlinGameData(
            name: '',
            resolutionWidth: 10,
            resolutionHeight: 10,
            gridSize: 10,
          ),
        );
      },
      act: (cubit) => cubit.loadProject(),
      expect: () => [
        LoadedAppState(
          projectPath: 'project_path',
          gameData: MerlinGameData(
            name: '',
            resolutionWidth: 10,
            resolutionHeight: 10,
            gridSize: 10,
          ),
          levels: const {},
        ),
      ],
    );

    blocTest<AppCubit, AppState>(
      'loadProject emit error when no game data is returned',
      build: () => AppCubit(
        dataClient: mockDataClient,
        gameDataRepository: mockGameDataRepository,
      ),
      setUp: () {
        when(() => mockDataClient.directoryPath()).thenAnswer(
          (_) async => 'project_path',
        );
        when(() => mockGameDataRepository.loadGameData('project_path'))
            .thenAnswer(
          (_) async => null,
        );
      },
      act: (cubit) => cubit.loadProject(),
      expect: () => [
        const LoadingFailedAppState(error: 'No game data found'),
      ],
    );

    blocTest<AppCubit, AppState>(
      'loadProject emit error when an error happens',
      build: () => AppCubit(
        dataClient: mockDataClient,
        gameDataRepository: mockGameDataRepository,
      ),
      setUp: () {
        when(() => mockDataClient.directoryPath()).thenAnswer(
          (_) async => 'project_path',
        );
        when(() => mockGameDataRepository.loadGameData(any())).thenThrow(
          Exception('error'),
        );
      },
      act: (cubit) => cubit.loadProject(),
      expect: () => [
        const LoadingFailedAppState(
          error: 'Error loading project: Exception: error',
        ),
      ],
    );

    blocTest<AppCubit, AppState>(
      'createProject',
      build: () => AppCubit(
        dataClient: mockDataClient,
        gameDataRepository: mockGameDataRepository,
      ),
      setUp: () {
        when(() => mockDataClient.directoryPath()).thenAnswer(
          (_) async => 'project_path',
        );
        when(
          () => mockGameDataRepository.saveGameData(
            'project_path',
            MerlinGameData(
              name: '',
              resolutionWidth: 10,
              resolutionHeight: 10,
              gridSize: 10,
            ),
          ),
        ).thenAnswer(
          (_) async => MerlinGameData(
            name: '',
            resolutionWidth: 10,
            resolutionHeight: 10,
            gridSize: 10,
          ),
        );
      },
      act: (cubit) => cubit.createProject(
        MerlinGameData(
          name: '',
          resolutionWidth: 10,
          resolutionHeight: 10,
          gridSize: 10,
        ),
      ),
      expect: () => [
        LoadedAppState(
          projectPath: 'project_path',
          gameData: MerlinGameData(
            name: '',
            resolutionWidth: 10,
            resolutionHeight: 10,
            gridSize: 10,
          ),
          levels: const {},
        ),
      ],
    );

    blocTest<AppCubit, AppState>(
      'createProject emit error when an error happens',
      build: () => AppCubit(
        dataClient: mockDataClient,
        gameDataRepository: mockGameDataRepository,
      ),
      setUp: () {
        when(() => mockDataClient.directoryPath()).thenAnswer(
          (_) async => 'project_path',
        );
        when(
          () => mockGameDataRepository.saveGameData(
            'project_path',
            MerlinGameData(
              name: '',
              resolutionWidth: 10,
              resolutionHeight: 10,
              gridSize: 10,
            ),
          ),
        ).thenThrow(
          Exception('error'),
        );
      },
      act: (cubit) => cubit.createProject(
        MerlinGameData(
          name: '',
          resolutionWidth: 10,
          resolutionHeight: 10,
          gridSize: 10,
        ),
      ),
      expect: () => [
        const LoadingFailedAppState(
          error: 'Error creating project: Exception: error',
        ),
      ],
    );

    blocTest<AppCubit, AppState>(
      'createLevel',
      build: () => AppCubit(
        dataClient: mockDataClient,
        gameDataRepository: mockGameDataRepository,
      ),
      setUp: () {
        when(
          () => mockGameDataRepository.saveLevel(
            projectPath: any(named: 'projectPath'),
            fileName: any(named: 'fileName'),
            level: any(named: 'level'),
          ),
        ).thenAnswer(
          (_) async => MerlinGameData(
            name: '',
            resolutionWidth: 10,
            resolutionHeight: 10,
            gridSize: 10,
          ),
        );
      },
      seed: () => LoadedAppState(
        projectPath: 'project_path',
        gameData: MerlinGameData(
          name: '',
          resolutionWidth: 10,
          resolutionHeight: 10,
          gridSize: 10,
        ),
        levels: const {},
      ),
      act: (cubit) => cubit.createLevel(
        (
          'level',
          MerlinGameLevel(
            scrollSpeed: 20,
            scrollLength: 20,
          ),
        ),
      ),
      expect: () => [
        LoadedAppState(
          projectPath: 'project_path',
          gameData: MerlinGameData(
            name: '',
            resolutionWidth: 10,
            resolutionHeight: 10,
            gridSize: 10,
          ),
          levels: const {
            'level': MerlinGameLevel(
              scrollSpeed: 20,
              scrollLength: 20,
            ),
          },
        ),
      ],
    );
  });
}
