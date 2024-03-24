import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'asset.g.dart';

@JsonSerializable(
createFactory: false,
createToJson: false,
)

/// {@template merling_asset}
/// A class that holds the asset data for an asset.
/// {@endtemplate}
abstract class MerlinAsset extends Equatable {
  /// {@macro merling_asset}
  const MerlinAsset({
    required this.path,
  });

  /// Creates a [MerlinAsset] from a JSON map.
  factory MerlinAsset.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    if (type == 'sprite') {
      return MerlinSpriteAsset._fromJson(json);
    } else {
      throw ArgumentError.value(json, 'json', 'Invalid asset type: $type');
    }
  }


  /// Path of the asset.
  final String path;

  /// Returns this instance as a JSON map.
  Map<String, dynamic> toJson() {
    if (this is MerlinSpriteAsset) {
      return {
        'type': 'sprite',
        ...(this as MerlinSpriteAsset)._toJson(),
      };
    } else {
      throw Exception('Unknown asset type: $runtimeType');
    }
  }

  @override
  List<Object?> get props => [
        path,
      ];
}

@JsonSerializable()

/// {@template merlin_sprite_asset}
/// A class that holds the sprite asset data for a sprite asset.
/// {@endtemplate}
class MerlinSpriteAsset extends MerlinAsset {
  /// {@macro merlin_sprite_asset}
  const MerlinSpriteAsset({
    required super.path,
    this.srcX,
    this.srcY,
    this.srcWidth,
    this.srcHeight,
  });

  factory MerlinSpriteAsset._fromJson(Map<String, dynamic> json) =>
      _$MerlinSpriteAssetFromJson(json);

  /// X position of the source of the sprite.
  final int? srcX;

  /// Y position of the source of the sprite.
  final int? srcY;

  /// Width of the source of the sprite.
  final int? srcWidth;

  /// Height of the source of the sprite.
  final int? srcHeight;

  /// Returns this instance as a JSON map.
  Map<String, dynamic> _toJson() => _$MerlinSpriteAssetToJson(this);

  @override
  List<Object?> get props => [
        path,
        srcX,
        srcY,
        srcWidth,
        srcHeight,
      ];
}
