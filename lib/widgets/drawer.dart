import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authentication/loginpage.dart';
import '../datalist.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Image.asset(personalDetails['img']),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        personalDetails['name'],
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        personalDetails['email'],
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel_outlined))
                ],
              ),
            )),
        ListTile(
          onTap: () async {
            FirebaseAuth.instance
                .signOut()
                .then((value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    )));
          },
          leading: Icon(Icons.logout),
          title: Text("Logout"),
        )
      ],
    );
  }
}
