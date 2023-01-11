import 'package:flutter/material.dart';
import 'package:new_food_delivery/pages/cartpage/cart_page.dart';

class SingleCartItem extends StatelessWidget {
  final String productimage;
  final String productName;
  final double productPrice;
  final int productQuantity;

  const SingleCartItem({
    Key? key,
    required this.productPrice,
    required this.productQuantity,
    required this.productName,
    required this.productimage,
  }) : super(key: key);

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
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(productimage),
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
                    productName,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "food",
                    style: TextStyle(),
                  ),
                  Text(
                    "\$$productPrice",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IncrementAndDecrement(
                        icon: Icons.add,
                        onPressed: () {},
                      ),
                      Text(
                        productQuantity.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      IncrementAndDecrement(
                        icon: Icons.remove,
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
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
