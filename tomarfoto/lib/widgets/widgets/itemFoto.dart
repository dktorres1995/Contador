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
          child: Container(
            height: constrains.maxHeight,
            width: constrains.maxWidth,
            child: Image.file(
              path,
              filterQuality: FilterQuality.low,
              height: constrains.maxHeight,
              width: constrains.maxWidth,
            ),
          ),
          onTap: () {
            escoger(path);
          },
        );
      },
    );
  }
}
