import 'package:flutter/material.dart';

import 'datalist.dart';

class FoodCartUi extends StatefulWidget {
  const FoodCartUi({Key? key}) : super(key: key);

  @override
  State<FoodCartUi> createState() => _FoodCartUiState();
}

class _FoodCartUiState extends State<FoodCartUi> {
  var discount = 2;
  var delivery = 3;
  var totalPrice;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    int subTotal = 0;

    for (int i = 0; i < cartList.length; i++) {
      int x = cartList[i]['price'] * cartList[i]['quantity'];
      subTotal = x + subTotal;
    }

    print(subTotal);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h * .07,
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(h * 0.0293),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: h * 0.022),
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Text(
                    "Cart List",
                    style: TextStyle(
                      fontSize: h * 0.03,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Container(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartList.length == 0 ? 1 : cartList.length,
                      itemBuilder: (context, index) {
                        if (cartList.isEmpty) {
                          return Center(
                            child: Container(
                                padding: EdgeInsets.all(h * 0.0293),
                                child: Text(
                                  "Cart is empty",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: h * 0.0293),
                                )),
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.all(h * 0.007),
                            padding: EdgeInsets.all(h * 0.021),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(h * 0.0293)),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  cartList[index]['img'],
                                                ),
                                                fit: BoxFit.cover),
                                            borderRadius: BorderRadius.circular(
                                                h * 0.0176),
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: h * 0.01,
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cartList[index]['name'],
                                                style: TextStyle(
                                                    fontSize: h * 0.0162),
                                              ),
                                              SizedBox(
                                                height: h * 0.025,
                                              ),
                                              Text(
                                                cartList[index]['price']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: h * 0.0176),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: h * 0.15,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (cartList[index]
                                                          ['quantity'] ==
                                                      1) {
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                            'Remove?'),
                                                        content: Text(
                                                            'Do you want to remove ${cartList[index]['name']} from cart?'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context,
                                                                    'No'),
                                                            child: const Text(
                                                                'Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              undoList.add({
                                                                'name': cartList[
                                                                        index]
                                                                    ['name'],
                                                                'img': cartList[
                                                                        index]
                                                                    ['img'],
                                                                'price': cartList[
                                                                        index]
                                                                    ['price'],
                                                                'quantity': 1,
                                                                'index': index
                                                              });
                                                              print("ds" +
                                                                  undoList
                                                                      .toString());
                                                              final snackBar =
                                                                  SnackBar(
                                                                content: Text(cartList[
                                                                            index]
                                                                        [
                                                                        'name'] +
                                                                    " removed from Cart!"),
                                                                action:
                                                                    SnackBarAction(
                                                                  label: 'Undo',
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      cartList.insert(
                                                                          undoList.last[
                                                                              'index'],
                                                                          undoList
                                                                              .last);
                                                                      undoList
                                                                          .removeLast();
                                                                    });
                                                                  },
                                                                ),
                                                              );
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                              cartList.removeAt(
                                                                  index);
                                                              setState(() {});
                                                              Navigator.pop(
                                                                  context,
                                                                  'Yes');
                                                            },
                                                            child: const Text(
                                                                'OK'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                  if (cartList[index]
                                                          ['quantity'] >
                                                      1) {
                                                    cartList[index]
                                                            ['quantity'] =
                                                        cartList[index]
                                                                ['quantity'] -
                                                            1;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                color: cartList[index]
                                                            ['quantity'] ==
                                                        1
                                                    ? Colors.white
                                                    : Color(0xffbe7f4d),
                                                child: cartList[index]
                                                            ['quantity'] ==
                                                        1
                                                    ? Icon(Icons.delete_forever,
                                                        color:
                                                            Color(0xffbe7f4d),
                                                        size: h * 0.03)
                                                    : Icon(Icons.remove,
                                                        color: Colors.white,
                                                        size: h * 0.0225),
                                              ),
                                            ),
                                            SizedBox(
                                              width: h * 0.02,
                                            ),
                                            Container(
                                                width: h * 0.036,
                                                child: Center(
                                                    child: Text(
                                                  cartList[index]['quantity']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: h * 0.0185),
                                                ))),
                                            SizedBox(
                                              width: h * 0.02,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  cartList[index]['quantity'] =
                                                      cartList[index]
                                                              ['quantity'] +
                                                          1;
                                                  print(cartList[index]
                                                      ['quantity']);
                                                });
                                              },
                                              child: Container(
                                                  color: Color(0xffbe7f4d),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: h * 0.0225,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: h * 0.0147,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total " +
                                                  "\$${cartList[index]['price'] * cartList[index]['quantity']}",
                                              style: TextStyle(
                                                  fontSize: h * 0.0191,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  cartList.removeAt(index);
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.black,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(h * 0.0074),
                      width: w,
                      height: h * 0.07,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(h * 0.017)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.discount,
                            color: Color(0xffbe7f4d),
                            size: h * 0.0352,
                          ),
                          SizedBox(
                            width: h * 0.0147,
                          ),
                          Text(
                            'Do you have an discount code?',
                            style: TextStyle(fontSize: h * 0.0205),
                          )
                        ],
                      )),
                  SizedBox(
                    height: h * 0.015,
                  ),
                  Container(
                    padding: EdgeInsets.all(h * 0.02),
                    width: w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(h * 0.0176),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(fontSize: h * 0.0205),
                            ),
                            Text(
                              '\$${subTotal}',
                              style: TextStyle(fontSize: h * 0.0205),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount',
                              style: TextStyle(fontSize: h * 0.0205),
                            ),
                            Text(
                              '-\$${discount}',
                              style: TextStyle(fontSize: h * 0.0205),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery',
                              style: TextStyle(fontSize: h * 0.0205),
                            ),
                            Text(
                              '\$${delivery}',
                              style: TextStyle(fontSize: h * 0.0205),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h * 0.015,
                        ),
                        Divider(
                          indent: 25,
                        ),
                        SizedBox(
                          height: h * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(fontSize: h * 0.0205),
                            ),
                            Text(
                              '\$${subTotal - discount + delivery}',
                              style: TextStyle(fontSize: h * 0.0205),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h * 0.05,
                        ),
                        Container(
                          width: h * 0.7,
                          height: h * 0.08,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(h * 0.0293)),
                              primary: Colors.black,
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Checkout",
                                  style: TextStyle(fontSize: h * 0.0205),
                                ),
                                SizedBox(
                                  width: h * 0.015,
                                ),
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.orangeAccent,
                                  size: h * 0.0367,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
