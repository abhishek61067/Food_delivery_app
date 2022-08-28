//we are using two collection in review_cart.provider.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:firebase_auth/firebase_auth.dart";

import '../models/review_cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  /////////////////////////////////////create of CRUD
  void addReviewCartData({
    String? cartId,
    String? cartImage,
    String? cartName,
    int? cartPrice,
    int? cartQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .set(
      {
        "cartId": cartId,
        "cartImage": cartImage,
        "cartName": cartName,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "isAdd": true,
      },
    );
  }

  /////////////////////////////////////create of CRUD
  void updateReviewCartData({
    String? cartId,
    String? cartImage,
    String? cartName,
    int? cartPrice,
    int? cartQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .update(
      {
        "cartId": cartId,
        "cartImage": cartImage,
        "cartName": cartName,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "isAdd": true,
      },
    );
  }

  ReviewCartModel reviewCartModel = ReviewCartModel(
    cartId: "",
    cartImage: "",
    cartName: "",
    cartPrice: 0,
    cartQuantity: 0,
  );

  List<ReviewCartModel> reviewCartDataList = [];

  /////////////////////////////////////read of CRUD

  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];
    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .get();

    // the code is fine upto here
    //try adding QueryDocumentSnapshot before element
    reviewCartValue.docs.forEach((QueryDocumentSnapshot element) {
      reviewCartModel = ReviewCartModel(
        // code is fine upto here,reviewCartValue is being fetched and reviewcardmodel is created.
        //problem is here in the beginning of element.get
        cartId: element.get("cartId"),
        cartImage: element.get("cartImage"),
        cartName: element.get("cartName"),
        cartPrice: element.get("cartPrice"),
        cartQuantity: element.get("cartQuantity"),
        // cartId: "abc",
        // cartImage:
        //     "https://toppng.com/uploads/preview/cauliflower-11528338421d3fh2ayvne.png",
        // cartName: "tesko bau",
        // cartPrice: 30,
        // cartQuantity: 4,
      );
      newList.add(reviewCartModel);

      // print(reviewCartModel);

      // QuerySnapshot reviewCartValue =
      //     await FirebaseFirestore.instance.collection("HerbsProduct").get();

      // reviewCartValue.docs.forEach((element) {
      //   ReviewCartModel reviewCartModel = ReviewCartModel(
      //     cartId: element.get("productId"),
      //     cartImage: element.get("productImage"),
      //   );

      // notifyListeners in provider is equivalent to setState in stateful widget.
    });
    reviewCartDataList = newList;
    notifyListeners();
  }

////////////////////////////////////getter for ReviewCartdatalist
  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }

  /////////////////////////////////////delete of CRUD
  reviewCartDataDelete(cartId) {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .delete();
    notifyListeners();
  }

////////////////////////get total price
  getTotalPrice() {
    double total = 0.0;
    reviewCartDataList.forEach((element) {
      total += element.cartPrice! * element.cartQuantity!.toInt();
    });
    return total;
  }
}
