import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/widgets/snackbar.dart';

import 'datalist.dart';
import 'foodcartui.dart';

class FoodDetailsUi extends StatefulWidget {
  var name;
  var image;
  var description;
  var price;
  var rating;

  FoodDetailsUi(
      {Key? key,
      this.name,
      this.image,
      this.description,
      this.price,
      this.rating})
      : super(key: key);

  @override
  State<FoodDetailsUi> createState() => _FoodDetailsUiState();
}

class _FoodDetailsUiState extends State<FoodDetailsUi> {
  int count = 1;
  var newprice;
  var favicon = false;
  var wishindex;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < wishList.length; i++) {
      if (wishList[i]['name'] == widget.name) {
        // wishList
        favicon = true;
        setState(() {});
      }
    }

    var scrwidth = MediaQuery.of(context).size.width;
    var scrheight = MediaQuery.of(context).size.height;
    print(scrheight);
    var totalprice = widget.price;
    if (newprice == null) {
      setState(() {
        newprice = widget.price;
      });
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: scrheight * .07,
        backgroundColor: Colors.grey,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_rounded)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodCartUi(),
                      )).then((value) => setState(() {}));
                },
                child: Badge(
                  badgeColor: Colors.black,
                  badgeContent: Text(
                    cartList.length.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    size: scrheight * 0.0352,
                  ),
                )),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          height: scrheight,
          width: scrwidth,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  child: Container(
                width: scrwidth,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        widget.image,
                      ),
                      fit: BoxFit.cover),
                ),
              )),
              Positioned(
                  top: scrheight * 0.275,
                  child: Container(
                    width: scrwidth,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: scrheight * 0.040,
                          top: scrheight * 0.03,
                          right: scrheight * 0.040),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(scrheight * 0.0733))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(
                                              scrheight * 0.0586)),
                                      padding:
                                          EdgeInsets.all(scrheight * 0.013),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                            size: scrheight * 0.0352,
                                          ),
                                          SizedBox(
                                            width: scrheight * 0.01,
                                          ),
                                          Text(
                                            widget.rating.toString(),
                                            style: TextStyle(
                                                fontSize: scrheight * 0.0205,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: scrheight * 0.12,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (count > 1) {
                                                setState(() {
                                                  count = count - 1;
                                                  newprice = totalprice * count;
                                                });
                                              }
                                            },
                                            child: Container(
                                              width: scrheight * 0.03,
                                              height: scrheight * 0.03,
                                              decoration: BoxDecoration(
                                                color: Color(0xffbe8046),
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: scrheight * 0.018,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            count.toString(),
                                            style: TextStyle(
                                                fontSize: scrheight * 0.022),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                count = count + 1;
                                                newprice = totalprice * count;
                                              });
                                            },
                                            child: Container(
                                              width: scrheight * 0.03,
                                              height: scrheight * 0.03,
                                              decoration: BoxDecoration(
                                                color: Color(0xffbe8046),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: scrheight * 0.0249,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: scrheight * 0.01,
                                ),
                                Text(
                                  widget.name,
                                  style: TextStyle(fontSize: scrheight * 0.03),
                                ),
                                SizedBox(
                                  height: scrheight * 0.01,
                                ),
                                Container(
                                  height: scrheight * 0.32,
                                  child: ListView(
                                    children: [
                                      Container(
                                          child: Text(
                                        widget.description,
                                        style: TextStyle(
                                            fontSize: scrheight * 0.019),
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: scrheight * 0.025),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: scrwidth / 2.61,
                                  height: scrheight / 12,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFBE7C6),
                                      borderRadius: BorderRadius.circular(
                                          scrheight * 0.0205)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Total Price",
                                        style: TextStyle(
                                            fontSize: scrheight * 0.017),
                                      ),
                                      SizedBox(
                                        height: scrheight * 0.007,
                                      ),
                                      Text(
                                        "${newprice} Rs",
                                        style: TextStyle(
                                            fontSize: scrheight * 0.028,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    final findindex = cartList.indexWhere(
                                        (element) =>
                                            element["name"] == widget.name);
                                    print("index" + findindex.toString());
                                    if (findindex >= 0) {
                                      setState(() {
                                        cartList[findindex]['quantity'] = count;
                                      });
                                    } else {
                                      cartList.add({
                                        'name': widget.name,
                                        'img': widget.image,
                                        'price': widget.price,
                                        'quantity': count
                                      });
                                    }
                                    print(cartList);
                                    CustomSnackBar.customSnackbar(
                                        context,
                                        2,
                                        "${count} " +
                                            widget.name +
                                            " Added to cart");
                                    setState(() {});
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => FoodCartUi(),));
                                  },
                                  child: Container(
                                    width: scrwidth / 2.51,
                                    height: scrheight / 12,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(
                                            scrheight * 0.0205)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.shopping_cart,
                                          color: Colors.orangeAccent,
                                          size: scrheight * 0.030,
                                        ),
                                        SizedBox(
                                          width: scrheight * 0.008,
                                        ),
                                        Text(
                                          "Add To Cart",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: scrheight * 0.022),
                                        )
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
