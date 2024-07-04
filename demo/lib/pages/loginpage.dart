


import 'dart:convert';
import 'package:demo/pages/homepage.dart';
import 'package:demo/pages/signuppage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class loginpage extends StatefulWidget {
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  final _formKey = GlobalKey<FormState>();

      String? validateEmail(String? email){
        RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
        final isEmailValid = emailRegex.hasMatch(email ?? '');
        if(!isEmailValid){
          return "please Enter valid email";
        }
        return null;
      }
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  Future<bool> login(String email , password) async {
    try {
      final response = await http.post(
          Uri.parse('https://reqres.in/api/login'),
          body: {
            'email': email,
            'password': password
          }
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login successfully');
        return data['success'] ?? false;
      } else {
        print('failed');
        throw Exception('failed to authenticate');
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                      hintText: "email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ) ,
                  ),
                  validator: validateEmail,
                ),
                SizedBox(height: 10,),
                TextFormField(
                  //obscureText: true,
                  controller: _passController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                      hintText: "password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      login(_emailController.text.toString(), _passController.text.toString());
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => homepage()));
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
                      child: Text("login"),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => signup()));
                    }, child: Text("Click Here"))
                  ],
                )
              ],
            ),
          ),
        ),
      ) ,
    );
  }
}
