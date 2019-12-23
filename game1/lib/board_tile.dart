import 'package:flutter/material.dart';

class BoardTile{
  final int idX;
  final int idY;
  
  Color tileColor;
  bool clickable;

  BoardTile({this.tileColor,this.idX, this.idY, this.clickable = true});
}