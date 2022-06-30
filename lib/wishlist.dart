import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'datalist.dart';
import 'foodfavoriteui.dart';

class WishListPage extends StatefulWidget {
  var uid;

  WishListPage({Key? key, this.uid}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
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
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final items = List<String>.generate(checkList.length+1, (i) => '${i + 1}');
    var scrheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Wishlist",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('user')
                        .doc(widget.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData &&
                          snapshot.data!['favorites'].isEmpty) {
                        return const Center(child: Text('Wishlist is empty'));
                      } else {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!['favorites'].length,
                            itemBuilder: (context, index) {
                              // final item=items[index];

                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FoodFavoriteUi(
                                            image: wishList[index]["img"],
                                            name: wishList[index]["name"],
                                            description: wishList[index]
                                                ["description"],
                                            price: wishList[index]["price"],
                                            rating: wishList[index]['rating'],
                                          ),
                                        )).then((value) => setState(() {}));
                                  },
                                  child: Container(
                                    child: StreamBuilder<
                                            DocumentSnapshot<
                                                Map<String, dynamic>>>(
                                        stream: FirebaseFirestore.instance
                                            .collection('foods')
                                            .doc(snapshot.data!["favorites"]
                                                [index])
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (!snapshot.data!.exists) {
                                            return const Center(
                                                child:
                                                    Text('No product found'));
                                          } else {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FoodFavoriteUi(
                                                            image: snapshot
                                                                .data!['image'],
                                                            name: snapshot
                                                                .data!['name'],
                                                            description: snapshot
                                                                    .data![
                                                                'description'],
                                                            price: snapshot
                                                                .data!['price'],
                                                            rating:
                                                                snapshot.data![
                                                                    'rating'],
                                                          ),
                                                        ))
                                                    .then((value) =>
                                                        setState(() {}));
                                              },
                                              child: wishlistCard(
                                                product: snapshot.data!.data(),
                                                fromWishlist: true,
                                                checkList: checkList,
                                                uid: widget.uid,
                                              ),
                                            );
                                          }
                                        }),
                                  ));
                            });
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

class wishlistCard extends StatefulWidget {
  final Map<String, dynamic>? product;
  final bool fromWishlist;
  var favicon;
  var checkList;
  var uid;

  wishlistCard(
      {Key? key,
      required this.product,
      this.fromWishlist = false,
      this.favicon,
      this.checkList,
      this.uid})
      : super(key: key);

  @override
  State<wishlistCard> createState() => _wishlistCardState();
}

class _wishlistCardState extends State<wishlistCard> {
  @override
  Widget build(BuildContext context) {
    var scrheight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: widget.fromWishlist
          ? Dismissible(
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
                ),
              ),
              direction: DismissDirection.endToStart,
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm"),
                      content:
                          Text("Are you sure you wish to delete this item?"),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            var delvalue = [];
                            delvalue.add(widget.product!['foodid']);
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(widget.uid)
                                .update({
                              "favorites": FieldValue.arrayRemove(delvalue),
                            });
                            setState(() {});
                            Navigator.of(context).pop(true);
                          },
                          child: Text(
                            "DELETE",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
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
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              onDismissed: (direction) {
                setState(() {});
              },
              key: Key(UniqueKey().toString()),
              child: Container(
                padding: EdgeInsets.only(bottom: scrheight * 0.0147),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(scrheight * 0.0293)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: scrheight * 0.1465,
                      height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                widget.product!['image'],
                              ),
                              fit: BoxFit.cover),
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.circular(scrheight * 0.022)),
                    ),
                    // SizedBox(
                    //   width: scrheight*0.022,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product!['name'],
                          style: TextStyle(fontSize: scrheight * 0.0205),
                        ),
                        Row(
                          children: [
                            RatingBar.builder(
                              ignoreGestures: true,
                              itemSize: 15,
                              initialRating:
                                  widget.product!['rating'].toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                // print(rating);
                              },
                            ),
                            SizedBox(
                              width: scrheight * 0.0586,
                            ),
                            Text(
                              widget.product!['price'].toString(),
                              style: TextStyle(
                                  fontSize: scrheight * 0.0191,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        var delvalue = [];
                        delvalue.add(widget.product!['foodid']);
                        FirebaseFirestore.instance
                            .collection('user')
                            .doc(widget.uid)
                            .update({
                          "favorites": FieldValue.arrayRemove(delvalue),
                        });
                        setState(() {});
                      },
                      child: Icon(
                        widget.favicon == false
                            ? Icons.favorite_border
                            : Icons.favorite,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.only(bottom: scrheight * 0.0147, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(scrheight * 0.0293)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: scrheight * 0.1465,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.product!['image'],
                            ),
                            fit: BoxFit.cover),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(scrheight * 0.022)),
                  ),
                  // SizedBox(
                  //   width: scrheight*0.022,
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product!['name'],
                        style: TextStyle(fontSize: scrheight * 0.0205),
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            itemSize: 15,
                            initialRating: widget.product!['rating'].toDouble(),
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
                            width: 20,
                          ),
                          Text(
                            widget.product!['price'].toString(),
                            style: TextStyle(
                                fontSize: scrheight * 0.0191,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.favicon == false) {
                        widget.favicon = true;
                        widget.checkList.add(widget.product!['foodid']);
                        FirebaseFirestore.instance
                            .collection('user')
                            .doc(widget.uid)
                            .update({
                          "favorites": FieldValue.arrayUnion(widget.checkList),
                        });
                      } else {
                        widget.favicon = false;
                        var delvalue = [];
                        delvalue.add(widget.product!['foodid']);
                        FirebaseFirestore.instance
                            .collection('user')
                            .doc(widget.uid)
                            .update({
                          "favorites": FieldValue.arrayRemove(delvalue),
                        });
                      }
                      setState(() {});
                    },
                    child: Icon(
                      widget.favicon == false
                          ? Icons.favorite_border
                          : Icons.favorite,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
