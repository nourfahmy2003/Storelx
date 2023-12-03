

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    _countryController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    super.dispose();
  }

  Future addhouseDetails(String uid, int price, String location, 
  String country, String city, String zipcode, int length, int width) async {
      await FirebaseFirestore.instance.collection('storages').add({
          'user_uid': user.uid,
          'price': price,
          'location': location,
          'city': city,
          'country':country,
          'zipcode':zipcode,
          'length':length,
          'width':width,
          'rented': false
        }
      );
    }
  void cleartexts(){
    _locationController.clear();
    _priceController.clear();
    _countryController.clear();
    _cityController.clear();
    _zipController.clear();
    _lengthController.clear();
    _widthController.clear();
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
              TextField(controller: _cityController,
                    decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'City',
                  ),),
                  TextField(controller: _countryController,
                    decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Country',
                  ),),
                  TextField(controller: _locationController,
                    decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Location',
                  ),),
                  TextField(controller: _zipController,
                    decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'zip code',
                  ),),
                TextField(keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _priceController,
                    decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Price',
                  ),),
                  TextField(keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _lengthController,
                    decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'length',
                  ),),
                  TextField(keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _widthController,
                    decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'width',
                  ),),
                  
              ElevatedButton(
              onPressed: () {
                // Get the price and location values from the form
                final price = int.parse(_priceController.text.trim());
                final location = _locationController.text.trim();
                final country = _countryController.text.trim();
                final city = _cityController.text.trim();
                final zipcode = _zipController.text.trim();
                final length = int.parse(_lengthController.text.trim());
                final width = int.parse(_widthController.text.trim());

                

                // Create a new house document with the user ID, price, and location
                addhouseDetails(user.uid,price,location,country,city
                ,zipcode,length,width);
                ;
                cleartexts();
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


