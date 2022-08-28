import 'package:flutter/material.dart';
import 'package:food_del/providers/check_out_provider.dart';
import 'package:food_del/providers/product_provider.dart';
import 'package:food_del/providers/reveiw_cart_provider.dart';
import 'package:food_del/providers/wishlist_provider.dart';
import 'package:food_del/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'auth/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_del/screens/home_screen/home_screen.dart';
import 'package:food_del/config/colors.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Multiprovider is a class that contains providers we are using in this app.
    return KhaltiScope(
        publicKey: "test_public_key_30e12814fed64afa9a7d4a92a2194aeb",
        builder: (context, navigatorKey) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ProductProvider>(
                create: (context) => ProductProvider(),
              ),
              ChangeNotifierProvider<UserProvider>(
                create: (context) => UserProvider(),
              ),
              ChangeNotifierProvider<ReviewCartProvider>(
                create: (context) => ReviewCartProvider(),
              ),
              ChangeNotifierProvider<WishListProvider>(
                create: (context) => WishListProvider(),
              ),
              ChangeNotifierProvider<CheckoutProvider>(
                create: (context) => CheckoutProvider(),
              ),
            ],
            child: MaterialApp(
              navigatorKey: navigatorKey,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              theme: ThemeData(
                primaryColor: primaryColor,
                scaffoldBackgroundColor: scaffoldBackgroundColor,
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        });
  }
}
