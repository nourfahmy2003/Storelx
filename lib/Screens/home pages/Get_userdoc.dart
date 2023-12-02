import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManagement {
  // Changes host field to true so user becomes host
  static Future<void> toHost() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get the document ID for the user's UID
        String userDocumentId = await getUserDocumentId(user.uid);

        if (userDocumentId.isNotEmpty) {
          // Update the document with 'Host' field set to true
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userDocumentId)
              .update({'Host': true});

          print("Update successful!");
        } else {
          print("User document not found");
        }
      } else {
        print("User not authenticated");
      }
    } catch (e) {
      print("Error updating document: $e");
    }
  }

  // Changes host field to false so user becomes a regular user
  static Future<void> toStoree() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get the document ID for the user's UID
        String userDocumentId = await getUserDocumentId(user.uid);

        if (userDocumentId.isNotEmpty) {
          // Update the document with 'Host' field set to false
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userDocumentId)
              .update({'Host': false});

          print("Update successful!");
        } else {
          print("User document not found");
        }
      } else {
        print("User not authenticated");
      }
    } catch (e) {
      print("Error updating document: $e");
    }
  }

  // Get user document id
  static Future<String> getUserDocumentId(String userUid) async {
    try {
      // Query Firestore to get the document ID for the given UID
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: userUid)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;
      } else {
        return ''; // Return an empty string if the user document is not found
      }
    } catch (e) {
      print("Error getting user document ID: $e");
      return '';
    }
  }
}
