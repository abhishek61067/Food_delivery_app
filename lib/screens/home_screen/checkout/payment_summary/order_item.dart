import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";
import 'package:food_del/models/review_cart_model.dart';

class OrderItem extends StatelessWidget {
  // const OrderItem({Key? key}) : super(key: key);
  bool? isTrue;
  ReviewCartModel? e;
  OrderItem({this.e});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        (e!.cartImage).toString(),
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            e!.cartName.toString(),
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            "50 gram",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            "\$${e!.cartPrice}",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
      subtitle: Text(e!.cartQuantity.toString()),
    );
  }
}
