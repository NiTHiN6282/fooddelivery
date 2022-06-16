import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'datalist.dart';
import 'foodfavoriteui.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final items = List<String>.generate(wishList.length+1, (i) => '${i + 1}');
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
                      final item=items[index];
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
                                    rating: wishList[index]['rating'],
                                  ),
                                )).then((value) => setState((){}));
                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Dismissible(
                              background: Container(
                                padding: EdgeInsets.only(right: 15),
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    )
                                  ],
                                ),),
                              direction: DismissDirection.endToStart,
                                confirmDismiss: (DismissDirection direction) async {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Confirm"),
                                        content: Text(
                                            "Are you sure you wish to delete this item?"),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              primary: Colors.white,
                                            ),
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: Text("DELETE",
                                            style: TextStyle(
                                              color: Colors.black
                                            ),),),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              primary: Colors.white,

                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(2),
                                                  ),
                                                  side: BorderSide(color: Colors.white)),
                                            ),
                                            onPressed: () => Navigator.of(context).pop(false),
                                            child: const Text("CANCEL",
                                            style: TextStyle(
                                              color: Colors.black
                                            ),),
                                          ),],);
                                    },);
                                },
                              onDismissed: (direction) {

                                setState(() {
                                  items.removeAt(index);
                                  wishList.removeAt(index);
                                });

                              },
                              key: Key(item),
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
                                          RatingBar.builder(

                                            ignoreGestures: true,
                                            itemSize: 15,
                                          initialRating: wishList[index]['rating'],
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
