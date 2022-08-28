//model refer to table.

class ProductModel {
  String? productName;
  String? productImage;
  int? productPrice;
  String? productId;
  int? productQuantity;

  //constructor
  ProductModel(
      {this.productImage,
      this.productName,
      this.productPrice,
      this.productId,
      this.productQuantity});
}

// for state management, we will use provider


