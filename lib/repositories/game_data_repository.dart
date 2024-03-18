import 'dart:convert';
import 'dart:io';

import 'package:merlin/merlin.dart';
import 'package:merlin_editor/clients/clients.dart';
import 'package:path/path.dart' as path;

class GameDataRepository {
  GameDataRepository({
    required DataClient dataClient,
  }) : _dataClient = dataClient;

  final DataClient _dataClient;

  static const _fileName = 'game_data.merlin';

  Future<void> saveGameData(String projectPath, MerlinGameData gameData) async {
    final filePath = path.join(projectPath, _fileName);
    await _dataClient.saveJson(filePath, gameData.toJson());
  }

  Future<MerlinGameData?> loadGameData(String projectPath) async {
    final filePath = path.join(projectPath, _fileName);
    final file = _dataClient.file(filePath);

    if (!file.existsSync()) {
      return null;
    }

    final content = await file.readAsString();

    return MerlinGameData.fromJson(jsonDecode(content) as Map<String, dynamic>);
  }

  Future<void> saveLevel({
    required String projectPath,
    required String fileName,
    required MerlinGameLevel level,
  }) async {
    final filePath = path.join(
      projectPath,
      'levels',
      '$fileName.merlin_level',
    );
    final file = _dataClient.file(filePath);

    await file.create(recursive: true);
    await file.writeAsString(jsonEncode(level.toJson()));
  }

  Future<Map<String, MerlinGameLevel>> loadGameLevels(
    String projectPath,
  ) async {
    final levelsDirectory = _dataClient.directory(
      path.join(projectPath, 'levels'),
    );
    final files = levelsDirectory.listSync();

    final levels = <String, MerlinGameLevel>{};

    for (final file in files) {
      if (file is! File) {
        continue;
      }

      final content = await file.readAsString();

      final name = path.basenameWithoutExtension(file.path);
      levels[name] = MerlinGameLevel.fromJson(
        jsonDecode(content) as Map<String, dynamic>,
      );
    }

    return levels;
  }
}
