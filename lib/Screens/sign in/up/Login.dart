import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:storelx/Screens/Auth/Signup.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future signIn() async{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(), 
        password: _passwordController.text.trim());
  }
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center( 
          child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
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
                  border: Border.all(color: Colors.black87,),
                  borderRadius: BorderRadius.circular(10),
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
            SizedBox(height: 5),

            //Password text 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87,),
                  borderRadius: BorderRadius.circular(10),
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
            SizedBox(height: 5),
            
            //sign In button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: signIn,
                child: Container(
                  decoration: BoxDecoration(color: Colors.red,
                  borderRadius: BorderRadius.circular(30),),
                  padding: EdgeInsets.fromLTRB(20,10,20,10),
                  
                  child: Center(
                    child: Text('Sign In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 18),),
                    
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            
            //Sign up button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member?'),
                GestureDetector(
                  onTap: widget.showRegisterPage,
                  child: Text(' Register now', 
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
