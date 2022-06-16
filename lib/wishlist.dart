import 'package:flutter/material.dart';

import 'datalist.dart';
import 'foodfavoriteui.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    var scrheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Wishlist",
              style: TextStyle(
                fontSize: 20
              ),),
              SizedBox(
                height: 20,
              ),
              Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: wishList.length==0?1:wishList.length,
                    itemBuilder: (context, index) {
                      if(wishList.length==0){
                        return Center(
                          child: Container(
                              padding: EdgeInsets.all(scrheight*0.0293),
                              child: Text("Wishlist is empty",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: scrheight*0.0293
                                ),)
                          ),
                        );
                      }else{
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodFavoriteUi(
                                    img: wishList[index]["img"],
                                    name: wishList[index]["name"],
                                    description: wishList[index]["description"],
                                    price: wishList[index]["price"],
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
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                      BorderRadius.circular(scrheight*0.022)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: scrheight*0.0293, bottom: scrheight*0.0293),
                                    child: Image.asset(
                                      wishList[index]['img'],
                                      width: scrheight*0.0586,
                                      height: scrheight*0.0586,
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: scrheight*0.022,
                                // ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      wishList[index]['name'],
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
                                          wishList[index]['price'].toString(),
                                          style:
                                          TextStyle(
                                              fontSize: scrheight*0.0191,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: (){
                                    wishList.removeAt(index);
                                    print(wishList);

                                    setState((){});
                                  },
                                  child: Icon(Icons.favorite,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }

                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
