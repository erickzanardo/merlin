import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merlin/merlin.dart';
import 'package:merlin_editor/app/app.dart';
import 'package:merlin_editor/editor/editor.dart';
import 'package:merlin_editor/project/project.dart';
import 'package:nes_ui/nes_ui.dart';

class _MockAppCubit extends MockCubit<AppState> implements AppCubit {}

void main() {
  group('AppPage', () {
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
      mockStates([const InitialAppState()]);
    });

    testWidgets('renders', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: flutterNesTheme(),
          home: BlocProvider.value(
            value: appCubit,
            child: const AppPage(),
          ),
        ),
      );
      expect(find.byType(AppView), findsOneWidget);
    });

    testWidgets('renders the project form on new button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: flutterNesTheme(),
          home: BlocProvider.value(
            value: appCubit,
            child: const AppPage(),
          ),
        ),
      );
      await tester.tap(find.text('New Project'));
      await tester.pumpAndSettle();
      expect(find.byType(ProjectForm), findsOneWidget);
    });

    testWidgets(
      'navigates to the editor page when a project is loaded',
      (tester) async {
        mockStates(
          [
            const InitialAppState(),
            const LoadedAppState(
              projectPath: '',
              gameData: MerlinGameData(
                name: '',
                resolutionWidth: 100,
                resolutionHeight: 100,
                gridSize: 5,
              ),
              levels: {},
            ),
          ],
        );
        await tester.pumpWidget(
          BlocProvider.value(
            value: appCubit,
            child: MaterialApp(
              theme: flutterNesTheme(),
              home: const AppPage(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();
        expect(find.byType(EditorPage), findsOneWidget);
      },
    );
  });
}
