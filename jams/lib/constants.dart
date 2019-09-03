import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'color_loader_3.dart';
import 'package:url_launcher/url_launcher.dart';

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

 static MaterialPageRoute websitePage(String website, String title) {
   return MaterialPageRoute(
     
     fullscreenDialog: true,
     maintainState: true,
     builder: (c)=>WebviewScaffold(
       initialChild: Center(child: ColorLoader3(),),
       userAgent: "JAMS Connect",
       allowFileURLs: true,
       appCacheEnabled: true,
       enableAppScheme: true,
       
       url: website,
       appBar: AppBar(
         backgroundColor: Constants.baseColor,
         title: Text(title),
         actions: <Widget>[IconButton(
           icon: Icon(Icons.launch),
           onPressed: ()=>launch(website),
         )],
       ),
     )
   );
 }
 
  static CupertinoActionSheetAction cancelAction(BuildContext context)=>CupertinoActionSheetAction(child: Text("Cancel"),onPressed: ()=>Navigator.of(context).pop(),);
}