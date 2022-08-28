//For validation of textfileds in add_delivery_address.dart and also for crud operation 'AddDeliveryAddress' table.

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:fluttertoast/fluttertoast.dart";
import 'package:food_del/models/delivery_address_model.dart';
import 'package:location/location.dart';

class CheckoutProvider with ChangeNotifier {
  bool isLoading = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController landMark = TextEditingController();
  LocationData? setLocation;
  String message = "is empty";

  ///////////function for validation of add_delivery_address.dart and setting data in database.
  void validator(BuildContext context, myType) async {
    if (firstName.text.isEmpty) {
      var snackBar = SnackBar(content: Text("firstName ${message}"));
      // Step 3
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (lastName.text.isEmpty) {
      var snackBar = SnackBar(content: Text("lastName ${message}"));
      // Step 3
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (mobileNo.text.isEmpty) {
      var snackBar = SnackBar(content: Text("mobileNo ${message}"));
      // Step 3
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (city.text.isEmpty) {
      var snackBar = SnackBar(content: Text("city ${message}"));
      // Step 3
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (landMark.text.isEmpty) {
      var snackBar = SnackBar(content: Text("landmark ${message}"));
      // Step 3
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (setLocation == null) {
      var snackBar = SnackBar(content: Text("location ${message}"));
      // Step 3
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliveryAddress")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        "firstName": firstName.text,
        "lastName": lastName.text,
        "mobileNo": mobileNo.text,
        "city": city.text,
        "landMark": landMark.text,
        "addressType": myType.toString(),
        "longitude": setLocation!.longitude,
        "latitude": setLocation!.latitude,
      }).then((value) async {
        isLoading = false;
        notifyListeners();
        await ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Successfully Added")));
        Navigator.of(context).pop();
        notifyListeners();
      });
    }
  }

  List<DeliveryAddressModel> deliveryAddressList = [];
////////////function for getting data of AddDeliverAddress
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];
    DeliveryAddressModel deliveryAddressModel = DeliveryAddressModel();
    DocumentSnapshot tb = await FirebaseFirestore.instance
        .collection("AddDeliveryAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (tb.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        firstName: tb.get("firstName"),
        lastName: tb.get("lastName"),
        mobileNo: tb.get("mobileNo"),
        landMark: tb.get("landMark"),
        addressType: tb.get("addressType"),
        city: tb.get("city"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }

    deliveryAddressList = newList;
    notifyListeners();

    // return deliveryAddressModel;
  }

/////////////function to return delivery address data
  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAddressList;
  }
}
