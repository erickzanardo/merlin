// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enemy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerlinEnemy _$MerlinEnemyFromJson(Map<String, dynamic> json) => MerlinEnemy(
      name: json['name'] as String,
      asset: MerlinAsset.fromJson(json['asset'] as Map<String, dynamic>),
      width: json['width'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$MerlinEnemyToJson(MerlinEnemy instance) =>
    <String, dynamic>{
      'name': instance.name,
      'asset': instance.asset,
      'width': instance.width,
      'height': instance.height,
    };
