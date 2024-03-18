part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class InitialAppState extends AppState {
  const InitialAppState();

  @override
  List<Object?> get props => [];
}

class LoadingFailedAppState extends AppState {
  const LoadingFailedAppState({
    required this.error,
  });

  final String error;

  @override
  List<Object?> get props => [error];
}

class LoadedAppState extends AppState {
  const LoadedAppState({
    required this.projectPath,
    required this.gameData,
    required this.levels,
  });

  final String projectPath;
  final MerlinGameData gameData;
  final Map<String, MerlinGameLevel> levels;

  LoadedAppState copyWith({
    String? projectPath,
    MerlinGameData? gameData,
    Map<String, MerlinGameLevel>? levels,
  }) {
    return LoadedAppState(
      projectPath: projectPath ?? this.projectPath,
      gameData: gameData ?? this.gameData,
      levels: levels ?? this.levels,
    );
  }

  @override
  List<Object?> get props => [
        projectPath,
        gameData,
        levels,
      ];
}
