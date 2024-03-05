import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';

typedef CreateFile = File Function(String);
typedef GetDirectoryPath = Future<String?> Function();

class DataClient {
  DataClient({
    this.createFile = File.new,
    GetDirectoryPath? overrideGetDirectoryPath,
  }) : _getDirectoryPath = overrideGetDirectoryPath ?? getDirectoryPath;

  final CreateFile createFile;
  late final GetDirectoryPath _getDirectoryPath;

  Future<void> saveJson(String filePath, Map<String, dynamic> json) async {
    final file = createFile(filePath);
    await file.writeAsString(jsonEncode(json));
  }

  File file(String filePath) {
    return createFile(filePath);
  }

  Future<String?> directoryPath() => _getDirectoryPath();
}
