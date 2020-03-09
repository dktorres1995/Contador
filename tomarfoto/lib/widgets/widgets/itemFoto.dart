import 'dart:io';
import 'package:flutter/material.dart';


class ItemFoto extends StatelessWidget {
  File path;
  Function escoger;
  ItemFoto({@required this.path,@required this.escoger});

  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Container(
        child: Image.file(path),
        
      ),onTap: (){
        escoger(path);
      },
    );
  }
}