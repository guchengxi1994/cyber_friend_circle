import 'package:json_annotation/json_annotation.dart';

part 'assets.g.dart';

@JsonSerializable()
class Assets {
  List<AssetObj> assets = [];

  @JsonKey(name: "characters-good")
  List<String> goodCharacters = [];

  @JsonKey(name: "characters-bad")
  List<String> badCharacters = [];

  Assets();

  factory Assets.fromJson(Map<String, dynamic> json) => _$AssetsFromJson(json);

  Map<String, dynamic> toJson() => _$AssetsToJson(this);
}

@JsonSerializable()
class AssetObj {
  String prefix = "";
  List<String> items = [];
  String type = "";

  AssetObj();

  factory AssetObj.fromJson(Map<String, dynamic> json) =>
      _$AssetObjFromJson(json);

  Map<String, dynamic> toJson() => _$AssetObjToJson(this);
}
