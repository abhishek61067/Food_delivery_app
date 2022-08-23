import 'package:flutter/material.dart';
import 'package:food_del/config/colors.dart';

class SingleProduct extends StatelessWidget {
  // const SingleProduct({Key? key}) : super(key: key);
  final String? productImage;
  final String? productName;
  final int? productPrice;
  final onTap;
  // final onTap;
  SingleProduct(
      {this.productImage, this.productName, this.productPrice, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            height: 230,
            width: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffd0dad9),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      height: 350,
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      child: Image.network(
                        productImage.toString(),
                      ),
                    ),
                  ),
                ),

                // Expanded(flex: 2, child: Image.network(productImage)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$productPrice\$/50 Gram',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 5),
                                height: 25,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '50 Gram',
                                        style: TextStyle(fontSize: 10.65),
                                      ),
                                    ),
                                    Expanded(
                                      child: Icon(Icons.arrow_drop_down,
                                          size: 20, color: primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 5),
                                height: 25,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.remove,
                                      size: 15,
                                      color: primaryColor,
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(
                                        color: primaryColor,
                                      ),
                                    ),
                                    Icon(
                                      Icons.add,
                                      size: 15,
                                      color: primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
