import "package:food_del/config/colors.dart";
import "package:flutter/material.dart";
import 'package:food_del/models/delivery_address_model.dart';
import 'package:food_del/providers/check_out_provider.dart';
import 'package:food_del/screens/home_screen/checkout/delivery_details/single_delivery_item.dart';
import 'package:food_del/screens/home_screen/checkout/payment_summary/payment_summary.dart';
import 'package:provider/provider.dart';

import '../add_delivery_address/add_delivery_address.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  DeliveryAddressModel value = DeliveryAddressModel();
  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    // var deliveryAddressModel = deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("Delivery Details"),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddDeliveryAddress(),
              ), // MaterialPageRoute
            );
          },
        ), // FloatingActionButton
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
          child: MaterialButton(
            child: deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Text("Add new Address")
                : Text("Payment Summary"),
            onPressed: () {
              deliveryAddressProvider.getDeliveryAddressList.isEmpty
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddDeliveryAddress(),
                      ), // MaterialPageRoute
                    )
                  : Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentSummary(
                          deliveryAddressList: value,
                        ),
                      ), // MaterialPageRoute
                    );
            },
            color: primaryColor,
          ), // MaterialButton
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text("Deliver To"),
              leading: Image.network(
                "https://www.kindpng.com/picc/m/408-4080243_location-pin-png-pin-map-png-icon-transparent.png",
                height: 36,
              ), // Image.asset
            ), // listTile
            Divider(
              height: 1,
            ), // Divider
            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Container(
                    child: Center(
                      child: Text("No data"),
                    ),
                  )
                : Column(
                    children: deliveryAddressProvider.getDeliveryAddressList
                        .map<Widget>((e) {
                      setState(
                        () {
                          value = e;
                        },
                      );
                      return SingleDeliveryItem(
                          title: "${e.firstName} ${e.lastName}",
                          addressType: e.addressType!
                              .substring(13, e.addressType!.length),
                          address: e.city,
                          number: e.mobileNo);
                    }).toList(),
                  ),
          ],
        ) // Container
        ); // Scaffold
  }
}
