// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerlinGameData _$MerlinGameDataFromJson(Map<String, dynamic> json) =>
    MerlinGameData(
      name: json['name'] as String,
      resolutionWidth: json['resolutionWidth'] as int,
      resolutionHeight: json['resolutionHeight'] as int,
      gridSize: json['gridSize'] as int,
    );

Map<String, dynamic> _$MerlinGameDataToJson(MerlinGameData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'resolutionWidth': instance.resolutionWidth,
      'resolutionHeight': instance.resolutionHeight,
      'gridSize': instance.gridSize,
    };
