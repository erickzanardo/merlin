import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merlin_editor/editor/editor.dart';

void main() {
  group('EditorCubit', () {
    blocTest<EditorCubit, EditorState>(
      'openFile',
      build: EditorCubit.new,
      act: (cubit) => cubit.openFile('file'),
      expect: () => const <EditorState>[
        EditorState(
          openFiles: ['file'],
        ),
      ],
    );

    blocTest<EditorCubit, EditorState>(
      "don't open the same file twice",
      build: EditorCubit.new,
      act: (cubit) {
        cubit
          ..openFile('file')
          ..openFile('file');
      },
      expect: () => const <EditorState>[
        EditorState(
          openFiles: ['file'],
        ),
      ],
    );

    blocTest<EditorCubit, EditorState>(
      'closeFile',
      build: () => EditorCubit()..openFile('file'),
      act: (cubit) => cubit.closeFile('file'),
      expect: () => const <EditorState>[
        EditorState(
          openFiles: [],
        ),
      ],
    );
  });
}
