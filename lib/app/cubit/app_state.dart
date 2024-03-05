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
  });

  final String projectPath;
  final MerlinGameData gameData;

  @override
  List<Object?> get props => [projectPath, gameData];
}
