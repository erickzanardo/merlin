import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'editor_state.dart';

class EditorCubit extends Cubit<EditorState> {
  EditorCubit()
      : super(
          const EditorState(
            openFiles: [],
          ),
        );

  void openFile(String file) {
    if (state.openFiles.contains(file)) {
      return;
    }
    final openFiles = List<String>.from(state.openFiles)..add(file);
    emit(state.copyWith(openFiles: openFiles));
  }

  void closeFile(String file) {
    final openFiles = List<String>.from(state.openFiles)..remove(file);
    emit(
      state.copyWith(
        openFiles: openFiles,
      ),
    );
  }
}
