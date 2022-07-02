import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/foodcartui.dart';
import 'package:fooddelivery/widgets/drawer.dart';
import 'package:fooddelivery/widgets/wishlistcard.dart';

import 'datalist.dart';
import 'fooddetailsui.dart';

class FoodHomeUi extends StatefulWidget {
  var uid;

  FoodHomeUi({Key? key, this.uid}) : super(key: key);

  @override
  State<FoodHomeUi> createState() => _FoodHomeUiState();
}

class _FoodHomeUiState extends State<FoodHomeUi> {
  bool isSelected = false;
  var reslist = 2;

  var checkList;

  getList() {
    FirebaseFirestore.instance
        .collection('user')
        .doc(widget.uid)
        .snapshots()
        .listen((event) {
      checkList = event.get('favorites');
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getList();
    super.initState();
  }

  int limit = 3;

  @override
  Widget build(BuildContext context) {
    print("userid" + widget.uid);
    print(checkList);
    var scrwidth = MediaQuery.of(context).size.width;
    var scrheight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        drawer: Drawer(
          child: DrawerWidget(),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Builder(builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            );
          }),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodCartUi(),
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Badge(
                    badgeColor: Colors.grey,
                    badgeContent: Text(
                      cartList.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(
                      color: Colors.black,
                      Icons.shopping_cart,
                      size: scrheight * 0.0352,
                    ),
                  ),
                )),
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
                  padding: EdgeInsets.only(
                      left: scrheight * 0.035, bottom: scrheight * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: scrheight * 0.017, right: scrheight * 0.017),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scrheight * 0.02),
                          color: const Color(0xfffafafa),
                        ),
                        // height: 60.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: scrheight * 0.011,
                                  right: scrheight * 0.022),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: scrheight * 0.0352,
                              ),
                            ),
                            Flexible(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: scrheight * 0.024,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  fontSize: scrheight * 0.022,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: scrheight * 0.022,
                      ),
                      Text(
                        "Recommended",
                        style: TextStyle(fontSize: scrheight * 0.022),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('foods')
                                .where("recommended", isEqualTo: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasData &&
                                  snapshot.data!.docs.isEmpty) {
                                return const Center(
                                    child: Text('no recommendations found'));
                              } else {
                                return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var favicon = false;
                                      if (checkList != null) {
                                        for (int i = 0;
                                            i < checkList.length;
                                            i++) {
                                          if (snapshot.data!.docs[index]
                                                  ['foodid'] ==
                                              checkList[i]) {
                                            favicon = true;
                                          }
                                        }
                                      }

                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FoodDetailsUi(
                                                      image: snapshot.data!
                                                          .docs[index]['image'],
                                                      name: snapshot.data!
                                                          .docs[index]['name'],
                                                      description: snapshot
                                                              .data!.docs[index]
                                                          ['description'],
                                                      price: snapshot.data!
                                                          .docs[index]['price'],
                                                      rating: snapshot
                                                              .data!.docs[index]
                                                          ['rating'],
                                                    ),
                                                  ))
                                              .then((value) => setState(() {}));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: scrheight * 0.0147,
                                              right: scrheight * 0.022),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: scrheight * 0.3075,
                                                width: scrheight * 0.22,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image:
                                                            CachedNetworkImageProvider(
                                                                snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ['image']),
                                                        fit: BoxFit.cover),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            scrheight *
                                                                0.0293)),
                                                child: Container(
                                                  decoration: BoxDecoration(),
                                                  padding: EdgeInsets.only(
                                                      top: scrheight * 0.022,
                                                      bottom: scrheight * 0.022,
                                                      right: scrheight * 0.0147,
                                                      left: scrheight * 0.0147),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['name'],
                                                        style: TextStyle(
                                                            shadows: [
                                                              Shadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        1),
                                                                offset: Offset(
                                                                    1, 2),
                                                                blurRadius: 5,
                                                              ),
                                                            ],
                                                            fontSize: 17,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            scrheight * 0.0074,
                                                      ),
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['description'],
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            shadows: [
                                                              Shadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        1),
                                                                offset: Offset(
                                                                    1, 2),
                                                                blurRadius: 5,
                                                              ),
                                                            ],
                                                            color:
                                                                Colors.white),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            scrheight * 0.022,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data!.docs[index]['price']} Rs",
                                                            style: TextStyle(
                                                                shadows: [
                                                                  Shadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            1),
                                                                    offset:
                                                                        Offset(
                                                                            1,
                                                                            2),
                                                                    blurRadius:
                                                                        5,
                                                                  ),
                                                                ],
                                                                fontSize:
                                                                    scrheight *
                                                                        0.0176,
                                                                color: Colors
                                                                    .white70),
                                                          ),
                                                          SizedBox(
                                                            width: scrheight *
                                                                0.022,
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                if (favicon ==
                                                                    false) {
                                                                  favicon =
                                                                      true;
                                                                  checkList.add(snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'foodid']);
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'user')
                                                                      .doc(widget
                                                                          .uid)
                                                                      .update({
                                                                    "favorites":
                                                                        FieldValue.arrayUnion(
                                                                            checkList),
                                                                  });
                                                                } else {
                                                                  favicon =
                                                                      false;
                                                                  var delvalue =
                                                                      [];
                                                                  delvalue.add(snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'foodid']);
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'user')
                                                                      .doc(widget
                                                                          .uid)
                                                                      .update({
                                                                    "favorites":
                                                                        FieldValue.arrayRemove(
                                                                            delvalue),
                                                                  });
                                                                }

                                                                setState(() {});
                                                              },
                                                              child: Icon(
                                                                favicon == false
                                                                    ? Icons
                                                                        .favorite_border
                                                                    : Icons
                                                                        .favorite,
                                                                color:
                                                                    Colors.red,
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
                                    });
                              }
                            }),
                      ),
                      SizedBox(
                        height: scrheight * 0.0293,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: scrheight * 0.0147,
                            bottom: scrheight * 0.0293),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "More Foods",
                              style: TextStyle(fontSize: scrheight * 0.022),
                            ),
                            TextButton(
                                onPressed: () {
                                  limit += 3;
                                  setState(() {});
                                },
                                child: reslist == 2
                                    ? Text(
                                        "See more",
                                        style: TextStyle(
                                            fontSize: scrheight * 0.022,
                                            color: Color(0xffFFB52E)),
                                      )
                                    : Text(
                                        "See less",
                                        style: TextStyle(
                                            fontSize: scrheight * 0.022,
                                            color: Color(0xffFFB52E)),
                                      ))
                          ],
                        ),
                      ),
                      Container(
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection('foods')
                                    .orderBy('name')
                                    .limit(limit)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasData &&
                                      snapshot.data!.docs.isEmpty) {
                                    return const Center(
                                        child: Text('no foods found'));
                                  } else {
                                    return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          var product =
                                              snapshot.data!.docs[index].data();
                                          var favicon = false;
                                          if (checkList != null) {
                                            for (int i = 0;
                                                i < checkList.length;
                                                i++) {
                                              if (snapshot.data!.docs[index]
                                                      ['foodid'] ==
                                                  checkList[i]) {
                                                favicon = true;
                                              }
                                            }
                                          }
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FoodDetailsUi(
                                                            image: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['image'],
                                                            name: snapshot.data!
                                                                    .docs[index]
                                                                ['name'],
                                                            description: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['description'],
                                                            price: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['price'],
                                                            rating: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['rating'],
                                                          ),
                                                        ))
                                                    .then((value) =>
                                                        setState(() {}));
                                              },
                                              child: WishListCard(
                                                product: product,
                                                favicon: favicon,
                                                checkList: checkList,
                                                uid: widget.uid,
                                              ));
                                        });
                                  }
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
