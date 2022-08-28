import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import "package:flutter/material.dart";
import 'package:food_del/config/colors.dart';
import 'package:food_del/models/delivery_address_model.dart';
import 'package:food_del/providers/check_out_provider.dart';
import 'package:food_del/providers/reveiw_cart_provider.dart';
import 'package:food_del/screens/home_screen/checkout/delivery_details/single_delivery_item.dart';
import 'package:food_del/screens/home_screen/checkout/payment_summary/khalti_payment_page.dart';
import 'package:food_del/screens/home_screen/checkout/payment_summary/order_item.dart';
import 'package:provider/provider.dart';

class PaymentSummary extends StatefulWidget {
  // const PaymentSummary({Key? key}) : super(key: key);
  DeliveryAddressModel? deliveryAddressList = DeliveryAddressModel();
  PaymentSummary({this.deliveryAddressList});

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

enum AddressTypes {
  Esewa,
  Khalti,
  CashOnDelivery,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  AddressTypes? myType = AddressTypes.Khalti;

  // ReviewCartProvider? reviewCartProvider;
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    double discount = 2;
    double shipping = 1;
    double discountValue = 0;
    double shippingValue = 0;
    double total = 0;
    double totalPrice = reviewCartProvider.getTotalPrice();
    if (totalPrice > 10) {
      discountValue = (totalPrice * discount) / 100;
      shippingValue = (totalPrice * shipping) / 100;

      total = double.parse(
          (totalPrice - discountValue + shippingValue).toStringAsFixed(2));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Summary"),
        backgroundColor: primaryColor,
      ),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "\$${total == 0 ? totalPrice : total}",
          style: TextStyle(color: Colors.green[900]),
        ),
        trailing: Container(
          width: 150,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (KhaltiPaymentPage())));
            },
            child: Text("Place Order"),
            color: primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SingleDeliveryItem(
                    title:
                        "${widget.deliveryAddressList!.firstName} ${widget.deliveryAddressList!.lastName}",
                    addressType: widget.deliveryAddressList!.addressType!
                        .substring(13,
                            widget.deliveryAddressList!.addressType!.length),
                    address: widget.deliveryAddressList!.city,
                    number: widget.deliveryAddressList!.mobileNo),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                ExpansionTile(
                  title: Text(
                      "Order item ${reviewCartProvider.getReviewCartDataList.length}"),
                  children:
                      reviewCartProvider.getReviewCartDataList.map<Widget>((e) {
                    return OrderItem(e: e);
                  }).toList(),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Sub Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "\$${totalPrice}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Shipping Charge",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "${shipping}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Coupon discount",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "${discount}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Divider(
                  height: 1,
                  color: Colors.grey[500],
                ),
                ListTile(
                  leading: Text("Payment Options"),
                ),
                RadioListTile(
                  value: AddressTypes.Esewa,
                  groupValue: myType,
                  title: Text("Esewa"),
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
                  value: AddressTypes.Khalti,
                  groupValue: myType,
                  title: Text("Khalti"),
                  onChanged: (AddressTypes? value) {
                    setState(() {
                      myType = value;
                    });
                  },
                  secondary: Icon(
                    Icons.work,
                    color: primaryColor,
                  ),
                ), // RadioListTile
                RadioListTile(
                  value: AddressTypes.CashOnDelivery,
                  groupValue: myType,
                  title: Text("Cash on delivery"),
                  onChanged: (AddressTypes? value) {
                    setState(() {
                      myType = value;
                    });
                  },
                  secondary: Icon(
                    Icons.work,
                    color: primaryColor,
                  ),
                ), // RadioListTile
              ],
            );
          },
        ),
      ),
    );
  }
}
