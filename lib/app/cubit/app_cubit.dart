import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merlin/merlin.dart';
import 'package:merlin_editor/clients/clients.dart';
import 'package:merlin_editor/repositories/repositories.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required DataClient dataClient,
    required GameDataRepository gameDataRepository,
  })  : _dataClient = dataClient,
        _gameDataRepository = gameDataRepository,
        super(const InitialAppState());

  final DataClient _dataClient;
  final GameDataRepository _gameDataRepository;

  Future<void> loadProject() async {
    final projectPath = await _dataClient.directoryPath();

    if (projectPath != null) {
      try {
        final gameData = await _gameDataRepository.loadGameData(projectPath);
        final gameLevels = await _gameDataRepository.loadGameLevels(
          projectPath,
        );

        if (gameData == null) {
          emit(const LoadingFailedAppState(error: 'No game data found'));
        } else {
          emit(
            LoadedAppState(
              projectPath: projectPath,
              gameData: gameData,
              levels: gameLevels,
            ),
          );
        }
      } catch (e, s) {
        addError(e, s);
        emit(LoadingFailedAppState(error: 'Error loading project: $e'));
      }
    }
  }

  Future<void> createProject(MerlinGameData data) async {
    final projectPath = await _dataClient.directoryPath();

    if (projectPath != null) {
      try {
        await _gameDataRepository.saveGameData(projectPath, data);
        emit(
          LoadedAppState(
            projectPath: projectPath,
            gameData: data,
            levels: const {},
          ),
        );
      } catch (e, s) {
        addError(e, s);
        emit(LoadingFailedAppState(error: 'Error creating project: $e'));
      }
    }
  }

  Future<void> createLevel((String, MerlinGameLevel) level) async {
    if (state is LoadedAppState) {
      final loadedState = state as LoadedAppState;

      await _gameDataRepository.saveLevel(
        projectPath: loadedState.projectPath,
        fileName: level.$1,
        level: level.$2,
      );

      emit(
        loadedState.copyWith(
          levels: {
            ...loadedState.levels,
            level.$1: level.$2,
          },
        ),
      );
    }
  }
}
