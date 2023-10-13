import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
var data;
  Future<void>getUserApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users')) ;
     if(response.statusCode == 200){
       data = jsonDecode(response.body.toString());
     }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: Text('Example Four'),
       ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Text('Loading ......');
                  } else {
                    //return //Text(data[0]['name'].toString());
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context,index){
                      return Card(
                        child: Column(
                          children: [
                            RowUseable(title: 'Title', value: data[index]['name'].toString()),
                            RowUseable(title: 'Username', value: data[index]['username'].toString()),
                            RowUseable(title: 'Address', value: data[index]['address']['street'].toString()),
                            RowUseable(title: 'Lat', value: data[index]['address']['geo']['lat'].toString()),
                            RowUseable(title: 'Lat', value: data[index]['address']['geo']['lng'].toString()),
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