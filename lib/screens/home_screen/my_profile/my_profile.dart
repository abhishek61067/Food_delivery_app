import "package:flutter/material.dart";
import 'package:food_del/config/colors.dart';
import "package:food_del/screens/home_screen/drawer_side.dart";

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget listTile({IconData? icon, String? title}) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title.toString()),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: DrawerSide(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "My profile",
          style: TextStyle(
            fontSize: 15,
            color: textColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                color: primaryColor,
              ),
              Container(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 250,
                          height: 80,
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Abhishek Bhattarai",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Abhishek.bhattarai@gmail.com"),
                                ],
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: primaryColor,
                                child: CircleAvatar(
                                  radius: 12,
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                  ),
                                  backgroundColor: scaffoldBackgroundColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    listTile(
                      icon: Icons.shop_outlined,
                      title: "My Orders",
                    ),
                    listTile(
                      icon: Icons.location_on_outlined,
                      title: "My delivery address",
                    ),
                    listTile(
                      icon: Icons.person_outline,
                      title: "Refer friends",
                    ),
                    listTile(
                      icon: Icons.file_copy_outlined,
                      title: "Terms & conditions",
                    ),
                    listTile(
                      icon: Icons.policy_outlined,
                      title: "Privacy Policy",
                    ),
                    listTile(
                      icon: Icons.add_chart_outlined,
                      title: "About",
                    ),
                    listTile(
                      icon: Icons.exit_to_app_outlined,
                      title: "Log Out",
                    ),
                  ],
                ),
                height: 500,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 30,
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: scaffoldBackgroundColor,
                backgroundImage: NetworkImage(
                    "https://cdn2.iconfinder.com/data/icons/people-flat-design/64/Face-Profile-User-Man-Boy-Person-Avatar-512.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
