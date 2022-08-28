//logic is:
// first we will set count variable to be 1 and boolen to be false. When
//boolean is false, we will create a container with Text add and when clicked, boolean becomes true.
//when boolean is true, we create a row with - count indicator(text) and + button. and will give
// separate logics for both + and -.
//when add is clicked, we will create that item in database and isTrue to be true.
//when + is clicked, we will increment the count and update in database.
//when - is clicked, we will decrement the count until count becomes 1 and when count is 1 and - is cliked, we will
//delete the item from database and set isTrue to be false
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:food_del/providers/reveiw_cart_provider.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';

class Count extends StatefulWidget {
  // const Count({Key? key}) : super(key: key);

  String? productName;
  String? productImage;
  String? productId;
  int? productPrice;

  Count({
    this.productName,
    this.productId,
    this.productImage,
    this.productPrice,
  });

//The function down below is executing _CountState class.
  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;

  bool isTrue = false;

///////////////////function to make second expanded child of single_item in condition with boolean
  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      count = value.get("cartQuantity");
                      isTrue = value.get("isAdd");
                    })
                  }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    //to check if product is in review cart and decide to make either boolenan isTrue: true.
    getAddAndQuantity();
    //We are making an object of ReviewCartProvider. This is used when we click on add button
    //of items displayed in home_screen.
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);
    return Container(
      padding: EdgeInsets.only(left: 0),
      height: 25,
      width: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isTrue == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Icon(
                    Icons.remove,
                    size: 20,
                    color: primaryColor,
                  ),
                  onTap: () {
                    if (count > 1) {
                      setState(() {
                        count--;
                      });
                      reviewCartProvider.updateReviewCartData(
                        cartId: widget.productId,
                        cartImage: widget.productImage,
                        cartName: widget.productName,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                      );
                    } else if (count == 1) {
                      setState(() {
                        isTrue = false;
                      });
                      reviewCartProvider.reviewCartDataDelete(widget.productId);
                    }
                  },
                ),
                Text(
                  '$count',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: primaryColor,
                  ),
                  onTap: () {
                    setState(() {
                      count++;
                    });
                    reviewCartProvider.updateReviewCartData(
                      cartId: widget.productId,
                      cartImage: widget.productImage,
                      cartName: widget.productName,
                      cartPrice: widget.productPrice,
                      cartQuantity: count,
                    );
                  },
                ),
              ],
            )
          : Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isTrue = true;
                  });
                  reviewCartProvider.addReviewCartData(
                    cartId: widget.productId,
                    cartImage: widget.productImage,
                    cartName: widget.productName,
                    cartPrice: widget.productPrice,
                    cartQuantity: count,
                    // isAdd: true,
                  );
                },
                child: Text(
                  "ADD",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
    );
  }
}
