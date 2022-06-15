import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooddelivery/landingpage.dart';
import 'package:fooddelivery/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

var finalEmail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    getValidationData().whenComplete(() async {
      Timer(Duration(seconds: 2), () {
        if(finalEmail==null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage(),));
        }
      });

    });
  }

  Future getValidationData() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedEmail=sharedPreferences.getString('email');
    setState((){
      finalEmail=obtainedEmail;
    });
    print(finalEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/splashimg.gif",
            width: 100),
            SizedBox(
              height: 30,
            ),
            Text("Loading..."),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
