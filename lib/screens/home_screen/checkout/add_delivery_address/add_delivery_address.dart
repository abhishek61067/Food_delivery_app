import "package:flutter/material.dart";
import 'package:food_del/providers/check_out_provider.dart';
import 'package:food_del/screens/home_screen/checkout/google_map/google_map.dart';
import 'package:provider/provider.dart';

import '../../../../config/colors.dart';
import "package:food_del/widgets/custom_text_field.dart";

class AddDeliveryAddress extends StatefulWidget {
  // const AddDeliveryAddress({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  AddressTypes? myType = AddressTypes.Home;

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add delivery address"),
        backgroundColor: primaryColor,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
        height: 48,
        child: checkoutProvider.isLoading == false
            ? MaterialButton(
                onPressed: () {
                  checkoutProvider.validator(context, myType);
                },
                child: Text(
                  "Add Address",
                  style: TextStyle(
                    color: textColor,
                  ), // TextStyle
                ), // Text I
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    39,
                  ), // BorderRadius.circular
                ), // RoundedReftanglesorder
              )
            : Center(
                child: CircularProgressIndicator(),
              ), // MaterialButton
      ), // Container
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 26,
        ), // EdgeInsets.symmetric
        child: ListView(children: [
          CustomTextField(
            labText: "First name",
            controller: checkoutProvider.firstName,
          ),
          // CustomTextField
          CustomTextField(
            labText: "Last Name",
            controller: checkoutProvider.lastName,
          ), // CustomTextField
          CustomTextField(
            labText: "Mobile Number",
            controller: checkoutProvider.mobileNo,
          ),
          CustomTextField(
            labText: "City",
            controller: checkoutProvider.city,
          ),
          CustomTextField(
            labText: "landMark",
            controller: checkoutProvider.landMark,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CustomGoogleMap(),
                ),
              );
            },
            child: Container(
              height: 40,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  checkoutProvider.setLocation == null
                      ? Text("Set Location")
                      : Text("Your Location"),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 35,
          ),
          ListTile(
            title: Text("Address Type"),
          ),
          RadioListTile(
            value: AddressTypes.Home,
            groupValue: myType,
            title: Text("Home"),
            onChanged: (AddressTypes? value) {
              setState(() {
                myType = value;
              });
            },
            secondary: Icon(
              Icons.home,
              color: primaryColor,
            ),
          ),

          RadioListTile(
            value: AddressTypes.Work,
            groupValue: myType,
            title: Text("Work"),
            onChanged: (AddressTypes? value) {
              setState(() {
                myType = value;
              });
            },
            secondary: Icon(
              Icons.work,
              color: primaryColor,
            ),
          ),
          RadioListTile(
            value: AddressTypes.Other,
            groupValue: myType,
            title: Text("Others"),
            onChanged: (AddressTypes? value) {
              setState(() {
                myType = value;
              });
            },
            secondary: Icon(
              Icons.devices_other,
              color: primaryColor,
            ),
          ),
        ] // Cus
            ),
      ),
    );
  }
}
