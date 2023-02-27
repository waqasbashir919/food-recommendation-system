import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
// Upload user profile to cloud firestore
  uploadUserInfo(userInfo) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users/$uid/userProfile')
        .doc('$uid+1')
        .set(userInfo);
  }

// Delete account and all data of current user from cloud firestore
  deleteAccount() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users/$uid/userProfile')
        .doc('$uid+1')
        .delete();
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    FirebaseAuth.instance.currentUser!.delete();
  }

  // Upload user activities to cloud firestore
  uploadUserActivity(userActivityInfo) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users/$uid/userActivity')
        .doc()
        .set(userActivityInfo);
  }
}
