import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WishListCard extends StatefulWidget {
  final Map<String, dynamic>? product;
  final bool fromWishlist;
  var favicon;
  var checkList;
  var uid;

  WishListCard(
      {Key? key,
      required this.product,
      this.fromWishlist = false,
      this.favicon,
      this.checkList,
      this.uid})
      : super(key: key);

  @override
  State<WishListCard> createState() => _WishListCardState();
}

class _WishListCardState extends State<WishListCard> {
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
