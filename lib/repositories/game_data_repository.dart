import 'dart:convert';

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
}
