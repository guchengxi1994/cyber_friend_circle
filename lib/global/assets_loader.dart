import 'dart:convert';

import 'package:flutter/services.dart';

import 'assets.dart';

class AssetsLoader {
  AssetsLoader._();

  static late Assets assets;

  static Future load() async {
    assets = Assets.fromJson(
        jsonDecode(await rootBundle.loadString("assets/AssetManifest.json")));
  }

  static AssetObj getAssets(String type) {
    return assets.assets.firstWhere((element) => element.type == type);
  }
}
