import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_del/auth/sign_in.dart';
import 'package:food_del/config/colors.dart';
import 'package:food_del/screens/home_screen/home_screen.dart';
import 'package:food_del/screens/home_screen/my_profile/my_profile.dart';
import 'package:food_del/screens/home_screen/review_cart/review_cart.dart';
import 'package:food_del/screens/home_screen/wish_list/wish_list.dart';

class DrawerSide extends StatelessWidget {
  // const DrawerSide({Key? key}) : super(key: key);

  VoidCallback? onPressed; // Good

//function listTile starts
  Widget listTile({IconData? icon, String? title, onPressed}) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(
        icon,
        size: 32,
      ),
      title: Text(
        title.toString(),
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }

//function listTile ends
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 100,
        color: Color(0xffD2AD17),
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 43,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.yellow,
                      child: Image.network(
                          'https://cdn2.iconfinder.com/data/icons/people-flat-design/64/Face-Profile-User-Man-Boy-Person-Avatar-512.png'),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Welcome guest'),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          height: 30,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                              );
                            },
                            child: Text('Login'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                width: 1,
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            // listTile(Icons.arrow_drop_down, "Home"),

            //listview starts
            listTile(
                icon: Icons.home_outlined,
                title: "Home",
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            listTile(
              icon: Icons.shop_outlined,
              title: "Review Cart",
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReviewCart()));
              },
            ),
            listTile(
                icon: Icons.person_outlined,
                title: "My profile",
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyProfile()));
                }),
            listTile(icon: Icons.notifications_outlined, title: "Notification"),
            listTile(icon: Icons.star_outlined, title: "Rating"),
            listTile(
                icon: Icons.favorite_outlined,
                title: "Wishlist",
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WishList()));
                }),
            listTile(icon: Icons.format_quote_outlined, title: "FAQ"),
            listTile(
                icon: Icons.logout_rounded,
                title: "Log Out",
                onPressed: () async {
                  //to signout from firebase
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  await auth.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignIn()));
                }),

            // footer starts
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text('Contact Support'),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Call Us:     '),
                      Text("9861***"),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    // scrollDirection: Axis.vertical,
                    child: Row(children: [
                      Text('Mail Us:    '),
                      Text('abhishek.bhattarai61067@gmail.com'),
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
