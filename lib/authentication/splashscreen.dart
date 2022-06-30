import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/authentication/loginpage.dart';
import 'package:fooddelivery/landingpage.dart';

var finalEmail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState(){
  //   getValidationData().whenComplete(() async {
  //     Timer(Duration(seconds: 2), () {
  //       if(finalEmail==null){
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
  //       }else{
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage(),));
  //       }
  //     });
  //
  //   });
  // }

  // Future getValidationData() async{
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var obtainedEmail=sharedPreferences.getString('email');
  //   setState((){
  //     finalEmail=obtainedEmail;
  //   });
  //   print(finalEmail);
  // }

  @override
  Widget build(BuildContext context) {
    firebaseCall() {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } else {
          FirebaseFirestore.instance
              .collection('user')
              .doc(user.uid)
              .get()
              .then((value) {
            if (value.data()!['status'] == 1 &&
                value.data()!['usertype'] == 'user') {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LandingPage(
                            uid: value.data()!['uid'],
                          )));
            }
          });
        }
      });
    }

    ;
    firebaseCall();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/splashimg.gif", width: 100),
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
