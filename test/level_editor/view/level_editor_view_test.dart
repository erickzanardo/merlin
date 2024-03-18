import 'package:bloc_test/bloc_test.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merlin/merlin.dart';
import 'package:merlin_editor/app/app.dart';
import 'package:merlin_editor/level_editor/level_editor.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nes_ui/nes_ui.dart';

class _MockAppCubit extends Mock implements AppCubit {}

void main() {
  group('LevelEditorView', () {
    late AppCubit appCubit;

    void mockStates(List<AppState> states) {
      whenListen(
        appCubit,
        Stream.fromIterable(states),
        initialState: states.first,
      );
    }

    setUp(() {
      appCubit = _MockAppCubit();

      mockStates(
        const [
          LoadedAppState(
            projectPath: 'project',
            gameData: MerlinGameData(
              name: '',
              resolutionWidth: 10,
              resolutionHeight: 10,
              gridSize: 5,
            ),
            levels: {
              'level': MerlinGameLevel(
                scrollLength: 800,
                scrollSpeed: 10,
              ),
            },
          ),
        ],
      );
    });

    testWidgets('renders', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: flutterNesTheme(),
          home: BlocProvider.value(
            value: appCubit,
            child: const LevelEditorView(level: 'levels/level'),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(GameWidget<LevelEditorGame>), findsOneWidget);
    });
  });
}
