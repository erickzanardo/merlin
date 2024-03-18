import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';

typedef CreateFile = File Function(String);
typedef CreateDirectory = Directory Function(String);
typedef GetDirectoryPath = Future<String?> Function();

class DataClient {
  DataClient({
    this.createFile = File.new,
    this.createDirectory = Directory.new,
    GetDirectoryPath? overrideGetDirectoryPath,
  }) : _getDirectoryPath = overrideGetDirectoryPath ?? getDirectoryPath;

  final CreateFile createFile;
  final CreateDirectory createDirectory;
  late final GetDirectoryPath _getDirectoryPath;

  Future<void> saveJson(String filePath, Map<String, dynamic> json) async {
    final file = createFile(filePath);
    await file.writeAsString(jsonEncode(json));
  }

  File file(String filePath) {
    return createFile(filePath);
  }

  Directory directory(String directoryPath) {
    return createDirectory(directoryPath);
  }

  Future<String?> directoryPath() => _getDirectoryPath();
}
