import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

//In simple words, provider is to communicate with database like setting and getting data.

//provider is a package for state management. It provides a state management technique
//that is used for managing a piece of data around the app.
//ChangeNotifier is a class that provides change notification to its listeners.
class ProductProvider with ChangeNotifier {
  //search is a list of ProductModel's objects.
  List<ProductModel> search = [];

  //Product model is a class or table for database.
  ProductModel productModel =
      ProductModel(productImage: "", productName: "", productPrice: 0);

//QueryDocumentSnapshot is a row of specific table(collection) in database
  productModels(QueryDocumentSnapshot element) {
    //If you want search list to be empty every time, you click on search add the code below:
    // List<ProductModel> search = [];

    productModel = ProductModel(
      productImage: element.get("productImage"),
      productName: element.get("productName"),
      productPrice: element.get("productPrice"),
      productId: element.get("productId"),
    );
    search.add(productModel);
  }

// herbsProduct
// Generics is the idea that you can create a data structure of any type
//we are now creating a list that would store list of herbsProduct from database.
  List<ProductModel> herbsProductList = [];

  //function to change the value of herbsProductList
  fetchHerbsProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("HerbsProduct").get();
    //docs means rows and value.docs is a list of rows thats why we are using forEach
    //value means collection because above, we are getting collection and assigning it to value.
    value.docs.forEach(
      (element) {
        // print(element.data());

        //element is a key value pair of field and value of rows.
        productModels(element);
        newList.add(productModel);
      },
    );
    herbsProductList = newList;
    //notifyListener in Provider is like setState in stateful widgets
    notifyListeners();
  }

//getter to return the herbsProductList
  List<ProductModel> get getHerbsProductDataList {
    return herbsProductList;
  }

  // freshProduct
  List<ProductModel> freshProductList = [];

  //function to change the value of freshProductList
  fetchFreshProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("FreshProduct").get();
    //docs means rows
    //value means collection because above, we are getting collection and assigning it to value.
    value.docs.forEach(
      (element) {
        // print(element.data());
        productModels(element);
        newList.add(productModel);
      },
    );
    freshProductList = newList;
    //notifyListener is like setState in stateful widgets
    notifyListeners();
  }

//getter to return the freshProductList
  List<ProductModel> get getFreshProductDataList {
    return freshProductList;
  }

//getter to return the products while clicking search button
  List<ProductModel> get getAllProductSearch {
    return search;
    //search is a list of ProductModel's objects.
  }
}
