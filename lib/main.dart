import 'package:flutter/material.dart';
import 'package:voter_circle/AppTheme.dart';
import 'package:voter_circle/LandingPage.dart';

import 'CommentScreen.dart';
import 'CreatePostScreen.dart';
import 'LoginView.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "TurretRoad",
        backgroundColor: Colors.white
      ),
      routes: <String, WidgetBuilder>{
        "landing":(context)=> LandingPage(),
        CommentScreen.route:(context)=>CommentScreen(),
        CreatePostScreen.route:(context)=>CreatePostScreen(),
      },
      initialRoute: "landing",
    );
  }
}