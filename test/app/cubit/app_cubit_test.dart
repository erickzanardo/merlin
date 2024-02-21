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
  });
}
