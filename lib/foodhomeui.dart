import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fooddelivery/foodcartui.dart';
import 'package:fooddelivery/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'datalist.dart';
import 'foodfavoriteui.dart';

class FoodHomeUi extends StatefulWidget {
  var uid;
  FoodHomeUi({Key? key,
  this.uid}) : super(key: key);

  @override
  State<FoodHomeUi> createState() => _FoodHomeUiState();
}

class _FoodHomeUiState extends State<FoodHomeUi> {

  bool isSelected = false;
  var reslist=2;

  @override
  Widget build(BuildContext context) {
    print("userid"+widget.uid);
    var scrwidth = MediaQuery.of(context).size.width;
    var scrheight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue
                ),
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
                            Text(personalDetails['name'],
                            style:
                              TextStyle(
                                fontSize: 18
                              ),),
                            SizedBox(
                              height: 5,
                            ),
                            Text(personalDetails['email'],
                              style:
                              TextStyle(
                                  fontSize: 13
                              ),)
                          ],
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel_outlined))
                      ],
                    ),
                  )
              ),
              ListTile(
                onTap: () async {
                  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.remove('email');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                },
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return InkWell(
                onTap: (){
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              );
            }
          ),
          actions: [
            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FoodCartUi(),));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Badge(
                    badgeColor: Colors.grey,
                    badgeContent: Text(cartList.length.toString(),
                      style: TextStyle(
                          color: Colors.white
                      ),),
                    child: Icon(
                      color: Colors.black,
                      Icons.shopping_cart,
                      size: scrheight*0.0352,
                    ),
                  ),
                )
            ),
            SizedBox(
              width: 8,
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only( left: scrheight*0.035, bottom: scrheight*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: scrheight*0.017,right: scrheight*0.017),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scrheight*0.02),
                          color: const Color(0xfffafafa),
                        ),
                        // height: 60.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: scrheight*0.011, right: scrheight*0.022),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: scrheight*0.0352,
                              ),
                            ),
                            Flexible(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: scrheight*0.024,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  fontSize: scrheight*0.022,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: scrheight*0.022,
                      ),
                      Text(
                        "Recommended",
                        style: TextStyle(fontSize: scrheight*0.022),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: foodList.length,
                            itemBuilder: (context, index) {
                            if(foodList[index]['recommended']==true){
                              var favicon=false;
                              for(int i=0; i<wishList.length;i++){
                                if(wishList[i]['name']==foodList[index]["name"]){
                                  // wishList
                                  favicon=true;
                                }
                              }
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodFavoriteUi(
                                          img: foodList[index]["img"],
                                          name: foodList[index]["name"],
                                          description: foodList[index]["description"],
                                          price: foodList[index]["price"],
                                          indexvar: index,
                                          rating: foodList[index]['rating'],
                                        ),
                                      )).then((value) => setState((){}));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: scrheight*0.0147, right: scrheight*0.022),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: scrheight*0.3075,
                                        width: scrheight*0.22,
                                        decoration: BoxDecoration(

                                            image: DecorationImage(
                                                image: AssetImage(foodList[index]["img"],),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                            BorderRadius.circular(scrheight*0.0293)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                          ),
                                          padding: EdgeInsets.only(
                                              top: scrheight*0.022,
                                              bottom: scrheight*0.022,
                                              right: scrheight*0.0147,
                                              left: scrheight*0.0147),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                foodList[index]['name'],
                                                style: TextStyle(
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black.withOpacity(1),
                                                        offset: Offset(1, 2),
                                                        blurRadius: 5,
                                                      ),
                                                    ],
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: scrheight*0.0074,
                                              ),
                                              Text(
                                                foodList[index]
                                                ['description'],
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black.withOpacity(1),
                                                        offset: Offset(1, 2),
                                                        blurRadius: 5,
                                                      ),
                                                    ],
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: scrheight*0.022,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "${foodList[index]
                                                    ['price']} Rs",
                                                    style: TextStyle(
                                                        shadows: [
                                                          Shadow(
                                                            color: Colors.black.withOpacity(1),
                                                            offset: Offset(1, 2),
                                                            blurRadius: 5,
                                                          ),
                                                        ],
                                                        fontSize: scrheight*0.0176,
                                                        color: Colors.white70),
                                                  ),
                                                  SizedBox(
                                                    width: scrheight*0.022,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(right: 5),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        if(favicon==false){
                                                          favicon=true;
                                                          wishList.add({
                                                            "img":foodList[index]["img"],
                                                            "name":foodList[index]["name"],
                                                            "price":foodList[index]["price"],
                                                            "description":foodList[index]['description'],
                                                            "rating":foodList[index]['rating']
                                                          });
                                                        }else{
                                                          favicon=false;
                                                          var wishindex;
                                                          for(int i=0; i<wishList.length;i++){
                                                            if(wishList[i]['name']==foodList[index]["name"]){
                                                              // wishList
                                                              wishindex=i;
                                                              setState((){});
                                                            }
                                                          }
                                                          wishList.removeAt(wishindex);
                                                        }
                                                        print(wishList);

                                                        setState((){});
                                                      },
                                                      child: Icon(
                                                        favicon==false?
                                                        Icons.favorite_border:Icons.favorite,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }else{
                              return SizedBox();
                            }

                            }),
                      ),
                      SizedBox(
                        height: scrheight*0.0293,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: scrheight*0.0147, bottom: scrheight*0.0293),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "More Foods",
                              style: TextStyle(fontSize: scrheight*0.022),
                            ),
                            TextButton(onPressed: (){
                              if(reslist==2){
                                setState((){
                                  reslist=foodList.length;
                                });
                              }else{
                                setState((){
                                  reslist=2;
                                });
                              }

                            }, child: reslist==2?Text("See more",
                              style: TextStyle(
                                  fontSize: scrheight*0.022,
                                  color: Color(0xffFFB52E)
                              ),):Text("See less",
                              style: TextStyle(
                                  fontSize: scrheight*0.022,
                                  color: Color(0xffFFB52E)
                              ),))
                            // Text(
                            //   "See all",
                            //   style: TextStyle(
                            //       fontSize: scrheight*0.022, color: Color(0xffFFB52E)),
                            // )
                          ],
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: reslist,
                            itemBuilder: (context, index) {
                              var favicon=false;
                              for(int i=0; i<wishList.length;i++){
                                if(wishList[i]['name']==foodList[index]["name"]){
                                  // wishList
                                  favicon=true;
                                }
                              }
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodFavoriteUi(
                                          img: foodList[index]["img"],
                                          name: foodList[index]["name"],
                                          description: foodList[index]["description"],
                                          price: foodList[index]["price"],
                                          indexvar: index,
                                          rating: foodList[index]['rating'],
                                        ),
                                      )).then((value) => setState((){}));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(bottom: scrheight*0.0147),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(scrheight*0.0293)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: scrheight*0.1465,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(foodList[index]['img'],),
                                                fit: BoxFit.cover),
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(scrheight*0.022)),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            foodList[index]['name'],
                                            style: TextStyle(fontSize: scrheight*0.0205),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          RatingBar.builder(

                                            ignoreGestures: true,
                                            itemSize: 15,
                                            initialRating: foodList[index]['rating'],
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              // print(rating);
                                            },
                                          ),
                                        ],
                                      ),
                                      Text(
                                        foodList[index]['price'].toString()+"Rs",
                                        style:
                                        TextStyle(
                                            fontSize: scrheight*0.0191,
                                            color: Colors.black),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: GestureDetector(
                                          onTap: (){
                                            if(favicon==false){
                                              favicon=true;
                                              wishList.add({
                                                "img":foodList[index]["img"],
                                                "name":foodList[index]["name"],
                                                "price":foodList[index]["price"],
                                                "description":foodList[index]['description'],
                                                "rating":foodList[index]['rating']
                                              });
                                            }else{
                                              favicon=false;
                                              var wishindex;
                                              for(int i=0; i<wishList.length;i++){
                                                if(wishList[i]['name']==foodList[index]["name"]){
                                                  // wishList
                                                  wishindex=i;
                                                  setState((){});
                                                }
                                              }
                                              wishList.removeAt(wishindex);
                                            }
                                            print(wishList);

                                            setState((){});
                                          },
                                          child: Icon(
                                            favicon==false?
                                            Icons.favorite_border:Icons.favorite,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
