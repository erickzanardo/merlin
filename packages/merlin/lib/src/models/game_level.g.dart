// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerlinGameLevel _$MerlinGameLevelFromJson(Map<String, dynamic> json) =>
    MerlinGameLevel(
      scrollLength: (json['scrollLength'] as num).toDouble(),
      scrollSpeed: (json['scrollSpeed'] as num).toDouble(),
    );

Map<String, dynamic> _$MerlinGameLevelToJson(MerlinGameLevel instance) =>
    <String, dynamic>{
      'scrollLength': instance.scrollLength,
      'scrollSpeed': instance.scrollSpeed,
    };
