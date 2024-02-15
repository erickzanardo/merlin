import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:merlin_editor/clients/clients.dart';
import 'package:mocktail/mocktail.dart';

class _MockFile extends Mock implements File {}

void main() {
  group('DataClient', () {
    test('saveJson', () async {
      final mockFile = _MockFile();
      when(() => mockFile.writeAsString(any())).thenAnswer(
        (_) async => mockFile,
      );
      final dataClient = DataClient(createFile: (_) => mockFile);

      const filePath = 'test.json';
      final json = <String, dynamic>{'key': 'value'};
      await dataClient.saveJson(filePath, json);

      verify(() => mockFile.writeAsString(jsonEncode(json))).called(1);
    });
  });
}
