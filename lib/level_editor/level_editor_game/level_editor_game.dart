import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:merlin/merlin.dart';

class LevelEditorGame extends FlameGame {
  LevelEditorGame({
    required this.gameData,
    required this.level,
  });

  final MerlinGameData gameData;
  final MerlinGameLevel level;

  late final Vector2 resolution;
  late final double fontSize;

  late final gridColor = const Color(0xFF495c41);
  List<int> _visibleRows = [];

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    resolution = Vector2(
      gameData.resolutionWidth.toDouble(),
      gameData.resolutionHeight.toDouble(),
    );

    fontSize = gameData.gridSize * .26;

    camera = CameraComponent.withFixedResolution(
      width: resolution.x,
      height: resolution.y,
      backdrop: RectangleComponent(
        size: resolution.clone(),
        paint: Paint()..color = const Color(0xFF222222),
      ),
    )
      ..viewfinder.anchor = Anchor.topLeft
      ..viewfinder.position = Vector2(
        0,
        level.scrollLength - resolution.y,
      );

    _updateTiles();
  }

  double get maxY => level.scrollLength - resolution.y;
  double get scrollProgress => camera.viewfinder.position.y / maxY;

  void onScrollChange(double delta) {
    final newY = math.max(
      0.toDouble(),
      camera.viewfinder.position.y + delta,
    );
    camera.viewfinder.position = Vector2(0, math.min(newY, maxY));

    _updateTiles();
  }

  void _updateTiles() {
    final startY = (camera.viewfinder.position.y / gameData.gridSize).floor();

    final endY = startY + (resolution.y / gameData.gridSize).ceil();

    final visibleRows = <int>[];
    for (var y = startY; y < endY; y++) {
      visibleRows.add(y);
    }

    final rowsToAdd = visibleRows.toSet().difference(_visibleRows.toSet());
    final rowsToRemove = _visibleRows.toSet().difference(visibleRows.toSet());

    for (var x = 0; x < resolution.x / gameData.gridSize; x++) {
      for (final y in rowsToAdd) {
        world.add(
          Tile(
            index: Vector2(x.toDouble(), y.toDouble()),
            size: Vector2.all(
              gameData.gridSize.toDouble(),
            ),
          ),
        );
      }
    }

    world.children.whereType<Tile>().where((tile) {
      return rowsToRemove.contains(tile.index.y.toInt());
    }).forEach((tile) {
      tile.removeFromParent();
    });

    _visibleRows = visibleRows;
  }
}

class Tile extends PositionComponent with HasGameRef<LevelEditorGame> {
  Tile({
    required this.index,
    required super.size,
  }) : super(
          position: Vector2(
            index.x * size!.x,
            index.y * size.y,
          ),
        );

  final Vector2 index;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    add(
      RectangleComponent(
        size: size,
        paint: Paint()
          ..color = gameRef.gridColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      ),
    );

    add(
      TextComponent(
        position: Vector2(1, 1),
        text: 'x: ${index.x.toInt()}\ny: ${index.y.toInt()}',
        textRenderer: TextPaint(
          style: TextStyle(
            color: gameRef.gridColor,
            fontSize: gameRef.fontSize,
          ),
        ),
      ),
    );
  }
}
