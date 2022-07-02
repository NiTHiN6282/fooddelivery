import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/widgets/wishlistcard.dart';

import 'fooddetailsui.dart';

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

                              return Container(
                                child: StreamBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: FirebaseFirestore.instance
                                        .collection('foods')
                                        .doc(snapshot.data!["favorites"][index])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (!snapshot.data!.exists) {
                                        return const Center(
                                            child: Text('No product found'));
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FoodDetailsUi(
                                                        image: snapshot
                                                            .data!['image'],
                                                        name: snapshot
                                                            .data!['name'],
                                                        description:
                                                            snapshot.data![
                                                                'description'],
                                                        price: snapshot
                                                            .data!['price'],
                                                        rating: snapshot
                                                            .data!['rating'],
                                                      ),
                                                    ))
                                                .then(
                                                    (value) => setState(() {}));
                                          },
                                          child: WishListCard(
                                            product: snapshot.data!.data(),
                                            fromWishlist: true,
                                            checkList: checkList,
                                            uid: widget.uid,
                                          ),
                                        );
                                      }
                                    }),
                              );
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
