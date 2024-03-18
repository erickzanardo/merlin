import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merlin_editor/app/app.dart';
import 'package:merlin_editor/editor/editor.dart';
import 'package:nes_ui/nes_ui.dart';

class SidebarView extends StatelessWidget {
  const SidebarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            NesIconButton(
              icon: NesIcons.newFile,
              onPress: () async {
                final appCubit = context.read<AppCubit>();
                final level = await LevelFormDialog.show(context);
                if (level != null) {
                  await appCubit.createLevel(level);
                }
              },
            ),
            const SizedBox(height: 16),
            const Divider(),
            BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                if (state is LoadedAppState) {
                  return NesFileExplorer(
                    entries: [
                      const NesFolder('/levels'),
                      ...state.levels.entries.map(
                        (e) => NesFile('/levels/${e.key}'),
                      ),
                    ],
                    onOpenFile: (entry) {
                      // TODO(erickzanardo): Open file
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ],
    );
  }
}
