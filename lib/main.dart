import 'package:flutter/material.dart';
import 'package:food_del/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'auth/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_del/screens/home_screen/home_screen.dart';
import 'package:food_del/config/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
