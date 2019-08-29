import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:jams/color_loader_3.dart';
import 'package:jams/constants.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibrate/vibrate.dart';

class StaffDirectory extends StatefulWidget {
  @override
  _StaffDirectoryState createState() => _StaffDirectoryState();
}

class _StaffDirectoryState extends State<StaffDirectory> {
  Widget titleWidget = Text("Staff Directory");
  bool loaded = false;
  IconButton searchButton;
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  Widget loadingBody = Center(child: ColorLoader3(),);
  Widget body;
  List teachers = [];
  bool searching = false;
  @override
  void initState() {
    super.initState();
    body = loadingBody; 
    searchButton = IconButton(
      icon: Icon(Icons.search),
        onPressed: ()=>null,
      );
    
        getTeachers();
  }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          key: _scaffoldkey,
          body: body,
          appBar: AppBar(
            actions: <Widget>[
              searchButton
            ],
            title: titleWidget,
          ),
        );
      }
    
      void getTeachers() async{
        Future<Response> staffFuture = get("http://www.adams.smmusd.org/staff.html");
        staffFuture.catchError((error){
          setState(() {
            body = Center(child: Text("Sorry, it looks like we can't find your teachers right now.", textAlign: TextAlign.center,),);
          });
          _scaffoldkey.currentState.showSnackBar(
            SnackBar(
              content: Text("Sorry, there was an error getting your teachers."),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: "Try again",
                textColor: Colors.white,
                onPressed: (){
                  setState(() {
                    body = loadingBody;
                    getTeachers();
                    searchButton = IconButton(
                      icon: Icon(Icons.search),
                      onPressed: ()=>print("FISHHH"),
                    );
                  });
                },
              ),
            )
          );

        });
      
        Response staffResponse = await staffFuture;
        //Gets the body of it
        dom.Element theBody = parse(staffResponse.body).body;
        //Permutation1 just gets passed the base containers, passing through a div, then a table, and to the table body
        dom.Element permutation1 = theBody.children.first.children.first.children.first;
        //Within the table body, there are 6 children, the 5th is the one with the substance of the site in it
        dom.Element permutation2 = permutation1.children[4];
        //within here, there is another table and table body. Here is the substance
        List<dom.Element> permutation3 = permutation2.children.first.children.first.children.first.children;
        
        //CLEANING THE OBVIOUSLY DIRTY DATA
        permutation3.removeAt(1);//Title bar
        permutation3.removeAt(0);//Useless
        List format1 = [];
        
        for (dom.Element teacherHtml in permutation3) {
          if(teacherHtml.children.length<6){
            continue;//If it isn't a row with teachers than it isn't useful
          }
          format1.add(teacherHtml);
        }
        print(format1);
        List format2 = [];
        for (dom.Element teacherHTML in format1) {
          if(!teacherHTML.children.first.text.contains("\n")){
            Map teacherMap = new Map();
            teacherMap["name"] = teacherHTML.children.first.text.trim();
            try {
              if(teacherHTML.children.first.children.first.attributes.containsKey("href")){
                teacherMap['hasURL'] = true;
                teacherMap['url'] = teacherHTML.children.first.children.first.attributes['href'];
              }else{
                teacherMap['hasURL'] = false;
              }
            } catch (e) {
              teacherMap['hasURL'] = false;
            }
            teacherMap['dep'] = teacherHTML.children[1].text.trim();
            teacherMap['room'] = teacherHTML.children[2].text.trim();
            teacherMap['ex'] = teacherHTML.children[3].text.trim();
            teacherMap['grade'] = teacherHTML.children[4].text.trim();
            teacherMap['email'] = teacherHTML.children[5].text.trim();

            format2.add(teacherMap);
          }
        }
        setState(() {
          teachers = format2;
          body = bodyListBuilder(teachers);
          loaded = true;
        });
        print(format2);
      }

  Widget bodyListBuilder(List teachers) {
    return ListView.separated(
      itemCount: teachers.length,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      separatorBuilder: (c,i)=>Container(height: 15),
      itemBuilder: (c,i){
        Map teacher = teachers[i];
        return RaisedButton(
        padding: EdgeInsets.all(15),
        elevation: 15,
        onPressed: (){},
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(teacher['name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Text("x"+teacher['ex'], style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(teacher['dep'], style: TextStyle(fontSize: 20, color: Colors.grey[700]),),
                Text(teacher['room'], style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),)
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  child:Text(teacher['email'], 
                  style: TextStyle(fontSize: 19),), 
                  onPressed: ()=>showCupertinoModalPopup(
                    context: context,
                    builder: (c)=>CupertinoActionSheet(
                      cancelButton: Constants.cancelAction(context),
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          child: Text("Share"),
                          onPressed: (){
                            Navigator.of(context).pop();
                            Share.share(teacher['name']+"'s email is "+teacher['email']);
                            Vibrate.feedback(FeedbackType.light);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: Text("Copy"),
                          onPressed: (){
                            Navigator.of(context).pop();
                            Clipboard.setData(ClipboardData(text:teacher['email']));
                            Vibrate.feedback(FeedbackType.success);
                          },
                        )
                      ],
                    )
                  ),
                  padding: EdgeInsets.zero,
                ),
                Row(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: ()=>Share.share(
                        teacher['name']+"'s Information:\n"+"Department: "+teacher['dep']+"\nRoom: "+teacher['room']+"\nEmail: "+teacher['email']+"\nExtension: "+teacher['ex']+(teacher['hasURL']?("\nWebsite: "+teacher['url']):"")
                      ),
                      mini: true,
                      child: Icon(MdiIcons.shareOutline),
                    ),
                    teacher['hasURL']?FloatingActionButton(
                      mini: true,
                      onPressed: ()=>launch(teacher['url']),
                      child: Icon(MdiIcons.link),
                    ):Container(height: 0,)
                  ],
                )

                //Text(teacher['room'], style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),)
            ],)
          ],
        ),
      );},
    );
  }
}