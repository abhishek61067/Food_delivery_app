import "package:flutter/material.dart";
import 'package:food_del/config/colors.dart';
import 'package:food_del/models/review_cart_model.dart';
import 'package:food_del/providers/reveiw_cart_provider.dart';
import 'package:food_del/screens/home_screen/checkout/delivery_details/delivery_details.dart';
import 'package:food_del/screens/home_screen/checkout/payment_summary/payment_summary.dart';
import 'package:food_del/widgets/single_item.dart';
import 'package:provider/provider.dart';
import "package:fluttertoast/fluttertoast.dart";

class ReviewCart extends StatelessWidget {
  ReviewCartProvider reviewCartProvider = ReviewCartProvider();
  // const ReviewCart({Key? key}) : super(key: key);

  showAlertDialog(BuildContext context, ReviewCartModel delete) {
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
        reviewCartProvider.reviewCartDataDelete(delete.cartId);
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
    reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "\$ ${reviewCartProvider.getTotalPrice()}",
          style: TextStyle(
            color: Colors.green[900],
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                var snackBar = SnackBar(
                    content:
                        Text('Cart is empty. PLease add something to proceed'));
                // Step 3
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else
                Navigator.of(context).push(
                    //Payment_Summary.dart
                    MaterialPageRoute(
                        builder: (context) => (DeliveryDetails())));
            },
            child: Text("Submit"),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Review Cart",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: ListView.builder(
        //Problem indicates that, getReviewCartDataList is empty
        //Remove the code below :itemcount to see error.
        itemCount: reviewCartProvider.getReviewCartDataList.length,
        itemBuilder: (context, index) {
          ReviewCartModel data =
              reviewCartProvider.getReviewCartDataList[index];
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SingleItem(
                isBool: true,
                wishList: true,
                // productImage:
                //     "https://cdn.britannica.com/45/5645-050-B9EC0205/head-treasure-flower-disk-flowers-inflorescence-ray.jpg",
                // productName: "",
                // productPrice: 12,
                productImage: data.cartImage,
                productName: data.cartName,
                productPrice: data.cartPrice,
                productId: data.cartId,
                productQuantity: data.cartQuantity,
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
