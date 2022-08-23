//model refer to table.

class ProductModel {
  String productName;
  String productImage;
  int productPrice;

  //constructor
  ProductModel(
      {required this.productImage,
      required this.productName,
      required this.productPrice});
}

// for state management, we will use provider


