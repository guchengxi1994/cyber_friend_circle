// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assets _$AssetsFromJson(Map<String, dynamic> json) => Assets()
  ..assets = (json['assets'] as List<dynamic>)
      .map((e) => AssetObj.fromJson(e as Map<String, dynamic>))
      .toList()
  ..goodCharacters = (json['characters-good'] as List<dynamic>)
      .map((e) => e as String)
      .toList()
  ..badCharacters = (json['characters-bad'] as List<dynamic>)
      .map((e) => e as String)
      .toList();

Map<String, dynamic> _$AssetsToJson(Assets instance) => <String, dynamic>{
      'assets': instance.assets,
      'characters-good': instance.goodCharacters,
      'characters-bad': instance.badCharacters,
    };

AssetObj _$AssetObjFromJson(Map<String, dynamic> json) => AssetObj()
  ..prefix = json['prefix'] as String
  ..items = (json['items'] as List<dynamic>).map((e) => e as String).toList()
  ..type = json['type'] as String;

Map<String, dynamic> _$AssetObjToJson(AssetObj instance) => <String, dynamic>{
      'prefix': instance.prefix,
      'items': instance.items,
      'type': instance.type,
    };
