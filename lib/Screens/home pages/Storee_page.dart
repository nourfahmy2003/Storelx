import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storelx/Screens/get_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final user = FirebaseAuth.instance.currentUser!;

  List<String> DocIds = [];

  Future getDocIds() async{
    await FirebaseFirestore.instance.collection('Users').get().then(
      (value) => value.docs.forEach((element) {
        print(element.reference);
        DocIds.add(element.reference.id);
      }) );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed In as: ' + user.email!),
            Text('Signed ID: ' + user.uid),
              // StreamBuilder(
              // stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('storages').snapshots(),
              //   builder: (context, snapshot) {
              //     return Expanded(
              //       child: Container(
              //         color: Colors.black45,
              //         width: double.infinity,
              //         child: ListView(
              //         children: snapshot.data!.docs.map((DocumentSnapshot document) {
              //           Map<String, dynamic> data = document.data() as Map<String, dynamic>;

              //           // Access fields of each document
              //           String field1 = data['price'];
              //           String field2 = data['Country'];

              //           return ListTile(
              //             title: Text('Field1: $field1'),
              //             subtitle: Text('Field2: $field2'),
              //           );
              //         }).toList(),
                      
              //     )
              //     )
              //     );
              //   }
              // ),

            MaterialButton(onPressed:() {
              FirebaseAuth.instance.signOut();
              },
              color: Colors.red,
              child: Text('Sign out'),
              ),
              MaterialButton(onPressed:(){
              user.delete();
              },
              color: Colors.red,
              child: Text('Delete Account'),
              ),
              MaterialButton(onPressed:() {
              FirebaseFirestore.instance.collection('Users')
              .doc(user.uid).update({'Host': true});

              },
              color: Colors.red,
              child: Text('Turn to Host'),
              ),
          ],
        )
        ),
      ),
    );
  }
}