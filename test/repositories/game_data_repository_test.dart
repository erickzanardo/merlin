// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:merlin/merlin.dart';
import 'package:merlin_editor/clients/clients.dart';
import 'package:merlin_editor/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

class _MockDataClient extends Mock implements DataClient {}

class _MockFile extends Mock implements File {}

void main() {
  group('GameDataRepository', () {
    late DataClient mockDataClient;

    setUp(() {
      mockDataClient = _MockDataClient();
    });

    test('saveGameData', () async {
      when(() => mockDataClient.saveJson(any(), any())).thenAnswer(
        (_) async {},
      );
      final gameDataRepository = GameDataRepository(dataClient: mockDataClient);

      const projectPath = 'project_path';
      final gameData = MerlinGameData(
        name: '',
        resolutionWidth: 10,
        resolutionHeight: 10,
        gridSize: 10,
      );
      await gameDataRepository.saveGameData(projectPath, gameData);

      verify(
        () => mockDataClient.saveJson(
          'project_path/game_data.merlin',
          gameData.toJson(),
        ),
      ).called(1);
    });

    test('loadGameData returns the data when it exist', () async {
      final file = _MockFile();
      when(() => mockDataClient.file(any())).thenReturn(
        file,
      );
      when(file.existsSync).thenReturn(true);
      when(file.readAsString).thenAnswer(
        (_) async => '{"name":"", "resolutionWidth":10, "resolutionHeight":10, '
            '"gridSize":10}',
      );
      final gameDataRepository = GameDataRepository(dataClient: mockDataClient);

      const projectPath = 'project_path';
      final gameData = await gameDataRepository.loadGameData(projectPath);

      expect(
        gameData,
        equals(
          MerlinGameData(
            name: '',
            resolutionWidth: 10,
            resolutionHeight: 10,
            gridSize: 10,
          ),
        ),
      );
    });

    test('loadGameData returns null when the data does not exist', () async {
      final file = _MockFile();
      when(() => mockDataClient.file(any())).thenReturn(
        file,
      );
      when(file.existsSync).thenReturn(false);
      final gameDataRepository = GameDataRepository(dataClient: mockDataClient);

      const projectPath = 'project_path';
      final gameData = await gameDataRepository.loadGameData(projectPath);

      expect(gameData, isNull);
    });
  });
}
