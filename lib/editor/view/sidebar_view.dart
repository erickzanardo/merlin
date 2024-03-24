import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merlin_editor/app/app.dart';
import 'package:merlin_editor/editor/editor.dart';
import 'package:nes_ui/nes_ui.dart';

class SidebarView extends StatefulWidget {
  const SidebarView({super.key});

  @override
  State<SidebarView> createState() => _SidebarViewState();
}

class _SidebarViewState extends State<SidebarView> {
  late final _controller = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            OverlayPortal(
              controller: _controller,
              overlayChildBuilder: (context) {
                return Positioned(
                  top: 72,
                  left: 16,
                  child: NesContainer(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NesPressable(
                          onPress: () async {
                            _controller.hide();
                            final appCubit = context.read<AppCubit>();
                            final level = await LevelFormDialog.show(context);
                            if (level != null) {
                              await appCubit.createLevel(level);
                            }
                          },
                          child: Row(
                            children: [
                              NesIcon(iconData: NesIcons.gallery),
                              const SizedBox(width: 8),
                              const Text('Map'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        NesPressable(
                          onPress: () async {
                            final appCubit = context.read<AppCubit>();
                            final enemy = await EnemyFormDialog.show(context);
                            if (enemy != null) {
                              //await appCubit.createEnemy(enemy);
                            }
                          },
                          child: Row(
                            children: [
                              NesIcon(iconData: NesIcons.alien),
                              const SizedBox(width: 8),
                              const Text('Enemy'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: NesIconButton(
                icon: NesIcons.newFile,
                onPress: () {
                  _controller.toggle();
                },
              ),
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
                      context.read<EditorCubit>().openFile(entry.path);
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
