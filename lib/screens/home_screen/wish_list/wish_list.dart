import "package:flutter/material.dart";
import 'package:food_del/config/colors.dart';
import 'package:food_del/models/product_model.dart';
import 'package:food_del/models/review_cart_model.dart';
import 'package:food_del/providers/reveiw_cart_provider.dart';
import 'package:food_del/providers/wishlist_provider.dart';
import 'package:food_del/widgets/single_item.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  ReviewCartProvider reviewCartProvider = ReviewCartProvider();
  WishListProvider? wishListProvider;

  // const ReviewCart({Key? key}) : super(key: key);
  showAlertDialog(BuildContext context, ProductModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        wishListProvider!.deleteWishList(delete.productId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Are you sure to delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider!.getWishListData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "WishList",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: ListView.builder(
        //Problem indicates that, getReviewCartDataList is empty
        //Remove the code below :itemcount to see error.
        itemCount: wishListProvider?.getWishList.length,
        itemBuilder: (context, index) {
          ProductModel data = wishListProvider!.getWishList[index];
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SingleItem(
                isBool: true,
                wishList: false,
                productImage: data.productImage,
                productName: data.productName,
                productPrice: data.productPrice,
                productId: data.productId,
                productQuantity: data.productQuantity,
                onDelete: () {
                  showAlertDialog(context, data);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
