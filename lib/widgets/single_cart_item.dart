import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_food_delivery/pages/cartpage/cart_page.dart';

class SingleCartItem extends StatefulWidget {
  final String productimage;
  final String productName;
  final double productPrice;
  final int productQuantity;
  final String productCategory;
  final String productID;

  const SingleCartItem({
    Key? key,
    required this.productID,
    required this.productCategory,
    required this.productPrice,
    required this.productQuantity,
    required this.productName,
    required this.productimage,
  }) : super(key: key);

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int quantity = 1;
  void quantityFunction() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("UserCart")
        .doc(widget.productID)
        .update(
      {
        "productQuantity": quantity,
      },
    );
  }
  void deleteProductFunction() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("UserCart")
        .doc(widget.productID)
        .delete();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      height: 159,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 7,
        ),
      ]),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.productimage),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.productName,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "\$${widget.productPrice * widget.productQuantity}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IncrementAndDecrement(
                            icon: Icons.add,
                            onPressed: () {
                              setState(() {
                                quantity++;
                                quantityFunction();
                              });
                            },
                          ),
                          Text(
                            widget.productQuantity.toString(),
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          IncrementAndDecrement(
                            icon: Icons.remove,
                            onPressed: () {
                              if (quantity > 1) {
                                setState(
                                  () {
                                    quantity--;
                                    quantityFunction();
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              deleteProductFunction();
            },
            icon: Icon(
              Icons.close,
            ),
          ),
        ],
      ),
    );
  }
}

class IncrementAndDecrement extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  const IncrementAndDecrement({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      height: 30,
      elevation: 2,
      color: Colors.grey[300],
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon),
    );
  }
}
