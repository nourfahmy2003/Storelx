import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storelx/Screens/home%20pages/Host_page.dart';
import 'Get_userdoc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final user = FirebaseAuth.instance.currentUser!;

  // List<String> DocIds = [];

  // Future getDocIds() async{
  //   await FirebaseFirestore.instance.collection('Users').get().then(
  //     (value) => value.docs.forEach((element) {
  //       print(element.reference);
  //       DocIds.add(element.reference.id);
  //     }) );
  // }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Storee page'),),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed In as: ' + user.email!),
            Text('Signed ID: ' + user.uid),

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
              MaterialButton(onPressed:() async{
                await UserManagement.toHost();
                 Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return hostPage();
                          }));
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