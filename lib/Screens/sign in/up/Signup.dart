import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignupPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignupPage({Key? key, required this.showLoginPage}) : super(key: key);
  
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phonenumberController = TextEditingController();

  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phonenumberController.dispose();
    super.dispose();
  }
 Future addUserDetails(String uid, String firstname, String lastname, 
 String email, String number) async {
    await FirebaseFirestore.instance.collection('Users').add({
        'uid': uid,
        'first name': firstname,
        'last name': lastname,
        'Email': email,
        'Phone number': number,
        'Host': false
      }
    );
  }
    bool passConfirmed() {
  return _confirmPassController.text.trim() == _passwordController.text.trim();
  }
  Future signUp() async{
      try{
      if(passConfirmed()){
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          String uid = userCredential.user!.uid;

          addUserDetails(
              uid,
              _firstNameController.text.trim(),
              _lastNameController.text.trim(),
              _emailController.text.trim(),
              _phonenumberController.text.trim());
      }
      }
      catch (e){
        print(e);
        showDialog(context: context,
         builder: (context){
          return AlertDialog(
            content: Text(e.toString()),
          );
         });
      }
  }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.grey[200],
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center( 
          child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Register Now',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),

            //first Name text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.only(left: 12),
                      margin: EdgeInsets.only(right: 10),
                      
                      child: SizedBox(
                        
                        width: 155,
                        height: 50,
                        child: TextField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            
                            border: InputBorder.none,
                            hintText: 'First Name',
                          ),
                        ),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.only(left: 12),
                      child: SizedBox(
                        width: 155,
                        height: 50,
                        child: TextField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Last Name',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


            SizedBox(height: 10),
            
            //Email text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(padding: EdgeInsets.only(left: 20),
                child: TextField(
                  controller: _phonenumberController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                  ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
            
            //Email text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(padding: EdgeInsets.only(left: 20),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            //Password text 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(padding: EdgeInsets.only(left: 20),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                  ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            
            //Confirm Password text field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(padding: EdgeInsets.only(left: 20),
                child: TextField(
                  controller: _confirmPassController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Confirm Password',
                  ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            //sign up button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: signUp,
                child: Container(
                  decoration: BoxDecoration(color: Colors.red,
                  borderRadius: BorderRadius.circular(30),),
                  padding: EdgeInsets.fromLTRB(20,10,20,10),
                  
                  child: Center(
                    // onPressed: () {
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                    // },
                    child: Text('Sign Up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 18),),
                    
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            
            //Sign up button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('I am a member,'),
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: Text(' Login now', 
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700
                    )
                  ),
                )
              ],
            ),
          ],
          ),
        ),
      ),
    ),
    );
  }
} 

