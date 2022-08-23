import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:food_del/screens/home_screen/home_screen.dart';

class SignIn extends StatefulWidget {
  String? name;
  // if we use {} in constructor, that mean we have to use named parameter(eg: SignIn(name:'')) when we call this
  // constructor from another class or else. See code below:
  //if we dont use {} and just this.name, we can just call the constructor (eg: SignIn('abc'))
  // SignIn({this.name});

  // or
  // SignIn(this. name){};

  // OR
  // SignIn(name){
  // this.name = name;}

  // OR
  // named parameters
  //advantage: even if we call the constructor like SignIn() with no parameters, the construcotr below
  //will pass its default value to name parameter.
  SignIn({name: 'Welcome sir'}) {
    this.name = name;
  }

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future<User?> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);

      return user;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/login_bg.jpg'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Sign in to continue'),
                  Text(
                    'YOMMI',
                    style:
                        TextStyle(fontSize: 60, color: Colors.white, shadows: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.amber,
                        offset: Offset(3, 3),
                      )
                    ]),
                  ),
                  SignInButton(
                    Buttons.Apple,
                    text: "Sign in with Apple",
                    onPressed: () {},
                  ),
                  SignInButton(
                    Buttons.Google,
                    text: "Sign in with Google",
                    onPressed: () {
                      _googleSignUp().then((value) => Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => HomeScreen())));
                    },
                  ),
                  Text('By signing, you are agreesing to our'),
                  Text('Terms and Privacy Policy'),
                  Text('${widget.name}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
