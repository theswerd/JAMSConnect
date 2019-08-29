import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
  static CupertinoActionSheetAction cancelAction(BuildContext context)=>CupertinoActionSheetAction(child: Text("Cancel"),onPressed: ()=>Navigator.of(context).pop(),);
}