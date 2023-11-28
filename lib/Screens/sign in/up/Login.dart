import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storelx/Screens/sign%20in/up/ForgotPass.dart';
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
    return Scaffold( backgroundColor: Colors.grey[200],
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
                  border: Border.all(color: Colors.white,),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(padding: EdgeInsets.only(left: 20) 
                ,
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
            
            //Forgot Password button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return forgotPassPage();
                          }
                        )
                      );
                    },
                    child: Text('Forgot password?',
                    style: TextStyle(color: Colors.blue[400],
                    fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
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
