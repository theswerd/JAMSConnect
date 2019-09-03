import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:jams/Checklist.dart';
import 'package:jams/calender.dart';
import 'package:jams/color_loader_3.dart';
import 'package:jams/constants.dart';
import 'package:jams/schedule.dart';
import 'package:jams/teachers.dart';
import 'package:localstorage/localstorage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with TickerProviderStateMixin{
  TabController baseTabController;
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    baseTabController = new TabController(vsync: this, length: 3);
    if(DateTime.now().weekday<=5){
      checkDailyBulletin(context);
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 200,
              color: Constants.baseColor,
              child: Center(child: Text("JAMS", style: TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal,),),),
            ),
            Container(
              height: 45,
              padding: EdgeInsets.all(3),
              alignment: Alignment.bottomLeft,
              color: Colors.grey[300],
              child: Text("Important Links:"),
            ),
            ListTile(
              title: Text("Staff Directory"),
              subtitle: Text("Find your teachers"),
              trailing: Icon(MdiIcons.teach, color: Colors.black,),
              onTap: ()=>Constants.popupRoute(StaffDirectory(),context),
            ),
            ListTile(
              title: Text("Illuminate"),
              subtitle: Text("Gradebook"),
              trailing: Icon(MdiIcons.bookOpenVariant, color: Colors.black,),
              onTap: ()=>Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog:true,
                  maintainState:true,
                  builder:(c)=>WebviewScaffold(
                    url: "https://smmusd.illuminatehc.com/login",
                    
                    appBar: AppBar(
                      title: Text("Illuminate"),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(MdiIcons.launch),
                          onPressed: ()=>launch('https://smmusd.illuminatehc.com/login'),
                        )
                      ],
                    ),
                  )
                )
              )
            ),
            ListTile(
              title: Text("Daily Bulletin"),
              subtitle: Text("Today's News"),
              trailing: Icon(MdiIcons.bulletinBoard, color: Colors.black,),
              onTap: ()=>Navigator.of(context).push(
                  Constants.websitePage("http://www.adams.smmusd.org/JAMSBulletin.pdf", "Bulletin")
                )
            ),
            ListTile(
              title: Text("Schedule"),
              subtitle: Text("JAMS Bell Schedule"),
              trailing: Icon(MdiIcons.clockOutline, color: Colors.black),
              onTap: ()=>Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog:true,
                  maintainState:true,
                  
                  builder:(c)=>Schedule()
                )
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(icon: Icon(MdiIcons.menu),onPressed: ()=>_scaffoldkey.currentState.openDrawer(),),
        title: Text("John Adams Middle School"),
        actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.informationOutline),
            onPressed: (){
              if(baseTabController.index==0){
                print("Map");
                showCupertinoModalPopup(
                  context: context,
                  builder: (c)=>CupertinoActionSheet(
                    cancelButton: Constants.cancelAction(context),
                    actions: <Widget>[
                      CupertinoActionSheetAction(
                        child: Text("Official Website"),
                        onPressed: ()=>launch("http://www.adams.smmusd.org/admin/campusmap.html"),
                      ),
                      CupertinoActionSheetAction(
                        child: Text("Extra Info"),
                        onPressed: ()=>showCupertinoModalPopup(
                          context: context,
                          builder: (c)=>CupertinoAlertDialog(
                            title: Text("Extra Info"),
                            content: Text("The map data is taken from the official JAMS Map."),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text("Ok"),
                                onPressed: ()=>Navigator.of(context).pop(),
                              )
                            ],
                          )
                        ),
                      )
                    ],
                  )
                );
              }else if(baseTabController.index==1){
                showCupertinoModalPopup(
                  context: context,
                  builder: (c)=>CupertinoActionSheet(
                    cancelButton: Constants.cancelAction(context),
                    actions: <Widget>[
                      CupertinoActionSheetAction(
                        child: Text("Official Website"),
                        onPressed: ()=>launch("http://www.adams.smmusd.org/calendar.html"),
                      ),
                      CupertinoActionSheetAction(
                        child: Text("SMMUSD Calendar"),
                        onPressed: ()=>launch("http://www.smmusd.org/calendar/cal1920.pdf"),
                      ),
                      CupertinoActionSheetAction(
                        child: Text("Extra Info"),
                        onPressed: ()=>showCupertinoModalPopup(
                          context: context,
                          builder: (c)=>CupertinoAlertDialog(
                            title: Text("Extra Info"),
                            content: Text("The Calendar data is taken live from the official JAMS Calendar."),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text("Ok"),
                                onPressed: ()=>Navigator.of(context).pop(),
                              )
                            ],
                          )
                        ),
                      )
                    ],
                  )
                );

              }else{
                showCupertinoModalPopup(
                  context: context,
                  builder: (c)=>CupertinoActionSheet(
                    cancelButton: Constants.cancelAction(context),
                    actions: <Widget>[
                      
                      CupertinoActionSheetAction(
                        child: Text("Extra Info"),
                        onPressed: ()=>showCupertinoModalPopup(
                          context: context,
                          builder: (c)=>CupertinoAlertDialog(
                            title: Text("Extra Info"),
                            content: Text("The Checklist is stored locally on your device. It is here for your school work, to help you keep up with your homework."),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text("Ok"),
                                onPressed: ()=>Navigator.of(context).pop(),
                              )
                            ],
                          )
                        ),
                      )
                    ],
                  )
                );

              }
            },
          )
        ],
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: baseTabController,
        children: <Widget>[
          Map(),
          Calendar(),
          Checklist()
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: baseTabController,
        labelColor: Constants.baseColor,
        unselectedLabelColor: Colors.black,
        tabs: <Widget>[
          Tab(
            icon: Icon(MdiIcons.mapOutline),
          ),
          Tab(
            icon: Icon(MdiIcons.calendarTextOutline),
          ),
          Tab(
            icon: Icon(MdiIcons.clipboardCheckOutline)
          )
        ],
      ),
      
    );
  }
}

void checkDailyBulletin(BuildContext context) async{
  LocalStorage bulletinToday = new LocalStorage("bulletin");
  bool ready = await bulletinToday.ready;
  if(ready){
    String currentDay = DateTime.now().year.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().day.toString();
    bool hasShownToday = bulletinToday.getItem(currentDay);
    if(hasShownToday==true /*It can be null*/){
      return;
    }else{
      bulletinToday.clear();
      bulletinToday.setItem(currentDay, true);
      showCupertinoModalPopup(
        context: context,
        builder: (c)=>CupertinoAlertDialog(
          title: Text("Daily Bulletin"),
          content: Text("Would you like to see today's daily bulletin?"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("No"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text("Yes"),
              onPressed: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  Constants.websitePage("http://www.adams.smmusd.org/JAMSBulletin.pdf", "Bulletin")
                );
                
              },
            )
          ],
        )
      );
    }
  }else{
    bulletinToday.clear();
    return;
  }
}