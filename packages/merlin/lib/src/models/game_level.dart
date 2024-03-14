import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_level.g.dart';

@JsonSerializable()

/// {@template merlin_game_level}
/// A class that holds the data for a level in a Merlin game.
/// {@endtemplate}
class MerlinGameLevel extends Equatable {
  /// {@macro merlin_game_level}
  const MerlinGameLevel({
    required this.scrollLength,
    required this.scrollSpeed,
  });

  /// Creates a [MerlinGameLevel] from a JSON map.
  factory MerlinGameLevel.fromJson(Map<String, dynamic> json) =>
      _$MerlinGameLevelFromJson(json);

  /// The total length of the scroll in pixels.
  final double scrollLength;

  /// The speed at which the scroll moves in pixels per second.
  final double scrollSpeed;

  /// Returns this instance as a JSON map.
  Map<String, dynamic> toJson() => _$MerlinGameLevelToJson(this);

  @override
  List<Object?> get props => [
        scrollLength,
        scrollSpeed,
      ];
}
