import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_data.g.dart';

@JsonSerializable()

/// {@template merlin_game_data}
/// A class that holds the game data for the Merlin game.
/// {@endtemplate}
class MerlinGameData extends Equatable {
  /// {@macro merlin_game_data}
  const MerlinGameData({
    required this.name,
    required this.resolutionWidth,
    required this.resolutionHeight,
    required this.gridSize,
  });

  /// Creates a [MerlinGameData] from a JSON map.
  factory MerlinGameData.fromJson(Map<String, dynamic> json) =>
      _$MerlinGameDataFromJson(json);

  /// The name of the game.
  final String name;

  /// The resolution width of the game.
  final int resolutionWidth;

  /// The resolution height of the game.
  final int resolutionHeight;

  /// The size of the grid.
  final int gridSize;

  /// Returns this instance as a JSON map.
  Map<String, dynamic> toJson() => _$MerlinGameDataToJson(this);

  @override
  List<Object?> get props => [
        name,
        resolutionWidth,
        resolutionHeight,
        gridSize,
      ];
}
