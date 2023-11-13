import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/provider.dart';



class FireStoreServices {

  FireStoreServices(this.ref);

  Ref ref;

  Future<bool> saveUserData({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        await firestore.collection("users").doc(userId).set({
          'Name': name,
          'Email': email,
          'Phone': phone,
          'Password': password,
        });

        return true;
      }



      return false;
    } catch (e) {
      return false;
    }
  }

  saveNotifications() async {
    //
    // await FirebaseFirestore.instance.collection('notifications').add({
    //   'title': title,
    //   'body': body,
    //   'timestamp': FieldValue.serverTimestamp(),
    // });
  }


  void getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    print(user?.uid);

    if (user != null) {
      String userId = user.uid;

      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userData.exists) {
        // Check if data exists before attempting to cast
        Map<String, dynamic>? userMap = userData.data() as Map<String, dynamic>?;

        if (userMap != null) {

          ref.read(userDataProvider.notifier).state = userMap;
        } else {
          print('getUserData method: User data is null');
        }
      } else {
        print('getUserData method: User data not found');
      }
    }
  }




}
