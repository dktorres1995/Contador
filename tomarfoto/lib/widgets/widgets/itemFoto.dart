import 'dart:io';
import 'package:flutter/material.dart';

class ItemFoto extends StatelessWidget {
  final File path;
  final Function escoger;
  ItemFoto({@required this.path, @required this.escoger});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return InkWell(
            child: Image.file(
              path,
              filterQuality: FilterQuality.none,
              cacheHeight: constrains.maxHeight.toInt(),
              cacheWidth: constrains.maxWidth.toInt() ,
            ),
          onTap: () {
            escoger(path);
          },
        );
      },
    );
  }
}
