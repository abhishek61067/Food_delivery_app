//the list of items in search list are being get from product_provider.dart.

import 'package:flutter/material.dart';
import 'package:food_del/config/colors.dart';
import 'package:food_del/models/product_model.dart';
import 'package:food_del/screens/home_screen/single_product.dart';
// import 'package:food_app/widgets/single_item.dart';
import 'package:food_del/widgets/single_item.dart';

class Search extends StatefulWidget {
  // const Search({Key? key}) : super(key: key);

  List<ProductModel> search;
  Search({this.search = const []});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";
  @override

  //For searching element in search bar
  searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toString().toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  Widget build(BuildContext context) {
    List<ProductModel> _searchItem = searchItem(query);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Search"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.menu_rounded),
          ),
        ],
      ),
      body: ListView(children: [
        ListTile(
          title: Text('Items'),
        ),
        Container(
          height: 52,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (value) {
              // print(value);
              setState(() {
                query = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              fillColor: Color(0xffc2c2c2),
              filled: true,
              hintText: "Search for items in the store",
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
            children: _searchItem.map<Widget>((data) {
          return SingleItem(
            isBool: false,
            productImage: data.productImage,
            productName: data.productName,
            productPrice: data.productPrice,
          );
        }).toList()),
      ]),
    );
  }
}
