
import 'dart:convert';
import 'dart:io';

typedef CreateFile = File Function(String);

class DataClient {

  DataClient({
    this.createFile = File.new,
  });

  final CreateFile createFile;

  Future<void> saveJson(String filePath, Map<String, dynamic> json) async {
    final file = createFile(filePath);
    await file.writeAsString(jsonEncode(json));
  }
}
