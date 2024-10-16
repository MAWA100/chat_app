import 'dart:async';

import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static String id='SplashPage';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

void initState(){
  super.initState();
  Timer(Duration(seconds: 5),(){
    Navigator.pushNamed(context,LoginPage.id);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           SizedBox(height: 250,),
                Image.asset('assets/images/scholar.png',
                height: 100,width: 100,),
                 Center(
                  child: Text('Scholar Chat',style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'pacifico'
                  ),),),
                  SizedBox(height: 400,),
                  Text('Made By',style: TextStyle(color: Colors.white),),
                  Text('Marwa',style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}