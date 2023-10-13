import 'dart:convert';

import 'package:api/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Exampletwo extends StatefulWidget {
  const Exampletwo({super.key});

  @override
  State<Exampletwo> createState() => _ExampletwoState();
}

class _ExampletwoState extends State<Exampletwo> {
  List<UserModel> userlist=[];
  Future<List<UserModel>> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users')) ;
    var data= jsonDecode(response.body.toString());
    if(response.statusCode ==200){
      for(Map i in data){
        userlist.add(UserModel.fromJson(i));

      }
      return userlist;
    }else{
      return userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Example 2 '),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<UserModel>>snapshot){
                  /// null kre dite hoy snapshot !
                 if(!snapshot.hasData){
                   return CircularProgressIndicator();
                 }else {
                   return ListView.builder(
                     itemCount: userlist.length,
                       itemBuilder: (context,index){
                         return Card(
                           child: Column(
                             children: [
                               Text(snapshot.data![index].name.toString()),
                               RowUseable(title: 'Title', value: snapshot.data![index].name.toString()),
                               RowUseable(title: 'Username', value: snapshot.data![index].username.toString()),
                               RowUseable(title: 'Address', value: snapshot.data![index].address!.geo!.lat.toString()
                               ),
                             ],
                           ),
                         );
                       });
                 }
                }),
          )
        ],
      ),
    );
  }
}

class RowUseable extends StatelessWidget {
  String title,value;
   RowUseable({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text(value),
           Text(title)
         ],
      ),
    );
  }
}
