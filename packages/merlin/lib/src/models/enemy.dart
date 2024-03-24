import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:merlin/merlin.dart';

part 'enemy.g.dart';

@JsonSerializable()

/// {@template merlin_enemy}
/// A class that holds the enemy data an enemy.
/// {@endtemplate}
class MerlinEnemy extends Equatable {
  /// {@macro merlin_enemy}
  const MerlinEnemy({
    required this.name,
    required this.asset,
    required this.width,
    required this.height,
  });

  /// Creates a [MerlinEnemy] from a JSON map.
  factory MerlinEnemy.fromJson(Map<String, dynamic> json) =>
      _$MerlinEnemyFromJson(json);

  /// The name of the enemy.
  final String name;

  /// The asset of the enemy.
  final MerlinAsset asset;

  /// The width of the enemy.
  final int width;

  /// The height of the enemy.
  final int height;

  /// Returns this instance as a JSON map.
  Map<String, dynamic> toJson() => _$MerlinEnemyToJson(this);

  @override
  List<Object?> get props => [
        name,
        asset,
        width,
        height,
      ];
}
