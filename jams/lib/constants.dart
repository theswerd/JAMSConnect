import 'package:flutter/material.dart';

class Constants {
  static Color baseColor = Color(0xFF2D72AF);
  static Color antiColor = Color(0xFFce418c);
  static void popupRoute(Widget thePopup, BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c)=>thePopup,
        maintainState: true,
        fullscreenDialog: true
      )
    );
  } 
}