import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merlin_editor/editor/editor.dart';
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
          NesContainer(
            child: SizedBox.expand(),
          ),
        ],
      ),
    );
  }
}
