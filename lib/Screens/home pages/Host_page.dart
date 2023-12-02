

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storelx/Screens/home%20pages/Storee_page.dart';

import 'Get_userdoc.dart';

class hostPage extends StatefulWidget {
  const hostPage({super.key});

  @override
  State<hostPage> createState() => _hostPageState();
}

class _hostPageState extends State<hostPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  @override
  void dispose(){
    _locationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future addhouseDetails(String uid, String firstname, String lastname, 
  String email, String number) async {
      await FirebaseFirestore.instance.collection('Users').add({
          'uid': uid,
          'first name': firstname,
          'last name': lastname,
          'Email': email,
          
          'rented': false
        }
      );
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Host page'),),
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
                await UserManagement.toStoree();
                Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return HomePage();
                          }));
              },
              color: Colors.red,
              child: Text('Turn to Storee'),
              ),
              ElevatedButton(
              onPressed: () {
                // Get the user ID from the current user
                // final userId = FirebaseAuth.instance.currentUser.uid;

                // Get the price and location values from the form
                final price = _priceController.text.trim();
                final location = _locationController.text.trim();
                final country = _countryController.text.trim();
                final city = _cityController.text.trim();

                // Create a new house document with the user ID, price, and location
                FirebaseFirestore.instance.collection('storages').add({
                  // 'user_id': userId,
                  'price': price,
                  'location': location,
                }).then((value) {
                  print('House added successfully!');
                }).catchError((error) {
                  print('Error adding house: $error');
                });
              },
              child: Text('Add House'),
            ),
          ],
        )
        ),
      ),
    );
  }
}


