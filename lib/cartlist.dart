import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/datalist.dart';
import 'package:fooddelivery/foodcartui.dart';

// CartList(
// img: cartList[index]['img'],
// name: cartList[index]['name'],
// price: cartList[index]['price'],
// indexvar: index,
// quantity: cartList[index]['quantity'],
// )

class CartList extends StatefulWidget {

  var name;
  var img;
  var price;
  var indexvar;
  var quantity;

  CartList({Key? key,
    required this.img,
    required this.name,
  required this.price, required this.indexvar,
  required this.quantity,
  }) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {

  var tempPrice;


  @override
  Widget build(BuildContext context) {
    // var tempqty=cartList[widget.indexvar]['quantity'];
    // int nums=1;
    var h=MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(h*0.007),
      padding: EdgeInsets.all(h*0.03),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),

      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.all(h*0.015),
                    child: Image.asset(
                      widget.img,
                      width: h*0.06,
                      height: h*0.06,
                    ),
                  ),
                  SizedBox(
                    width: h*0.01,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.name),
                        SizedBox(
                          height: h*0.025,
                        ),
                        Text("\$${widget.price*cartList[widget.indexvar]['quantity']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: h*0.17,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState((){
                        if(cartList[widget.indexvar]['quantity']==1){
                          cartList.removeAt(widget.indexvar);
                        }
                        if(cartList[widget.indexvar]['quantity']>1){
                          cartList[widget.indexvar]['quantity']=cartList[widget.indexvar]['quantity']-1;
                        }
                      });
                    },
                    child: Container(
                      color:Color(0xffbe7f4d),
                      child: Icon(Icons.remove,
                        color: Colors.white,),
                    ),
                  ),
                  SizedBox(
                    width: h*0.025,
                  ),
                  Container(
                      width: h*0.036,
                      child: Center(child: Text(cartList[widget.indexvar]['quantity'].toString()))),
                  SizedBox(
                    width: h*0.025,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState((){
                        cartList[widget.indexvar]['quantity']=cartList[widget.indexvar]['quantity']+1;
                        print(cartList[widget.indexvar]['quantity']);
                      });
                    },
                    child: Container(
                        color: Color(0xffbe7f4d),
                        child: Icon(Icons.add,
                            color:Colors.white)

                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );

  }
}
