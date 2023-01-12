import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_food_delivery/route/routing_page.dart';
import 'package:new_food_delivery/widgets/my_button.dart';
import 'package:new_food_delivery/widgets/single_cart_item.dart';

import '../checkout/check_out_page.dart';

class cartpage extends StatelessWidget {
  const cartpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyButton(
        text: "Check Out",
        onPressed: () {
          RoutingPage.goTonext(context: context, navigateTo: CheckOutPage(),
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("cart")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("UserCart")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
          if (!streamSnapshort.hasData) {
            return Center(child: const CircularProgressIndicator());
          }
          return streamSnapshort.data!.docs.isEmpty?Center(
            child: Text("No Cart"),
          ):
          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: streamSnapshort.data!.docs.length,
            itemBuilder: (ctx, index) {
              var data = streamSnapshort.data!.docs[index];
              return SingleCartItem(
                productID: data["productID"],
                productimage: data["productimage"],
                productPrice: data["productPrice"],
                productQuantity: data["productQuantity"],
                productName: data["productName"],
                productCategory: data["productCategory"],
              );
            },
          );
        },
      ),
    );
  }
}
