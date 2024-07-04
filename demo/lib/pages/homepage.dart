
import 'dart:convert';
import 'package:demo/model/homemodel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  Future<Homemodel> getUsersApi ()async{
    final response  = await http.get(Uri.parse('https://reqres.in/api/unknown'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      print(data);
      return Homemodel.fromJson(data);
    }else{
      return Homemodel.fromJson(data);
    }

  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar:  AppBar(
       backgroundColor: Colors.lightBlueAccent,
       title: Text("home page"),
       centerTitle: true,
     ),
     body: Column(
       children: [
         Expanded(
           child: FutureBuilder<Homemodel>(
               future: getUsersApi(),
               builder: (context,snapshot){
                 if(snapshot.hasData){
                   return ListView.builder(
                     shrinkWrap: true,
                       itemCount: snapshot.data!.data!.length,
                       itemBuilder: (context, index){
                         return Card(
                           elevation: 5,
                           shadowColor: Colors.lightBlueAccent,
                           child: ListTile(
                             leading: Text(snapshot.data!.data![index].id.toString()),
                             title: Text(snapshot.data!.data![index].name.toString()),
                             subtitle: Text(snapshot.data!.data![index].year.toString()),
                             trailing: Text(snapshot.data!.data![index].pantoneValue.toString()),
                           ),
                         );
                       });
                 }else{
                   return Center(child: CircularProgressIndicator());
                 }
               }
           ),
         )
       ],
     )
   );
  }}
