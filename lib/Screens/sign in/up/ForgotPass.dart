import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgotPassPage extends StatefulWidget {
  const forgotPassPage({super.key});

  @override
  State<forgotPassPage> createState() => _forgotPassPageState();
}

class _forgotPassPageState extends State<forgotPassPage> {

    final _emailController = TextEditingController();

    void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
      email: _emailController.text.trim());
      showDialog(context: context,
         builder: (context){
          return AlertDialog(
            content: Text('Password reset link sent to email.'),
          );
         });
      } on FirebaseAuthException catch (e) {
        print(e);
        showDialog(context: context,
         builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
         });
      }

    }
    
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
        appBar: AppBar(backgroundColor: Colors.red),
        body: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter your Email to reset password',
            style: TextStyle(fontSize: 20),),
            SizedBox(height: 10),

            //Email Text field
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
            MaterialButton(onPressed: passwordReset,
            child: Text('Reset password', 
            style: TextStyle(fontWeight: FontWeight.w600),
            ),
            color: Colors.red,
            )
          ],
        )
    );
  }
}