//ProductOverview is invoked when item is clicked in home_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import "package:food_del/config/colors.dart";
import 'package:food_del/providers/wishlist_provider.dart';
import "package:food_del/screens/home_screen/home_screen.dart";
import 'package:provider/provider.dart';

enum SigninCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  // const ProductOverview({Key? key}) : super(key: key);

  String? productName;
  String? productImage;
  String? productPrice;
  String? productId;
  // String? productId;
  ProductOverview({
    this.productName,
    this.productImage,
    this.productPrice,
    this.productId,
  });

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  SigninCharacter _character = SigninCharacter.fill;

  // String productImage = HomeScreen().bittergourd;
  Widget bottomNavigationBar({
    Color? iconColor,
    Color? backgroundColor,
    Color? color,
    String? title,
    IconData? iconData,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              iconData,
              size: 17,
              color: iconColor,
            ),
            SizedBox(width: 5),
            Text(
              title.toString(),
              style: TextStyle(color: color),
            ),
          ]),
        ),
      ),
    );
  }

  bool wishListBool = false;

  getWishListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  setState(() {
                    wishListBool = value.get("wishList");
                  }),
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    getWishListBool();
    WishListProvider wishListProvider = Provider.of(context);
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          bottomNavigationBar(
            onTap: () {
              setState(() {
                wishListBool = !wishListBool;
              });
              if (wishListBool == true) {
                wishListProvider.addWishListData(
                  wishListId: widget.productId.toString(),
                  wishListImage: widget.productImage,
                  wishListName: widget.productName,
                  wishListPrice: int.parse(widget.productPrice.toString()),
                  wishListQuantity: 2,
                );
              } else {
                wishListProvider.deleteWishList(widget.productId);
              }
            },
            iconColor: Colors.grey,
            backgroundColor: textColor,
            color: Colors.white70,
            title: "Add to wishlist",
            iconData:
                wishListBool == false ? Icons.favorite_outline : Icons.favorite,
          ),
          bottomNavigationBar(
              iconColor: Colors.white70,
              backgroundColor: primaryColor,
              color: textColor,
              title: "Go to cart",
              iconData: Icons.shop_outlined),
        ],
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text("Product Overview",
            style: TextStyle(
              color: textColor,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.productName.toString()),
                    subtitle: Text("\$50"),
                  ),
                  Container(
                    height: 250,
                    padding: EdgeInsets.all(40),
                    child: Image.network(widget.productImage.toString()),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Text(
                      "Available Options",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 3,
                                backgroundColor: Colors.green[700],
                              ),
                              Radio(
                                value: SigninCharacter.fill,
                                groupValue: _character,
                                activeColor: Colors.green[700],
                                onChanged: (val) {
                                  setState(() {
                                    //20:50
                                    _character = val as SigninCharacter;
                                    //val is getting assigned to _character which is of type SigninCharacter.
                                  });
                                },
                              ),
                            ],
                          ),
                          Text("\$${widget.productPrice}"),
                          Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add,
                                      size: 15, color: primaryColor),
                                  Text(
                                    "ADD",
                                    style: TextStyle(
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              )),
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About this product",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: textColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "this product is available in market of nepal. This product has been chosen as one of the qualitative product as of now.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
