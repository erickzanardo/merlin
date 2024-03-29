import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merlin_editor/editor/editor.dart';
import 'package:merlin_editor/level_editor/level_editor.dart';
import 'package:nes_ui/nes_ui.dart';

class EditorPage extends StatelessWidget {
  const EditorPage({super.key});

  static Route<void> route() {
    return NesVerticalGridTransition.route<void>(
      pageBuilder: (context, _, __) {
        return BlocProvider(
          create: (context) {
            return EditorCubit();
          },
          child: const EditorPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const EditorView();
  }
}

class EditorView extends StatelessWidget {
  const EditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NesSplitPanel(
        initialSizes: const [
          .4,
          .6,
        ],
        children: const [
          NesContainer(child: SidebarView()),
          NesContainer(child: WorkspaceView()),
        ],
      ),
    );
  }
}

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  String _parseLabel(String value) {
    return value.split('/').last;
  }

  @override
  Widget build(BuildContext context) {
    final openFiles = context.select(
      (EditorCubit cubit) => cubit.state.openFiles,
    );
    return NesTabView(
      onTabClosed: (index) {
        context.read<EditorCubit>().closeFile(openFiles[index]);
      },
      tabs: [
        for (int i = 0; i < openFiles.length; i++)
          NesTabItem(
            label: _parseLabel(openFiles[i]),
            child: Builder(
              builder: (context) {
                final file = openFiles[i];
                if (file.startsWith('/levels/')) {
                  return LevelEditorView(level: file);
                }

                return const SizedBox.expand();
              },
            ),
          ),
      ],
    );
  }
}
