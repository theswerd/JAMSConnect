import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule"),
        actions: <Widget>[
          Tooltip(
            message: "Official Website",
            child: IconButton(
              icon: Icon(MdiIcons.launch),
              onPressed: ()=>launch("http://www.adams.smmusd.org/bells.html"),
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(25),
        children: <Widget>[
          Card(
            elevation: 25,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Monday-Thursday", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                      Text("Block", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey[700]),)
                  ],),
                  Container(height: 15,),
                  classRowBuilder("Period A", "7:30-8:15 AM"),
                  Container(height: 25,),
                  classRowBuilder("BLOCK 1/2", "8:19-10:01 AM"),
                  Container(height: 25,),
                  classRowBuilder("Nutrition", "10:06-10:21 AM"),
                  Container(height: 25,),
                  classRowBuilder("BLOCK 3/4", "10:26-11:58 AM"),
                  Container(height: 25,),
                  classRowBuilder("Lunch 6/7", "12:03-12:43 PM"),
                  Container(height: 25,),
                  classRowBuilder("Advisory 6/7", "12:48-1:23 PM"),
                  Container(height: 25,),
                  classRowBuilder("Advisory 8", "12:03-12:38 PM"),
                  Container(height: 25,),
                  classRowBuilder("Lunch 8", "12:43-1:23 PM"),
                  Container(height: 25,),
                  classRowBuilder("BLOCK 5/6", "1:28-3:00 PM"),
                ],
              ),
            ),
          ),
          Container(height: 30),
          Card(
            elevation: 25,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Friday", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                      Text("Flex", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey[700]),)
                  ],),
                  Container(height: 15,),
                  classRowBuilder("Period 1", "9:24-10:10 AM"),
                  Container(height: 25,),
                  classRowBuilder("Period 2", "10:15-10:57 AM"),
                  Container(height: 25,),
                  classRowBuilder("Nutrition", "11:02-11:17 AM"),
                  Container(height: 25,),
                  classRowBuilder("Period 3", "11:22 AM-12:04 PM"),
                  Container(height: 25,),
                  classRowBuilder("Period 4", "12:09-12:51 PM"),
                  Container(height: 25,),
                  classRowBuilder("Lunch", "12:56-1:26 PM"),
                  Container(height: 25,),
                  classRowBuilder("Period 5", "1:31-2:13 PM"),
                  Container(height: 25,),
                  classRowBuilder("Period 6", "2:18-3:00 PM"),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  RaisedButton classRowBuilder(String period, String time) {
    return RaisedButton(
      padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  onPressed: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(period, style: TextStyle(fontSize: 20),),
                      Text(time, style: TextStyle(fontSize: 20),)
                    ],
                  ),
                );
  }
}