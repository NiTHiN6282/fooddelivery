import 'package:flutter/material.dart';
import 'package:fooddelivery/foodcartui.dart';

import 'datalist.dart';
import 'foodfavoriteui.dart';

class FoodHomeUi extends StatefulWidget {
  const FoodHomeUi({Key? key}) : super(key: key);

  @override
  State<FoodHomeUi> createState() => _FoodHomeUiState();
}

class _FoodHomeUiState extends State<FoodHomeUi> {

  bool isSelected = false;
  var reslist=2;

  @override
  Widget build(BuildContext context) {
    var scrwidth = MediaQuery.of(context).size.width;
    var scrheight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: scrheight*0.03, left: scrheight*0.035, bottom: scrheight*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: scrheight*0.03),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello " + personalDetails["name"],
                                    style: TextStyle(
                                      fontSize: scrheight*0.020,
                                    ),
                                  ),
                                  Text(
                                    "Welcome back!",
                                    style: TextStyle(
                                      fontSize: scrheight*0.035,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => FoodCartUi(),));
                                },
                                child: Icon(Icons.shopping_cart,
                                size: scrheight*0.0352,))
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: scrheight*0.017,right: scrheight*0.017),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scrheight*0.02),
                          color: const Color(0xffffffff),
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
                      // Container(
                      //   height: scrheight*0.1171,
                      //   child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: tabList.length,
                      //       itemBuilder: (context, index) {
                      //         return Padding(
                      //           padding: EdgeInsets.only(right: scrheight*0.022),
                      //           child: Row(
                      //             children: [
                      //               ElevatedButton(
                      //                 style: ElevatedButton.styleFrom(
                      //                   primary: isSelected == false
                      //                       ? Colors.grey
                      //                       : Colors.brown,
                      //                   shape: RoundedRectangleBorder(
                      //                     borderRadius: BorderRadius.circular(
                      //                         10), // <-- Radius
                      //                   ),
                      //                 ),
                      //                 onPressed: () {
                      //                   setState(() {
                      //                     isSelected = true;
                      //                   });
                      //                 },
                      //                 child: Container(
                      //                   child: Padding(
                      //                     padding: EdgeInsets.only(
                      //                         top: scrheight*0.00735, bottom: scrheight*0.00735),
                      //                     child: Row(
                      //                       children: [
                      //                         Image.asset(
                      //                           tabList[index]["img"],
                      //                           width: scrheight*0.0367,
                      //                           height: scrheight*0.0367,
                      //                         ),
                      //                         SizedBox(
                      //                           width: 10,
                      //                         ),
                      //                         Text(
                      //                           tabList[index]["name"],
                      //                           style: TextStyle(fontSize: scrheight*0.0235),
                      //                         )
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       }),
                      // ),
                      SizedBox(
                        height: scrheight*0.022,
                      ),
                      Text(
                        "Favorite",
                        style: TextStyle(fontSize: scrheight*0.022),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: favoriteList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodFavoriteUi(
                                          img: favoriteList[index]["img"],
                                          name: favoriteList[index]["name"],
                                          description: favoriteList[index]["description"],
                                          price: favoriteList[index]["price"],
                                        ),
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: scrheight*0.0147, right: scrheight*0.022),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: scrheight*0.3075,
                                        width: scrheight*0.22,
                                        decoration: BoxDecoration(
                                            gradient: const RadialGradient(
                                              colors: [
                                                Color(0xff2E2E2E),
                                                Color(0xff171717)
                                              ],
                                              radius: 0.40,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(scrheight*0.0293)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: scrheight*0.022,
                                              bottom: scrheight*0.022,
                                              right: scrheight*0.0147,
                                              left: scrheight*0.0147),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: scrheight*0.022),
                                                child: Image.asset(
                                                  favoriteList[index]['img'],
                                                  width: scrheight*0.1099,
                                                  height: scrheight*0.1099,
                                                ),
                                              ),
                                              SizedBox(
                                                height: scrheight*0.022,
                                              ),
                                              Text(
                                                favoriteList[index]['name'],
                                                style: TextStyle(
                                                  fontSize: scrheight*0.0191,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: scrheight*0.0074,
                                              ),
                                              Text(
                                                favoriteList[index]
                                                    ['description'],
                                                style: TextStyle(
                                                  fontSize: scrheight*0.0176,
                                                    color: Colors.white70),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: scrheight*0.022,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: List.generate(5,
                                                          (index) {
                                                        return Icon(
                                                          Icons.star,
                                                          color: Colors.orange,
                                                          size: scrheight*0.0147,
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: scrheight*0.022,
                                                  ),
                                                  Text(
                                                    "${favoriteList[index]
                                                    ['price']} Rs",
                                                    style: TextStyle(
                                                      fontSize: scrheight*0.0176,
                                                        color: Colors.white70),
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
                              "More Restaurants",
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
                              return Container(
                                padding: EdgeInsets.only(bottom: scrheight*0.0147),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(scrheight*0.0293)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: scrheight*0.1465,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(scrheight*0.022)),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: scrheight*0.0293, bottom: scrheight*0.0293),
                                        child: Image.asset(
                                          foodList[index]['img'],
                                          width: scrheight*0.0586,
                                          height: scrheight*0.0586,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: scrheight*0.022,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          foodList[index]['name'],
                                          style: TextStyle(fontSize: scrheight*0.0205),
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: List.generate(5, (index) {
                                                return Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                  size: scrheight*0.0205,
                                                );
                                              }),
                                            ),
                                            SizedBox(
                                              width: scrheight*0.0586,
                                            ),
                                            Text(
                                              foodList[index]['price'],
                                              style:
                                                  TextStyle(
                                                      fontSize: scrheight*0.0191,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Text(foodList[index]['distance'],
                                        style: TextStyle(
                                          fontSize: scrheight*0.0191
                                        ),)
                                      ],
                                    )
                                  ],
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
