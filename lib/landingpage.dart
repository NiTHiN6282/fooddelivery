import 'package:flutter/material.dart';
import 'package:fooddelivery/foodhomeui.dart';
import 'package:fooddelivery/wishlist.dart';

class LandingPage extends StatefulWidget {
  dynamic uid;
  LandingPage({Key? key,
    required this.uid}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  dynamic _widgetOptions;

  void setData(){
    _widgetOptions = <Widget>[
      FoodHomeUi(
        uid: widget.uid,
      ),
      WishListPage()
    ];
  }

  @override
  void initState() {
    setData();
    super.initState();
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          )
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
            backgroundColor: Colors.grey,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
