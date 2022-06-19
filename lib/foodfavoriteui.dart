
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/foodhomeui.dart';
import 'package:fooddelivery/snackbar.dart';

import 'datalist.dart';
import 'foodcartui.dart';

class FoodFavoriteUi extends StatefulWidget {
  var name;
  var img;
  var description;
  var price;
  var indexvar;
  var rating;

  FoodFavoriteUi({Key? key,
    this.name,
    this.img,
    this.description,
    this.price,
    this.indexvar,
    this.rating
  }) : super(key: key);

  @override
  State<FoodFavoriteUi> createState() => _FoodFavoriteUiState();
}

class _FoodFavoriteUiState extends State<FoodFavoriteUi> {
  int count = 1;
  var newprice;
  var favicon=false;
  var wishindex;

  @override
  Widget build(BuildContext context) {

    for(int i=0; i<wishList.length;i++){
      if(wishList[i]['name']==widget.name){
        // wishList
        favicon=true;
        setState((){});
      }
    }

    var scrwidth = MediaQuery.of(context).size.width;
    var scrheight = MediaQuery.of(context).size.height;
    print(scrheight);
    var totalprice=widget.price;
    if(newprice==null){
      setState((){
        newprice=widget.price;
      });
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: scrheight*.07,
        backgroundColor: Colors.grey,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_rounded)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FoodCartUi(),)).then((value) => setState((){}));
                },
                child: Badge(
                  badgeColor: Colors.black,
                  badgeContent: Text(cartList.length.toString(),
                    style: TextStyle(
                        color: Colors.white
                    ),),
                  child: Icon(
                    Icons.shopping_cart,
                    size: scrheight*0.0352,
                  ),
                )
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: scrheight*0.3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.img),
                          fit: BoxFit.cover,
                      ),
                    ),
                    width: scrwidth,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              child: InkWell(
                                onTap: (){
                                  if(favicon==false){
                                    favicon=true;
                                    wishList.add({
                                      "img":widget.img,
                                      "name":widget.name,
                                      "description":widget.description,
                                      "price":widget.price,
                                      "rating":widget.rating
                                    });
                                  }else{
                                    favicon=false;
                                    for(int i=0; i<wishList.length;i++){
                                      if(wishList[i]['name']==widget.name){
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
                                child: favicon==false?
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                  size: 30,
                                ):
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: scrwidth,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: scrheight*0.040, top: scrheight*0.03, right: scrheight*0.040),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(scrheight*0.0733))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(scrheight*0.0586)),
                                      padding: EdgeInsets.all(scrheight*0.013),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                            size: scrheight*0.0352,
                                          ),
                                          SizedBox(
                                            width: scrheight*0.01,
                                          ),
                                          Text(
                                            widget.rating.toString(),
                                            style: TextStyle(
                                                fontSize: scrheight*0.0205,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: scrheight*0.12,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (count > 1) {
                                                setState(() {
                                                  count = count - 1;
                                                  newprice=totalprice*count;
                                                });
                                              }
                                            },
                                            child: Container(
                                              width: scrheight*0.03,
                                              height: scrheight*0.03,
                                              decoration: BoxDecoration(
                                                color: Color(0xffbe8046),
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: scrheight*0.018,
                                              ),
                                            ),
                                          ),
                                          Text(count.toString(),
                                          style: TextStyle(
                                            fontSize: scrheight*0.022
                                          ),),
                                          GestureDetector(

                                            onTap: () {
                                              setState(() {
                                                count = count + 1;
                                                newprice=totalprice*count;
                                              });
                                            },
                                            child: Container(
                                              width: scrheight*0.03,
                                              height: scrheight*0.03,
                                              decoration: BoxDecoration(
                                                color: Color(0xffbe8046),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: scrheight*0.0249,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: scrheight*0.01,
                                ),
                                Text(
                                  widget.name,
                                  style: TextStyle(fontSize: scrheight*0.03),
                                ),
                                SizedBox(
                                  height: scrheight*0.01,
                                ),
                                Container(
                                  height: scrheight*0.32,
                                  child: ListView(
                                    children: [
                                      Container(
                                          child: Text(widget.description,
                                            style: TextStyle(

                                                fontSize: scrheight*0.019
                                            ),)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: scrheight*0.025),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: scrwidth/2.61,
                                  height: scrheight/12,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFBE7C6),
                                      borderRadius: BorderRadius.circular(scrheight*0.0205)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Total Price",
                                        style: TextStyle(
                                            fontSize: scrheight*0.017
                                        ),),

                                      SizedBox(
                                        height: scrheight*0.007,
                                      ),

                                      Text("${newprice} Rs",
                                        style: TextStyle(
                                            fontSize: scrheight*0.028,
                                            fontWeight: FontWeight.bold
                                        ),)
                                    ],
                                  ),
                                ),

                                GestureDetector(
                                  onTap: (){
                                    final findindex = cartList.indexWhere((element) => element["name"] == widget.name);
                                    print("index"+findindex.toString());
                                    if(findindex>=0){
                                      setState((){
                                        cartList[findindex]['quantity']=count;
                                      });
                                    }else{
                                      cartList.add({
                                        'name':widget.name,
                                        'img':widget.img,
                                        'price':widget.price,
                                        'quantity':count
                                      });
                                    }
                                    print(cartList);
                                    CustomSnackBar.customSnackbar(context, 2,"${count} "+widget.name+" Added to cart");
                                    setState((){});
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => FoodCartUi(),));
                                  },
                                  child: Container(
                                    width: scrwidth/2.51,
                                    height: scrheight/12,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(scrheight*0.0205)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.shopping_cart,
                                          color: Colors.orangeAccent,
                                          size: scrheight*0.030,),

                                        SizedBox(
                                          width: scrheight*0.008,
                                        ),
                                        Text("Add To Cart",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: scrheight*0.022
                                          ),)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}
