// ignore_for_file: prefer_const_declarations

import 'package:flutter_test/flutter_test.dart';
import 'package:merlin_editor/editor/editor.dart';

void main() {
  group('EditorState', () {
    test('can be instantiated', () {
      final editorState = const EditorState(
        openFiles: [],
      );
      expect(editorState, isA<EditorState>());
    });

    test('supports value comparison', () {
      expect(
        const EditorState(
          openFiles: [],
        ),
        const EditorState(
          openFiles: [],
        ),
      );

      expect(
        const EditorState(
          openFiles: [],
        ),
        isNot(
          const EditorState(
            openFiles: ['file'],
          ),
        ),
      );
    });

    test('copyWith returns a new instance with updated values', () {
      expect(
        const EditorState(
          openFiles: [],
        ).copyWith(openFiles: ['file']),
        const EditorState(
          openFiles: ['file'],
        ),
      );
    });
  });
}
