import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


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

  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }
  Future signUp() async {
  try {
    if (_confirmPassController.text.trim() == _passwordController.text.trim()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Passwords do not match'),
          );
        },
      );
    }
  } catch (e) {
    // Check if the error is due to the email already being in use
    if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Email is already in use'),
          );
        },
      );
    } else {
      // Handle other errors if needed
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('An error occurred'),
          );
        },
      );
    }
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

