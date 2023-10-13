import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void login(String email,password) async{

    try{
      Response response =await post(
        Uri.parse('https://reqres.in/api/login'),
        body:{
          'email':email,
          'password':password,
        }
      );

      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Account Create Succesfully');
      }else {
        print('failed');
      }

    }catch(e){
       print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:  true,
        title: Text('Log In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
                 controller: emailcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(30),right:Radius.circular(30)),
                ),
                fillColor: Colors.green,
                focusColor: Colors.purple,
              hintText: 'email'
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(30),right:Radius.circular(30)),
                  ),
                  fillColor: Colors.green,
                  focusColor: Colors.purple,
                  hintText: 'password'
              ),
            ),
            SizedBox(
              height: 48,
            ),
            GestureDetector(
              onTap: (){
                login(emailcontroller.text.toString(),passwordcontroller.text.toString());
              },
              child: Container(
                height:40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: Text('Sign Up')),
              ),
            )

          ],
        ),
      ),
    );
  }
}
