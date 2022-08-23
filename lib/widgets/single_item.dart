//search_item is a widget that is getting called by search.dart inside listview after container.

import "package:flutter/material.dart";
import "package:food_del/config/colors.dart";

class SingleItem extends StatelessWidget {
  // const SingleItem({Key? key}) : super(key: key);
  bool isBool = false;
  SingleItem({required this.isBool});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  child: Center(
                    child: Image.network(
                        "https://flyclipart.com/thumbs/pineapple-fruit-tropical-fruit-natural-foods-ananas-ananas-fruit-1119510.png"),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: isBool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "productname",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "50\$/50 gram",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      isBool == false
                          ? Container(
                              margin: EdgeInsets.only(right: 15),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "50 gram",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 20,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text("50 gram"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  padding: isBool == false
                      ? EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                      : EdgeInsets.only(left: 15, right: 15),
                  child: isBool == false
                      ? Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                Text(
                                  "ADD",
                                  style: TextStyle(
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 25,
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    Text(
                                      "ADD",
                                      style: TextStyle(
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
        isBool == false
            ? Container()
            : Divider(
                height: 1,
                color: Colors.black45,
              ),
      ],
    );
  }
}
