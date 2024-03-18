part of 'editor_cubit.dart';

class EditorState extends Equatable {
  const EditorState({
    required this.openFiles,
  });

  final List<String> openFiles;

  EditorState copyWith({
    List<String>? openFiles,
  }) {
    return EditorState(
      openFiles: openFiles ?? this.openFiles,
    );
  }

  @override
  List<Object?> get props => [
        openFiles,
      ];
}
