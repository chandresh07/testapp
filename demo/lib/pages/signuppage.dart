
import 'dart:convert';
import 'package:http/http.dart' ;
import 'package:demo/pages/loginpage.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  final _formKey = GlobalKey<FormState>();

  String? validateEmail(String? email){
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if(!isEmailValid){
      return "please Enter valid email";
    }
    return null;
  }
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void  login(String email , password) async {
    try {
      Response response = await post(
          Uri.parse('https://reqres.in/api/register'),
          body: {
            'email': email,
            'password': password
          }
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Register successfully');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: "Enter Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: validateEmail,
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                        hintText: "Enter Password",
                      border: OutlineInputBorder()
                    ),

                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        login(emailcontroller.text.toString(), passwordcontroller.text.toString());
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => loginpage()));
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("Sign in"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }}
