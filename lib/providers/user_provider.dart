//logic is connecting with firebase, and setting users data in table. Creating table if not
//already been created.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//cupertino is for changenotifier.
import 'package:flutter/cupertino.dart';
// import 'package:food_app/models/user_model.dart';

//changenotifier is a class that provides change notification to its listeners.
class UserProvider with ChangeNotifier {
  void addUserData({
    User? currentUser,
    String userName = '',
    String userImage = '',
    String userEmail = '',
  }) async {
    await FirebaseFirestore.instance
        .collection("usersData")
        .doc(currentUser?.uid)
        .set(
      {
        "userName": userName,
        "userEmail": userEmail,
        "userImage": userImage,
        "userUid": currentUser?.uid,
      },
    );
  }
}
