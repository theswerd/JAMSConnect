import 'package:http/http.dart';
import 'package:jams/color_loader_3.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

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
  @override
  void initState() {
    super.initState();
    body = loadingBody; 
    searchButton = IconButton(
      icon: Icon(Icons.search),
        onPressed: ()=>loaded?(){
          print("Loaded");
        }:null,
      );
    
        getTeachers();
  }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          key: _scaffoldkey,
          body: body,
          appBar: AppBar(
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
        for (dom.Element teacherHTML in format1) {
          for(dom.Element teacherInnerHtml in teacherHTML.children[0].children){
            print(teacherInnerHtml.children);
          }
        }
      }
}