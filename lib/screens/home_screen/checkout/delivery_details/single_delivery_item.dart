import 'package:flutter/material.dart';
import 'package:food_del/config/colors.dart';

class SingleDeliveryItem extends StatelessWidget {
  String? title;
  String? address;
  String? number;
  String? addressType;
  SingleDeliveryItem({this.title, this.addressType, this.address, this.number});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title.toString()),
              Container(
                width: 60,
                padding: EdgeInsets.all(1),
                height: 23,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    addressType.toString(),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: CircleAvatar(
            radius: 9,
            backgroundColor: primaryColor,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address.toString()),
              SizedBox(
                height: 5,
              ),
              Text(number.toString()),
            ],
          ),
        ),
        Divider(
          height: 35,
        ),
      ],
    );
  }
}
