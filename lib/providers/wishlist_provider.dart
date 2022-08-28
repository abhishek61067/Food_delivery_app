import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:food_del/models/product_model.dart';

class WishListProvider with ChangeNotifier {
  /////////////////////////////////////create of CRUD
  void addWishListData({
    String? wishListId,
    String? wishListImage,
    String? wishListName,
    int? wishListPrice,
    int? wishListQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .set(
      {
        "wishListId": wishListId,
        "wishListImage": wishListImage,
        "wishListName": wishListName,
        "wishListPrice": wishListPrice,
        "wishListQuantity": wishListQuantity,
        "wishList": true,
      },
    );
  }

  //////////////get wishlist data
  List<ProductModel> wishList = [];

  getWishListData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .get();

    value.docs.forEach((element) {
      ProductModel productModel = ProductModel(
        productId: element.get("wishListId"),
        productImage: element.get("wishListImage"),
        productName: element.get("wishListName"),
        productPrice: element.get("wishListPrice"),
        productQuantity: element.get("wishListQuantity"),
      );
      newList.add(productModel);
    });
    wishList = newList;
    notifyListeners();
  }

  List<ProductModel> get getWishList {
    return wishList;
  }

  ///////////////delete wishlist item

  deleteWishList(wishListId) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .delete();
  }
}
