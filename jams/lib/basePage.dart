import 'package:flutter/material.dart';
import 'package:jams/Checklist.dart';
import 'package:jams/calender.dart';
import 'package:jams/constants.dart';
import 'package:jams/teachers.dart';
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
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(icon: Icon(MdiIcons.menu),onPressed: ()=>_scaffoldkey.currentState.openDrawer(),),
        title: Text("John Adams Middle School"),
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