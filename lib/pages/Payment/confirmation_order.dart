import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_food_delivery/main.dart';
import 'package:new_food_delivery/pages/home/home_page.dart';
import 'package:provider/provider.dart';

import '../../appColors/app_colors.dart';
import '../../route/routing_page.dart';
import '../../widgets/my_button.dart';
import '../provider/cart_provider.dart';

class ConfirmationOrder extends StatefulWidget {
  const ConfirmationOrder({super.key});

  @override
  State<ConfirmationOrder> createState() => _ConfirmationOrderState();
}

class _ConfirmationOrderState extends State<ConfirmationOrder> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kgradientk1,
        centerTitle: true,
        title: Text(
          "Order Proccessing",
          style: TextStyle(
            color: AppColors.kwhiteColor,
          ),
        ),
      ),
      body: cartProvider.getCartList.isEmpty
          ? Center(
              child: Text("No Products"),
            )
          : Container(
              // padding: EdgeInsets.only(top: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: NetworkImage(
                      "https://cdn.pixabay.com/photo/2022/01/28/12/17/fast-food-6974507_1280.jpg",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "ORDER CONFIRMED!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Your delicious Food is on the Way!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.favorite_sharp,
                    color: Colors.red[800],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      color: AppColors.kgradientk1,
                      size: 120,
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  MyButton(
                    onPressed: () {
                      RoutingPage.goTonext(
                        context: context,
                        navigateTo: HomePage(),
                      );
                    },
                    text: "Return to HomePage",
                  )
                ],
              ),
            ),
    );
  }
}
