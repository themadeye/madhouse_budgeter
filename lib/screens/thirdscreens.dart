
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget{

  @override
  State createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}