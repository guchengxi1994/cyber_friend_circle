import 'dart:io';

import 'package:cyber_friend_circle/isar/image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  Avatar(
      {super.key, required this.avatar, required this.type, this.name = "N"}) {
    assert(name.isNotEmpty);
  }
  final String? avatar;
  final ImageType type;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: type == ImageType.none ? Colors.red : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 1),
          image: avatar != null
              ? DecorationImage(
                  image: type == ImageType.asset
                      ? ExtendedAssetImageProvider(avatar!)
                      : type == ImageType.file
                          ? ExtendedFileImageProvider(File(avatar!))
                          : ExtendedNetworkImageProvider(avatar!))
              : null),
      child: avatar == null
          ? Center(
              child: Text(
                name[0],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          : null,
    );
  }
}
