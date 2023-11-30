import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String docId;

  GetUserName({required this.docId});



  @override
  Widget build(BuildContext context) {
    CollectionReference users = 
    FirebaseFirestore.instance.collection('Users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(docId).get(),
      builder: ((context, snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        Map<String, dynamic> data = 
        snapshot.data!.data() as Map<String, dynamic>;
        return Text('First Name: ${data['first name']}');
      }
      return Text('...Loading');
    }),
    
    );
  }
}

