import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merlin_editor/app/app.dart';
import 'package:merlin_editor/project/project.dart';
import 'package:nes_ui/nes_ui.dart';

class _MockAppCubit extends MockCubit<AppState> implements AppCubit {}

void main() {
  group('AppPage', () {
    late AppCubit appCubit;

    void mockState(AppState state) {
      whenListen(
        appCubit,
        Stream.fromIterable([state]),
        initialState: state,
      );
    }

    setUp(() {
      appCubit = _MockAppCubit();
      mockState(const InitialAppState());
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
  });
}
