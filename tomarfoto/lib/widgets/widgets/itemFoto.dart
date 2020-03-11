import 'dart:io';
import 'package:flutter/material.dart';

class ItemFoto extends StatelessWidget {
  final File path;
  final Function escoger;
  ItemFoto({@required this.path, @required this.escoger});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey),
        margin: EdgeInsets.all(5),
        child: Image.file(path),
      ),
      onTap: () {
        escoger(path);
      },
    );
  }
}
