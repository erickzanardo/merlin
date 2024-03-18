import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merlin_editor/app/app.dart';
import 'package:merlin_editor/level_editor/level_editor.dart';
import 'package:nes_ui/nes_ui.dart';

class LevelEditorView extends StatefulWidget {
  const LevelEditorView({
    required this.level,
    super.key,
  });

  final String level;

  @override
  State<LevelEditorView> createState() => _LevelEditorViewState();
}

class _LevelEditorViewState extends State<LevelEditorView> {
  late final LevelEditorGame _game;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();

    final appCubit = context.read<AppCubit>();

    final state = appCubit.state;
    if (state is LoadedAppState) {
      final levelKey = widget.level.split('/').last;
      final level = state.levels[levelKey];

      if (level != null) {
        _game = LevelEditorGame(
          gameData: state.gameData,
          level: level,
        );

        _game.loaded.then((_) {
          setState(() {
            _loaded = true;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 80,
            child: GameWidget(game: _game),
          ),
          if (_loaded)
            Positioned(
              right: 8,
              top: 8,
              bottom: 8,
              child: GameScrollerController(game: _game),
            ),
        ],
      ),
    );
  }
}

class GameScrollerController extends StatefulWidget {
  const GameScrollerController({
    required this.game,
    super.key,
  });

  final LevelEditorGame game;

  @override
  State<GameScrollerController> createState() => _GameScrollerControllerState();
}

class _GameScrollerControllerState extends State<GameScrollerController> {
  @override
  Widget build(BuildContext context) {
    return NesContainer(
      backgroundColor: Colors.grey,
      padding: EdgeInsets.zero,
      width: 50,
      height: double.infinity,
      child: LayoutBuilder(
        builder: (context, contraints) {
          return Stack(
            children: [
              Positioned(
                top: widget.game.scrollProgress * (contraints.maxHeight - 40),
                left: 5,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      widget.game.onScrollChange(details.delta.dy);
                    });
                  },
                  child: const NesContainer(
                    backgroundColor: Colors.black,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
