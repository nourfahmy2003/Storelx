import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final user = FirebaseAuth.instance.currentUser!;

  List<String> Docid = [];

  Future getDocIds() async{
    await FirebaseFirestore.instance.collection('Users').get().then(
      (value) => value.docs.forEach((element) {
        print(element.reference);
        Docid.add(element.reference.id);
      }) );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Signed In as: ' + user.email!),
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
            Expanded(
              child: FutureBuilder(
                future: getDocIds(),
                builder: (context, index) {
                  return ListView.builder(
                    itemCount: Docid.length,
                    itemBuilder: (context, index){
                    return ListTile(
                      title: Text(Docid[index]),
                    );
                  }
                  );
                }
              )
          )
        ],
      )
      ),
    );
  }
}