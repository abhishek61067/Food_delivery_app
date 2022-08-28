import "package:flutter/material.dart";
import 'package:food_del/providers/product_provider.dart';
import "package:food_del/screens/home_screen/drawer_side.dart";
import "package:food_del/config/colors.dart";
import 'package:food_del/screens/home_screen/product_overview/product_overview.dart';
import 'package:food_del/screens/home_screen/review_cart/review_cart.dart';
import "package:food_del/screens/home_screen/single_product.dart";
import "package:food_del/screens/home_screen/search/search.dart";
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({Key? key}) : super(key: key);

  ProductProvider productProvider = new ProductProvider();

  // herbs product section function starts
  Widget _buildHerbsProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Fresh Vegetables'),
            //GestureDetector is class or an alternative for buttons that has onTap property.
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Search(search: productProvider.getHerbsProductDataList),
                  ),
                );
              },
              child: Text('View all',
                  style: TextStyle(
                    color: Colors.grey,
                  )),
            ),
          ]),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getHerbsProductDataList.map<Widget>(
              (herbsProductData) {
                return SingleProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productName: herbsProductData.productName,
                          productImage: herbsProductData.productImage,
                          productPrice:
                              herbsProductData.productPrice.toString(),
                          productId: herbsProductData.productId,
                          // productId: herbsProductData.productId,
                        ),
                      ),
                    );
                  },
                  productImage: herbsProductData.productImage,
                  productName: herbsProductData.productName,
                  productPrice: herbsProductData.productPrice,
                  productId: herbsProductData.productId,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  // herbs product section function ends
  Widget _buildFreshProduct(context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Fresh Fruits'),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      Search(search: productProvider.getFreshProductDataList),
                ),
              );
            },
            child: Text('View all',
                style: TextStyle(
                  color: Colors.grey,
                )),
          ),
        ]),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: productProvider.getFreshProductDataList.map<Widget>(
            (freshProductData) {
              return SingleProduct(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductOverview(
                        productName: freshProductData.productName,
                        productImage: freshProductData.productImage,
                        productPrice: freshProductData.productPrice.toString(),
                        productId: freshProductData.productId,
                      ),
                    ),
                  );
                },
                productImage: freshProductData.productImage,
                productName: freshProductData.productName,
                productPrice: freshProductData.productPrice,
                productId: freshProductData.productId,
              );
            },
          ).toList(),
        ),
      ),
    ]);
  }

  @override
  // initState will run only once. So to avoid error, we are using listen false as a parameter of it.
  void initState() {
    // TODO: implement initState
    productProvider = Provider.of(context, listen: false);
    productProvider.fetchHerbsProductData();
    productProvider.fetchFreshProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    // );
    // productProvider.fetchHerbsProductData();
    return Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        drawer: DrawerSide(),
        appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(
            color: textColor,
          ),
          title: Text('Home', style: TextStyle(color: textColor, fontSize: 17)),
          actions: [
            CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xffd4d181),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Search(
                          search: productProvider.getAllProductSearch,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    size: 17,
                    color: textColor,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xffd4d181),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ReviewCart(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.shop_outlined,
                      size: 15,
                      color: textColor,
                    ),
                  )),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: ListView(children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://t4.ftcdn.net/jpg/01/43/88/31/360_F_143883132_bn9n14k3aX10bq5HN18IYHPbx9YyiSEA.jpg'),
                  ),
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      // color: Colors.red,
                      child: ListView(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 160,
                            bottom: 20,
                          ),
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Color(0xffD2B02A),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                )),
                            child: Center(
                              child: Text(
                                "YOMMI",
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.green,
                                        blurRadius: 10,
                                        offset: Offset(3, 3),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            '30% Off',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.green,
                                    blurRadius: 5,
                                    offset: Offset(5, 5),
                                  )
                                ]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 40,
                          ),
                          child: Text(
                            'On all vegetable products',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ]),
              ),

              // vegetable section starts
              _buildHerbsProduct(context),

              //vegetable section ends

              //fruits section starts
              _buildFreshProduct(context),
              //fruits section ends
            ])));
  }
}
